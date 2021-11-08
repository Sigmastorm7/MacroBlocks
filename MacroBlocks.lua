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

mb.BlockPoolCollection = CreateFramePoolCollection()

local templates = {
	{ ["name"] = "MacroBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "SocketBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "EditBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "ChoiceBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "TalentBlockTemplate", ["type"] = "Frame" },
}

for i=1, #templates do
	mb.BlockPoolCollection:CreatePool(templates[i].type, mb.Palette, templates[i].name)
end

-- Acquires a new block from one of the block frame pools
mb.MakeBlock = function(group, itr, data)

	local b = mb.BlockPoolCollection:Acquire(data.template or "MacroBlockTemplate")

	b.data = data

	if not data.func or (data.func ~= "USR_SOCKET" and data.func ~= "USR_EDIT") then

		if data.label then

			b.label = data.label

			b.backdropFrame.text:SetText(data.name)
			b.backdropFrame:SetWidth(b.backdropFrame.text:GetStringWidth() + 18)

			b:SetWidth(b.backdropFrame.text:GetStringWidth() + 36)
			b.closeW = b:GetWidth()

			b.openW = 0

			if data.label == "MOD" then
				b.num = 3
				for i=1, 6 do
					if i <= b.num then
						b["choice"..i].text:SetText(mb.Choices.MOD[i])
						b["choice"..i].enabled = false
						if i == 3 then
							b["choice"..i].value = 4
						else
							b["choice"..i].value = i
						end
						b["choice"..i]:SetWidth(b["choice"..i].text:GetStringWidth())
						b["choice"..i]:Hide()
						b.openW = b.openW + b["choice"..i]:GetWidth()
					else
						b["choice"..i]:Disable()
						b["choice"..i]:Hide()
						b["choice"..i]:ClearAllPoints()
					end
				end

				b._payload = data.payload
			elseif data.label == "SPEC" then
				_, b.class, _ = UnitClass(PLAYER)
				b.num = mb.Choices.SPEC[b.class]

				for i=1, 6 do
					if i <= b.num then
						local _, spec = GetSpecializationInfo(i)
						b["choice"..i].text:SetText(spec)
						b["choice"..i].enabled = false
						b["choice"..i].value = i
						b["choice"..i]:SetWidth(b["choice"..i].text:GetStringWidth())
						b["choice"..i]:Hide()
						b.openW = b.openW + b["choice"..i]:GetWidth()
					else
						b["choice"..i]:Disable()
						b["choice"..i]:Hide()
						b["choice"..i]:ClearAllPoints()
					end
				end

				b["choice"..mb.User.spec.id].enabled = true
				data.payload = "[spec:"..mb.User.spec.id.."]"
				b["choice"..mb.User.spec.id].text:SetTextColor(0, 1, 0.4)
			elseif data.label == "TALENT" then

				b.init = true
				b.OnSpecChanged = function(self)
					-- mb.GetUser()
					local talentID, talentName, talentIcon
					for i=1, 7 do
						for j=1, 3 do
							talentID, talentName, talentIcon = GetTalentInfoBySpecialization(GetSpecialization(), i, j)
							self["row"..i]["btn"..j].icon:SetTexture(talentIcon)
							if self.init then
								self["row"..i]["btn"..j].icon:SetDesaturated(true)
								self["row"..i]["btn"..j]:SetHighlightAtlas("ChromieTime-Button-Selection")
								self["row"..i]["btn"..j].icon:SetAlpha(0.8)
								self["row"..i]["btn"..j].talentID:SetText(i.."/"..j)
								self["row"..i]["btn"..j].talentID:SetTextColor(1, 0.8, 0.3)
								self["row"..i]["btn"..j].selected:SetShown(mb.User.talents[i][j])
								self["row"..i]["btn"..j].value = i.."/"..j
							end
						end
					end
				end

				b:OnSpecChanged()
				b.init = false

				b:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
				b:SetScript("OnEvent", function(self, event, arg)
					if event == "PLAYER_SPECIALIZATION_CHANGED" then self:OnSpecChanged() end
				end)

				b.openW = 84

			end
			b.openW = b.openW + 18
		else
			b.text:SetText(data.name)
			local bw = b.text:GetStringWidth() + 18
			if bw >= 28 then b:SetWidth(bw) else b:SetWidth(28) end
		end

		if data.symbol then
			b.text:SetFontObject(MacroBlocksSymbolFont)
			b.text:SetPoint("CENTER", 0, -3)
		end
	end

	if group == "LOG" then
		b.CheckNeighbors = function(self)
			local bool = self.data.name == "or" or self.data.name == "true"
			if mb.Stack.displace then
				if strfind(data.payload, ">") then
					bool = bool or mb.Stack.blocks[mb.Stack.displaceID].group == "CON"
					bool = bool or (mb.Stack.blocks[mb.Stack.displaceID].group == "TAR" and self.data.name == "and")
				end
				if strfind(data.payload, "<") then
					bool = bool or mb.Stack.blocks[mb.Stack.displaceID-1].group == "CON"
					bool = bool or mb.Stack.blocks[mb.Stack.displaceID-1].group == "TAR"
				end
			elseif #mb.Stack.blocks > 0 then
				if strfind(data.payload, "<") then
					bool = bool or mb.Stack.blocks[#mb.Stack.blocks].group == "CON"
					bool = bool or mb.Stack.blocks[#mb.Stack.blocks].group == "TAR"
				end
			end
			return bool
		end
	end

	b.data = data
	b.parameters = {}
	b.tooltip = data.tooltip

	b.group = group
	b.groupID = group..itr
	b.ID = itr

	b:SetBackdrop(mb.blockBackdrop)
	b:SetBackdropColor(unpack(mb.GroupColors[group].rgb))
	b:SetBackdropBorderColor(unpack(mb.GroupColors[group].rgb))

	b:Show()
	b.InStack = false

	return b
end

mb.BlockGen = function()

end

local function delimSwitch(index, block)
	local bool = false

	local BID = block.group
	local LBID = ""
	if index > 1 then LBID = mb.Stack.blocks[index-1].group end

	bool = bool or block.data.func == "NEW_LINE"
	bool = bool or index == 1
	bool = bool or #mb.Stack.blocks == 1
	bool = bool or (BID == "LOG" or BID == "CON" or BID == "TAR") and (LBID == "LOG" or LBID == "CON" or LBID == "TAR")
	bool = bool or block.stackOffset.x == 7
	bool = bool or block.data.name == ";"

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

		-- Creates a new line if the updated block is utility block with the NEW_LINE flag
		if self.blocks[index].data.func then
			if self.blocks[index].data.func == "NEW_LINE" then
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
		table.insert(self.payloadTable, self.displaceID, block.data.payload)
	else
		table.insert(self.blocks, block)
		table.insert(self.payloadTable, block.data.payload)
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

	local itr = 1

	for _, grp in pairs(initOrder) do
		for _, data in pairs(mb.BasicBlocks[grp]) do
			mb.Palette.blocks[itr] = mb.MakeBlock(grp, itr, data)
			itr = itr + 1
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

		for i, block in pairs(mb.Stack.blocks) do
			-- MBDebug[i] = block.data
		end

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