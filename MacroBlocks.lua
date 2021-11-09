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

mb.GetAbilityInfo = function(abilityID, abilityType)
	local name, iconID

	if abilityType == "spell" then
		name, _, iconID = GetSpellInfo(abilityID)

	elseif abilityType == "item" then
		name = "item:"..abilityID
		iconID = C_Item.GetItemIconByID(abilityID)

	elseif abilityType == "mount" then
		name, _, iconID = C_MountJournal.GetMountInfoByID(abilityID)

	elseif abilityType == "battlepet" then
		local petInfo = C_PetJournal.GetPetInfoTableByPetID(abilityID)
		name = petInfo.name
		iconID = petInfo.icon

	end

	return name, iconID
end

mb.BlockGen = function(group, num, param)

	local block = mb.BlockPools:Acquire(param.template or "MacroBlockTemplate")
	local name = param.name

	if param.config then

		local config = param.config

		if group == "CON" then

			local bc

			block.backdropFrame.text:SetText(name)
			block.backdropFrame:SetWidth(block.backdropFrame.text:GetStringWidth() + 18)

			block:SetWidth(block.backdropFrame:GetWidth() + 18)

			block.closeWidth = block:GetWidth()
			block.openWidth = 18

			if config.enabledSpec then
				if config.enabledSpec == 0 then config.enabledSpec = GetSpecialization() end
			end

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

				param.payload = config.modCombos[config.sum]

			elseif param.label == "SPEC" then

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
					specCheck = i == config.enabledSpec
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

				param.payload = "[spec:"..config.enabledSpec.."]"

			elseif param.label == "TALENT" then

				local tIcon, tStr
				local r, c = 0, 0

				for i=1, 7 do
					for j=1, 3 do

						_, _, tIcon = GetTalentInfoBySpecialization(config.enabledSpec, i, j)
						bc = block["row"..i]["btn"..j]
						tStr = i.."/"..j

						bc:SetHighlightAtlas("ChromieTime-Button-Selection")

						bc.icon:SetTexture(tIcon)
						bc.icon:SetDesaturated(not config.buttons[i][j])
						bc.icon:SetAlpha(config.iconAlpha[config.buttons[i][j]])

						bc.talentID:SetText(tStr)
						bc.talentID:SetTextColor(unpack(config.textColor[config.buttons[i][j]]))

						bc.selected:SetShown(config.buttons[i][j])

						bc.value = tStr

						if config.buttons[i][j] then
							r = i
							c = j
						end

					end
				end

				block.payload = "[talent:"..r.."/"..c.."]"

				block.openWidth = 102

				block:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
				block:SetScript("OnEvent", function(self, event, arg)
					if event == "PLAYER_SPECIALIZATION_CHANGED" then

						config.enabledSpec = GetSpecialization()

						for i=1, 7 do
							for j=1, 3 do

								_, _, talentIcon = GetTalentInfoBySpecialization(config.enabledSpec, i, j)
								bc = self["row"..i]["btn"..j]

								bc.icon:SetTexture(talentIcon)

							end
						end
					end
				end) -- function end

			end

		elseif group == "USR" then

			if param.label == "SOCKET" then

				local btn = block.socket
				local abilityID

				if config.abilityInfo then

					block.payload = config.macroReference
					btn.icon:SetTexture(config.icon)

				else
					block.payload = "{empty}"
				end

			elseif param.label == "EDIT" then

				if param.text then
					block.payload = param.text
					block.edit:SetText(param.text)
				else
					block.payload = "{empty}"
				end

			end

		elseif group == "LOG" then

			if param.label == "STR_MOD" then
				block.payload = param.payload

				block.checkString = function(self)

					local _n = self.param.name
					local _p = self.param
					local MBS = mb.Stack.blocks
					local MBSdid = mb.Stack.displaceID
					local _b = _n == "true"

					if mb.Stack.displace then
						if strfind(_p.modifier, ">") then
							_b = _b or MBS[MBSdid].group == "CON"
							_b = _b or (MBS[MBSdid].group == "TAR" and _n == "and")
						end
						if strfind(_p.modifier, "<") then
							_b = _b or MBS[MBSdid-1].group == "CON"
							_b = _b or MBS[MBSdid-1].group == "TAR"
						end
					elseif #MBS > 0 then
						if strfind(_p.modifier, "<") then
							_b = _b or MBS[#MBS].group == "CON"
							_b = _b or MBS[#MBS].group == "TAR"
						end
					end

					return _b
				end
			end -- function end

			block.text:SetText(name)
			resizeBlock(block)

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
	block.ID = num
	block.payload = block.payload or param.payload
	block.param = param

	block:SetBackdrop(mb.blockBackdrop)
	block:SetBackdropColor(unpack(mb.GroupColors[group].rgb))
	block:SetBackdropBorderColor(unpack(mb.GroupColors[group].rgb))

	block:Show()

	return block

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

local paBlock
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
	else
		table.insert(self.blocks, block)
		table.insert(self.payloadTable, block.payload)
	end

	for id, b in pairs(self.blocks) do b.StackID = id end

	mb.Stack:Adjust()

	if self.Instructions:IsShown() then self.Instructions:Hide() end
end

mb.Stack.remBlock = function(self, block)
	block:SetParent(mb.Palette)

	table.remove(self.blocks, block.StackID)
	table.remove(self.payloadTable, block.StackID)

	for id, b in pairs(self.blocks) do b.StackID = id end

	mb.Stack:Adjust()

	if #self.blocks == 0 then self.Instructions:Show() end
end

local initOrder = {"CMD", "CON", "LOG", "TAR", "USR", "UTL"}
mb.Init = function()
	if mb_init then return end
	mb_init = true

	local index = 1
	local block

	for _, group in pairs(initOrder) do
		for _, parameters in pairs(mb.BasicBlocks[group]) do
			block = mb.BlockGen(group, index, parameters)
			block.InStack = false

			mb.Palette.blocks[index] = block
			index = index + 1

			mb.Palette:Adjust()
		end
	end
end

frame:SetScript("OnEvent", function(self, event, arg)
	if event == "PLAYER_SPECIALIZATION_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
		mb.GetUser()
	end
	if event == "PLAYER_ENTERING_WORLD" then

		mb.CharacterID = string.format("%s-%s", PlayerName:GetText(), GetNormalizedRealmName())

		if UserMacros == nil then UserMacros = {} end

		mb.UserMacros = UserMacros or {}

		local numGen, numChar = GetNumMacros()
		local name, texture, body

		if numGen > 0 then
			for i=1, numGen do
				name, texture, body = GetMacroInfo(i)
				if name ~= nil then
					mb.UserMacros[i] = { ["name"] = name, ["texture"] = texture, ["body"] = body, ["blocks"] = {} }
				end
			end
		end

		if numChar > 0 then
			for i=1+120, numChar+120 do
				name, texture, body = GetMacroInfo(i)
				if mb.UserMacros[i] == nil then mb.UserMacros[i] = {} end
				if name ~= nil then
					mb.UserMacros[i][mb.CharacterID] = { ["name"] = name, ["texture"] = texture, ["body"] = body, ["blocks"] = {} }
				end
			end
		end

	end
	if event == "PLAYER_LEAVING_WORLD" then
		if UserMacros == nil then UserMacros = {} end
		-- if MacroChangelog == nil then MacroChangelog = {} end

		MBDebug = {}

		for index, data in pairs(mb.UserMacros) do
			if index <=120 then
				UserMacros[index] = mb.UserMacros[index]
			else
				UserMacros[index][mb.CharacterID] = mb.UserMacros[index][mb.CharacterID]
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
					if MacroChangelog[index][mb.CharacterID][time] == nil then MacroChangelog[index][mb.CharacterID][time] = changes end
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
		if mb.Changelog[index][mb.CharacterID] == nil then mb.Changelog[index][mb.CharacterID] = {} end
		mb.Changelog[index][mb.CharacterID][time] = t
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