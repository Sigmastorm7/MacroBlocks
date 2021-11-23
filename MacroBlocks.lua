local addon, mb = ...
local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEAVING_WORLD")
frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")


SLASH_PRINT1 = "/print"
SlashCmdList["PRINT"] = function(msg, editBox)
	SlashCmdList.SCRIPT("print("..msg..")")
end

mb.User = { ["class"] = {}, ["spec"] = {}, ["talents"] = {} }
mb.GetUser = function()
	local className, classFileName, classID = UnitClass(PLAYER)
	local specID = GetSpecialization()
	local specEngineID, specName, _, specIcon, specRole = GetSpecializationInfo(specID)
	mb.User.class = {
			["id"] = classID,
			["name"] = className,
			["fileName"] = classFileName,
		}
	mb.User.spec = {
			["id"] = specID,
			["name"] = specName,
			["icon"] = specIcon,
			["role"] = specRole,
		}

	local selected
	for i=1, 7 do
		mb.User.talents[i] = {}
		for j=1, 3 do
			_, _, _, selected = GetTalentInfoBySpecialization(specID, i, j)
			mb.User.talents[i][j] = selected
		end
	end
end

local mb_init = false

mb.Frame = CreateFrame("Frame", "MacroBlocks", MacroFrame)

mb.Palette = CreateFrame("Frame", "$parentPaletteBasic", mb.Frame, "InsetFrameTemplate")

mb.Palette.name = "Palette"
mb.Palette.blocks = {}

mb.Stack = CreateFrame("Frame", "$parentStack", mb.Frame, "BackdropTemplate")
mb.Stack:SetBackdrop(mb.stackBackdrop)
mb.Stack.Instructions = mb.Stack:CreateFontString("$parentInstructions", "ARTWORK")
mb.Stack.Instructions:SetPoint("CENTER")
mb.Stack.Instructions:SetFontObject("MacroBlocksFont_Large")
mb.Stack.Instructions:SetText("Drag & Drop Blocks Here")

mb.Stack.name = "Stack"
mb.Stack.blocks = {}
mb.Stack.sTable = {}
mb.Stack.string = ""

mb.Stack.displace = false
mb.Stack.displaceID = 0

mb.Stack.preserve = false
mb.Stack.payloadTable = {}

mb.Stack.blockFlags = {}

mb.BlockPools = CreateFramePoolCollection()

local templates = {
	{ ["name"] = "MacroBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "SocketBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "EditBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "ChoiceBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "TalentBlockTemplate", ["type"] = "Frame" },
}

for i=1, #templates do
	mb.BlockPools:CreatePool(templates[i].type, mb.Palette, templates[i].name)
end

local function resizeBlock(block)
	local strWidth = block.text:GetStringWidth() + 18
	if strWidth > 28 then
		block:SetWidth(strWidth)
	else
		block:SetWidth(28)
	end
end

mb.GetFlags = function(block)
	local str = strjoin("-", block.group, block.paletteIndex, block.paramIndex)

	if block.label then str = str.."-"..block.label end
	-- if block.config then
		if block.value then str = str.."-"..block.value end
		if block.itemType then str = str.."-"..block.itemType end
	-- end

	return str
end

mb.LogicPlacement = function(block)

	local n = block.param.name
	local p = block.param
	local b = false

	if mb.Stack.displace then
		if strfind(p.payload, ">") then
			b = b or mb.Stack.blocks[mb.Stack.displaceID].group == "CON"
			b = b or (mb.Stack.blocks[mb.Stack.displaceID].group == "TAR" and n == "and")
		end
		if strfind(p.payload, "<") then
			b = b or mb.Stack.blocks[mb.Stack.displaceID-1].group == "CON"
			b = b or mb.Stack.blocks[mb.Stack.displaceID-1].group == "TAR"
		end
	elseif #mb.Stack.blocks > 0 then
		if strfind(p.payload, "<") then
			b = b or mb.Stack.blocks[#mb.Stack.blocks].group == "CON"
			b = b or mb.Stack.blocks[#mb.Stack.blocks].group == "TAR"
		end
	end

	return b
end

mb.GetAbilityInfo = function(itemType, itemID, mountID, spellID)
	local abilityID, payload, iconID

	if itemType == "spell" then
		abilityID = spellID
		payload, _, iconID = GetSpellInfo(spellID)
	elseif itemType == "item" then
		abilityID = itemID
		payload = "item:"..abilityID
		iconID = C_Item.GetItemIconByID(itemID)
	elseif itemType == "mount" then
		abilityID = itemID
		payload, _, iconID = C_MountJournal.GetMountInfoByID(itemID)
	elseif itemType == "battlepet" then
		local petInfo = C_PetJournal.GetPetInfoTableByPetID(itemID)
		abilityID = itemID
		payload = petInfo.name
		iconID = petInfo.icon
	end

	return abilityID, payload, itemType, iconID
end

mb.MakeBlock = function(str) -- group, paletteIndex, paramIndex, label, value, itemType)

	local group, paletteIndex, paramIndex, label, value, itemType = strsplit("-", str)

	paletteIndex = tonumber(paletteIndex)
	paramIndex = tonumber(paramIndex)

	local param = mb.BasicBlocks[group][paramIndex]

	local block = mb.BlockPools:Acquire(param.template or "MacroBlockTemplate")

	local name = param.name

	if param.config then

		local config = param.config

		if strfind(value, "%d+") and not strfind(value, "%d/%d") then value = tonumber(value) end

		if value then config.value = value end
		if itemType then config.itemType = itemType end

		if group == "CON" then

			local bc

			block.backdropFrame.text:SetText(name)
			block.backdropFrame:SetWidth(block.backdropFrame.text:GetStringWidth() + 18)

			block:SetWidth(block.backdropFrame:GetWidth() + 18)

			block.closeWidth = block:GetWidth()
			block.openWidth = 18

			if param.label == "MOD" then

				local itr = 1

				for mod, state in pairs(config.buttons) do
					bc = block["choice"..itr]

					bc.text:SetText(config.mods[mod])
					bc.text:SetTextColor(unpack(config.textColor[state]))

					bc.enabled = state
					if itr == 3 then
						bc.value = itr + 1
					else
						bc.value = itr
					end

					bc:SetWidth(bc.text:GetStringWidth())
					bc:Hide()

					block.openWidth = block.openWidth + bc:GetWidth()

					itr = itr + 1
				end

				for i=1, 6 do
					bc = block["choice"..i]

					if bc.value == 0 then
						bc:Disable()
						bc:Hide()
						bc:ClearAllPoints()
					end
				end

				block.value = tostring(config.value)
				block.payload = config.modCombos[config.value]

			elseif param.label == "SPEC" then

				if value == 0 then
					value = GetSpecialization()
				end

				local specNum = GetNumSpecializations()
				local preset = false

				for i=1, 6 do
					bc = block["choice"..i]

					if i > specNum then
						bc:Disable()
						bc:Hide()
						bc:ClearAllPoints()

						if config.buttons[i] ~= nil then config.buttons[i] = nil end
					end
				end

				local specCheck
				for i, state in ipairs(config.buttons) do

					local _, specName = GetSpecializationInfo(i)
					specCheck = i == value
					bc = block["choice"..i]

					bc.text:SetText(specName)
					bc.text:SetTextColor(unpack(config.textColor[specCheck]))

					config.buttons[i] = specCheck
					bc.enabled = specCheck
					bc.value = i

					bc:SetWidth(bc.text:GetStringWidth())
					bc:Hide()

					block.openWidth = block.openWidth + bc:GetWidth()
				end

				block.value = value
				config.value = value
				param.payload = "[spec:"..value.."]"

			elseif param.label == "TALENT" then

				if config.spec == 0 then config.spec = GetSpecialization() end

				local tIcon, tStr, tBool
				local _, _, r, c = strfind(value, "(%d)/(%d)")
				r = tonumber(r)
				c = tonumber(c)

				for i=1, 7 do
					for j=1, 3 do

						_, _, tIcon = GetTalentInfoBySpecialization(config.spec, i, j)
						bc = block["row"..i]["btn"..j]
						tStr = i.."/"..j
						tBool = i == r and j == c

						bc:SetHighlightAtlas("ChromieTime-Button-Selection")

						bc.icon:SetTexture(tIcon)
						bc.icon:SetDesaturated(not tBool)
						bc.icon:SetAlpha(config.iconAlpha[tBool])

						bc.talentID:SetText(tStr)
						bc.talentID:SetTextColor(unpack(config.textColor[tBool]))

						bc.selected:SetShown(tBool)

						bc.value = tStr

					end
				end

				block.value = value
				block.payload = "[talent:"..value.."]"

				block.openWidth = 102

				block:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
				block:SetScript("OnEvent", function(self, event, arg)
					if event == "PLAYER_SPECIALIZATION_CHANGED" then

						config.spec = GetSpecialization()

						for i=1, 7 do
							for j=1, 3 do

								local _, _, talentIcon = GetTalentInfoBySpecialization(config.spec, i, j)
								bc = self["row"..i]["btn"..j]

								bc.icon:SetTexture(talentIcon)

							end
						end
					end
				end) -- function end

			end

		elseif group == "USR" then

			if label == "SOCKET" then

				local btn = block.socket
				local iconID

				block.value = value
				block.itemType = itemType

				_, block.payload, _, iconID = mb.GetAbilityInfo(itemType, value, nil, value)

				btn.icon:SetTexture(iconID)

			elseif label == "EDIT" then

				block.value = value
				block.payload = value

				if value ~= "{empty}" then
					block.edit:SetText(value)
				else
					block.edit:SetText("")
				end

			end

		end

		block.config = config

	else

		if param.symbol then
			block.text:SetFontObject("MacroBlocksSymbolFont")
			block.text:SetPoint("CENTER", 0, -3)
		end

		block.text:SetText(name)
		resizeBlock(block)

	end

	block.group = group
	block.paletteIndex = paletteIndex
	block.paramIndex = paramIndex

	block.payload = block.payload or param.payload
	block.param = param

	if label then block.label = label end

	block:SetBackdrop(mb.blockBackdrop)
	block:SetBackdropColor(unpack(mb.GroupColors[group].rgb))
	block:SetBackdropBorderColor(unpack(mb.GroupColors[group].rgb))

	block:Show()

	return block

end

mb.EraseBlock = function(block)

    if block.config and (block.group == "CON" or block.group == "USR") then
        mb.ResetBlock(block)
    end

	block.saved = false
    block.InStack = false

	mb.BlockPools:Release(mb.Palette.blocks[block.paletteIndex])
    mb.Palette.blocks[block.paletteIndex] = block
	mb.Palette:Adjust()
	mb.Stack:Adjust()
end

mb.FillStack = function(selected)
	local flags

	if selected <= 120 then
		flags = mb.UserBlocks[selected]
	else
		flags = mb.UserBlocks[selected][mb.Char]
	end

	if flags and #flags > 0 then
		for i, flag in ipairs(flags) do
			mb.Stack:addBlock(mb.MakeBlock(flag))
		end
	end
end

mb.EmptyStack = function()

end

local function delimSwitch(index, block)
	local bool = false

	local BID = block.group
	local LBID = ""
	if index > 1 then LBID = mb.Stack.blocks[index-1].group end

	bool = bool or block.param.label == "RETURN"
	bool = bool or block.param.label == "SEMICLN"
	bool = bool or index == 1
	bool = bool or #mb.Stack.blocks == 1
	bool = bool or (BID == "LOG" or BID == "CON" or BID == "TAR") and (LBID == "LOG" or LBID == "CON" or LBID == "TAR")
	bool = bool or block.stackOffset.x == 7

	if bool then return "" else return " " end

end

function UpdateMacroBlockText()

	if not mb_init or mb.Stack.preserve then return end

	local delim = ""

	mb.Stack.string = ""

	for i, str in pairs(mb.Stack.payloadTable) do
		delim = delimSwitch(i, mb.Stack.blocks[i])
		mb.Stack.string = mb.Stack.string..delim..str
	end

	mb.Stack.string = gsub(mb.Stack.string, "%$!>%[", "%[no")
	mb.Stack.string = gsub(mb.Stack.string, "%]<%$&>%[", ", ")

	MacroFrameText.blockInput = true
	MacroFrameText:SetText(mb.Stack.string)
end

mb.Palette.Adjust = function(self, group, index, xOff, yOff)

	group = group or "CMD"
	index = index or 1
	xOff = xOff or 6
	yOff = yOff or -6

	if index <= #self.blocks then

		-- if self.blocks[index].config then DevTools_Dump(self.blocks[index].config) end

		if self.blocks[index].group ~= group and self.blocks[index].group ~= "LOG" then
			xOff = 6
			yOff = yOff - 28.5
			group = self.blocks[index].group
		end

		if (xOff + self.blocks[index]:GetWidth()) >= (self:GetWidth() - 4) then
			xOff = 6
			yOff = yOff - 28.5
		end

		self.blocks[index]:ClearAllPoints()
		self.blocks[index]:SetPoint("TOPLEFT", self, "TOPLEFT", xOff, yOff)
		xOff = xOff + self.blocks[index]:GetWidth()

		self:Adjust(group, index + 1, xOff, yOff)
	else
		return
	end
end

mb.Stack.Adjust = function(self, index, xOff, yOff)

	index = index or 1
	xOff = xOff or 7
	yOff = yOff or -6

	if index <= #self.blocks then

		if (xOff + self.blocks[index]:GetWidth()) >= (self:GetWidth() - 6) then
			xOff = 7
			yOff = yOff - 30
		end

		if index == self.displaceID and self.displace then
			xOff = xOff + 32
		end

		if self.blocks[index].socket then xOff = xOff + 2 end

		self.blocks[index]:ClearAllPoints()
		self.blocks[index]:SetPoint("TOPLEFT", self, "TOPLEFT", xOff, yOff)
		self.blocks[index].stackOffset = { ["x"] = xOff, ["y"] = yOff }
		xOff = xOff + self.blocks[index]:GetWidth()

		-- Creates a new line if the updated block is utility block with the NEWLINE flag
		if self.blocks[index].param.label then
			if self.blocks[index].param.label == "RETURN" then
				xOff = self:GetWidth() - 6
			end
		end

		self:Adjust(index + 1, xOff, yOff)
	else
		UpdateMacroBlockText()
		return
	end
end

function StackDisplaceCheck(self)
	if not self:IsMouseOver() then return end

	local bool = false
	local dis = 0

	if #self.blocks == 0 then return end

	for index, block in pairs(self.blocks) do
		if block.displaced then dis = 32 end
		if block:IsMouseOver(0, 0, -(16+dis), -block:GetWidth()+16) then
			self.displaceID = index
			block.displaced = true
			bool = bool or true
		else
			block.displaced = false
			bool = bool or false
		end
	end

	self.displace = bool
	mb.Stack:Adjust()
end

mb.Stack.addBlock = function(self, block)
	block:SetParent(self)

	block.InStack = true
	block.saved = false

	if self.displace then
		table.insert(self.blocks, self.displaceID, block)
		table.insert(self.payloadTable, self.displaceID, block.payload)
		table.insert(self.blockFlags, self.displaceID, block.flags)
	else
		table.insert(self.blocks, block)
		table.insert(self.payloadTable, block.payload)
		table.insert(self.blockFlags, block.flags)
	end

	for id, b in ipairs(self.blocks) do b.StackID = id end

	mb.Stack:Adjust()

	print(mb.GetFlags(block))

	if self.Instructions:IsShown() then self.Instructions:Hide() end
end

mb.Stack.remBlock = function(self, block)
	block:SetParent(mb.Palette)

	table.remove(self.blocks, block.StackID)
	table.remove(self.payloadTable, block.StackID)
	table.remove(self.blockFlags, block.StackID)

	for id, b in ipairs(self.blocks) do b.StackID = id end

	mb.Stack:Adjust()

	if #self.blocks == 0 then self.Instructions:Show() end
end

local initOrder = {"CMD", "CON", "LOG", "TAR", "USR", "UTL"}
mb.Init = function()
	if mb_init then return end
	mb_init = true

	mb.Frame:Show()

	local paletteIndex = 1
	local block, str, label, val, item

	for i, group in pairs(initOrder) do
		for paramIndex, param in pairs(mb.BasicBlocks[group]) do

			str = strjoin("-", group, paletteIndex, paramIndex)

			if param.label then
				str = str.."-"..param.label
			end

			if param.config then
				if param.config.value then
					str = str.."-"..param.config.value
				end
				if param.config.itemType then
					str = str.."-"..param.config.itemType
				end
			end

			block = mb.MakeBlock(str)
			block.InStack = false

			mb.Palette.blocks[paletteIndex] = block
			paletteIndex = paletteIndex + 1

			mb.Palette:Adjust()
		end
	end
end

frame:SetScript("OnEvent", function(self, event, arg)
	if event == "PLAYER_SPECIALIZATION_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
		mb.GetUser()
	end
	if event == "PLAYER_ENTERING_WORLD" then

		mb.Char = string.format("%s-%s", PlayerName:GetText(), GetNormalizedRealmName())

		if UserMacros == nil then UserMacros = {} end
		if UserBlocks == nil then UserBlocks = {} end

		mb.UserMacros = UserMacros
		mb.UserBlocks = UserBlocks

		local numGen, numChar = GetNumMacros()
		local name, texture, body

		if numGen > 0 then
			for i=1, numGen do
				name, texture, body = GetMacroInfo(i)
				if name ~= nil then
					mb.UserMacros[i] = {
						["name"] = name,
						["texture"] = texture,
						["body"] = body,
					}
				end
				if mb.UserBlocks[i] == nil then
					mb.UserBlocks[i] = UserBlocks[i] or {}
				end
			end
		end

		if numChar > 0 then
			for i=1+120, numChar+120 do
				name, texture, body = GetMacroInfo(i)
				if name ~= nil then
					if mb.UserMacros[i] == nil then mb.UserMacros[i] = {} end
					mb.UserMacros[i][mb.Char] = {
						["name"] = name,
						["texture"] = texture,
						["body"] = body,
					}
				end
				if mb.UserBlocks[i] == nil then
					mb.UserBlocks[i] = UserBlocks[i] or {}
				end
			end
		end

	end
	if event == "PLAYER_LEAVING_WORLD" then

		for index, data in pairs(mb.UserMacros) do
			if index <=120 then
				UserMacros[index] = mb.UserMacros[index]
			else
				UserMacros[index][mb.Char] = mb.UserMacros[index][mb.Char]
			end
		end

		for index, blocks in pairs(mb.UserBlocks) do
			if index <=120 then
				UserBlocks[index] = mb.UserBlocks[index]
			else
				UserBlocks[index][mb.Char] = mb.UserBlocks[index][mb.Char]
			end
		end

		--[[
		for index, data in pairs(mb.Changelog) do
			if index <=120 then
				for time, changes in pairs(data) do
					if MacroChangelog[index][time] == nil then MacroChangelog[index][time] = changes end
				end
			else
				for time, changes in pairs(data) do
					if MacroChangelog[index][mb.Char][time] == nil then MacroChangelog[index][mb.Char][time] = changes end
				end
			end
		end
		]]
	end
end)

--@do-not-package@

	--[[
mb.Stack.saveBlocks = function()

end
]]

--[[
mb.Changelog = MacroChangelog or {}
mb.LogEditHistory = function(index, time)
	local name, texture, body = GetMacroInfo(index)
	if mb.Changelog[index] == nil then mb.Changelog[index] = {} end

	if index <= 120 then
		mb.Changelog[index][time] = { ["name"] = name, ["texture"] = texture, ["body"] = body }
	elseif index > 120 then
		if mb.Changelog[index][mb.Char] == nil then mb.Changelog[index][mb.Char] = {} end
		mb.Changelog[index][mb.Char][time] = t
	end
end
]]

	--[[ testing auto-build/block reconstruction functionality

	local testBlocks = { "UTL1", "CMD1", "CON1:1", "CON6", "USR1" }

	mb.Stack:SetScript("OnShow", function()
		local grp, num
		for i, groupID in pairs(testBlocks) do
			grp = string.sub(groupID, 1, 3)
			num = tonumber(string.sub(groupID, 4, 4))
			if string.len(groupID) > 4 then

			end
		end

	end)

	-- Export all available slash commands
	function CommandList()
		local HT = {}
		HT.Commands = {}
		HT.NormalizedCommands = {}
		for key, value in pairs(_G) do
			if strsub(key, 1, 6) == "SLASH_" then
				local cTypeKey = gsub(key, "%d+$", "")
				for cSeq = 1, 20 do
				  	local cPrime = cTypeKey.."1"
				  	local cKey = cTypeKey..tostring(cSeq)
				  	if _G[cPrime] and _G[cKey] then
						if strsub(_G[cPrime], 1, 1) == "/" and strsub(_G[cKey], 1, 1) == "/" then
						  	HT.Commands[_G[cKey]~] = _G[cPrime]
						  	if HT.NormalizedCommands[_G[cPrime]~] then
						  		-- skip it
						  	else
						  		-- make it
								HT.NormalizedCommands[_G[cPrime]~] = {}
						  	end
						  	HT.NormalizedCommands[_G[cPrime]~][_G[cKey]~] = true
						end
				  	else
						break
				  	end
				end
			end
		end
		return CopyTable(HT)
	end
	TargetModifiers = CommandList()]]
	--]]
--@end-do-not-package@