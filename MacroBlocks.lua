local addon, mb = ...
local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEAVING_WORLD")

SLASH_PRINT1 = "/print"
SlashCmdList["PRINT"] = function(msg, editBox)
	SlashCmdList.SCRIPT("print("..msg..")")
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
mb.Stack.undo = ""
mb.Stack.preserve = false
mb.Stack.payloadTable = {}

mb.BlockPoolCollection = CreateFramePoolCollection()

local templates = {
	{ ["name"] = "MacroBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "SocketBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "EditBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "ChoiceBlockTemplate", ["type"] = "Frame" },
}

for i=1, #templates do
	mb.BlockPoolCollection:CreatePool(templates[i].type, mb.Palette, templates[i].name)
end

-- Acquires a new block from one of the block frame pools
mb.MakeBlock = function(group, data, PaletteID)

	local b = mb.BlockPoolCollection:Acquire(data.template or "MacroBlockTemplate")

	if not data.func or (data.func ~= "USR_SOCKET" and data.func ~= "USR_EDIT") then

		if data.func == "USR_CHOICE" then

			b.backdropFrame.text:SetText(data.name)
			b.backdropFrame:SetWidth(b.backdropFrame.text:GetStringWidth() + 18)

			b.choices = {}
			for i=1, 6 do
				if i <= #data.choices then
					b["choice"..i].text:SetText(data.choices[i].name)
					b["choice"..i].enabled = false
					b["choice"..i].value = data.choices[i].value

					b["choice"..i]:SetWidth(b["choice"..i].text:GetStringWidth())
					b["choice"..i]:Hide()
				else
					b["choice"..i]:Disable()
					b["choice"..i]:Hide()
					b["choice"..i]:ClearAllPoints()
				end
			end

			b._payload = data.payload
			b.origWidth = b:GetWidth()
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

	if group == "SMT" then
		b.CheckNeighbors = function(self)
			local bool = false
			if mb.Stack.displace then
				if strfind(data.payload, ">") then
					bool = bool or strsub(mb.Stack.blocks[mb.Stack.displaceID].GroupID, 1, 3) == "CON"
				end
				if strfind(data.payload, "<") then
					bool = bool or strsub(mb.Stack.blocks[mb.Stack.displaceID-1].GroupID, 1, 3) == "CON"
				end
			elseif #mb.Stack.blocks > 0 then
				if strfind(data.payload, "<") then
					bool = bool or strsub(mb.Stack.blocks[#mb.Stack.blocks].GroupID, 1, 3) == "CON"
				end
			end

			return bool
		end
	end

	b.data = data

	b.GroupID = group..PaletteID
	b.PaletteID = PaletteID or #mb.Palette.blocks + 1

	b:SetBackdrop(mb.blockBackdrop)
	b:SetBackdropColor(unpack(mb.GroupColors[group].rgb))
	b:SetBackdropBorderColor(unpack(mb.GroupColors[group].rgb))

	b:Show()

	if b.PaletteID == -1 then
		b.InStack = true
		mb.Stack.addBlock(b)
	else
		b.InStack = false
	end

	return b
end

local function delimSwitch(index, block)
	local bool = false

	local BID = strsub(block.GroupID, 1, 3)
	local LBID = ""
	if index > 1 then LBID = strsub(mb.Stack.blocks[index-1].GroupID, 1, 3) end

	bool = bool or block.data.func == "NEW_LINE"
	bool = bool or index == 1
	bool = bool or #mb.Stack.blocks == 1
	bool = bool or BID == "SMT" or LBID == "SMT"
	bool = bool or (BID == "CON" or BID == "TAR") and (LBID == "CON" or LBID == "TAR")
	bool = bool or block.stackOffset.x == 7
	bool = bool or block.data.name == ";"

	if bool then return "" else return " " end

end

function UpdateMacroBlockText()

	if not mb_init or mb.Stack.preserve then return end

	local delim

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

mb.PaletteAdjust = function(group, index, xOff, yOff)

	group = group or "CMD"
	index = index or 1
	xOff = xOff or 6
	yOff = yOff or -6

	if index <= #mb.Palette.blocks then

		-- if not mb.Palette.blocks[index]:IsShown() then mb.Palette.blocks[index]:Show() end

		if strsub(mb.Palette.blocks[index].GroupID, 1, 3) ~= group and strsub(mb.Palette.blocks[index].GroupID, 1, 3) ~= "SMT" then
			xOff = 6
			yOff = yOff - 28.5
			group = strsub(mb.Palette.blocks[index].GroupID, 1, 3)
		end

		if (xOff + mb.Palette.blocks[index]:GetWidth()) >= (mb.Palette:GetWidth() - 4) then
			xOff = 6
			yOff = yOff - 28.5
		end

		mb.Palette.blocks[index]:ClearAllPoints()
		mb.Palette.blocks[index]:SetPoint("TOPLEFT", mb.Palette, "TOPLEFT", xOff, yOff)
		xOff = xOff + mb.Palette.blocks[index]:GetWidth()

		mb.PaletteAdjust(group, index + 1, xOff, yOff)
	else
		return
	end
end

mb.StackAdjust = function(index, xOff, yOff)

	index = index or 1
	xOff = xOff or 7
	yOff = yOff or -6

	if index <= #mb.Stack.blocks then

		if (xOff + mb.Stack.blocks[index]:GetWidth()) >= (mb.Stack:GetWidth() - 6) then
			xOff = 7
			yOff = yOff - 30
		end

		if index == mb.Stack.displaceID and mb.Stack.displace then
			xOff = xOff + 32
		end

		if mb.Stack.blocks[index].socket then xOff = xOff + 2 end

		mb.Stack.blocks[index]:ClearAllPoints()
		mb.Stack.blocks[index]:SetPoint("TOPLEFT", mb.Stack, "TOPLEFT", xOff, yOff)
		mb.Stack.blocks[index].stackOffset = { ["x"] = xOff, ["y"] = yOff }
		xOff = xOff + mb.Stack.blocks[index]:GetWidth()

		-- Creates a new line if the updated block is utility block with the NEW_LINE flag
		if mb.Stack.blocks[index].data.func then
			if mb.Stack.blocks[index].data.func == "NEW_LINE" then
				xOff = mb.Stack:GetWidth() - 6
			end
		end

		mb.StackAdjust(index + 1, xOff, yOff)
	else
		UpdateMacroBlockText()
		return
	end
end

function StackDisplaceCheck(self)
	local bool = false
	local dis = 0

	if not MouseIsOver(mb.Stack) then return end

	if #mb.Stack.blocks == 0 then return end

	for index, block in pairs(mb.Stack.blocks) do
		if block.displaced then dis = 32 end
		if MouseIsOver(block, 0, 0, -(16+dis), -block:GetWidth()+16) then
			mb.Stack.displaceID = index
			block.displaced = true
			bool = bool or true
		else
			block.displaced = false
			bool = bool or false
		end
	end

	mb.Stack.displace = bool

	mb.StackAdjust()
end

mb.Stack.addBlock = function(block)
	block:SetParent(mb.Stack)
	block.InStack = true
	block.saved = false

	if mb.Stack.displace then
		table.insert(mb.Stack.blocks, mb.Stack.displaceID, block)
		table.insert(mb.Stack.payloadTable, mb.Stack.displaceID, block.data.payload)
	else
		table.insert(mb.Stack.blocks, block)
		table.insert(mb.Stack.payloadTable, block.data.payload)
	end

	for id, b in pairs(mb.Stack.blocks) do b.StackID = id end
	mb.StackAdjust()

	mb.Stack.Instructions:Hide()
end

mb.Stack.remBlock = function(block)
	block:SetParent(mb.Palette)
	table.remove(mb.Stack.blocks, block.StackID)
	table.remove(mb.Stack.payloadTable, block.StackID)

	for id, b in pairs(mb.Stack.blocks) do b.StackID = id end
	mb.StackAdjust()

	if #mb.Stack.blocks == 0 then
		mb.Stack.Instructions:Show()
	end
end

local initOrder = {"CMD", "CON", "SMT", "TAR", "USR", "UTL"}
mb.Init = function()
	if mb_init then return end
	mb_init = true

	local block
	local itr = 1

	for _, grp in pairs(initOrder) do
		for _, data in pairs(mb.BasicBlocks[grp]) do
			mb.Palette.blocks[itr] = mb.MakeBlock(grp, data, itr)			
			itr = itr + 1
			mb.PaletteAdjust()
		end
	end
end

frame:SetScript("OnEvent", function(self, event, arg)
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
					mb.UserMacros[i] = { ["name"] = name, ["texture"] = texture, ["body"] = body }
				end
			end
		end
	
		if numChar > 0 then
			for i=1+120, numChar+120 do
				name, texture, body = GetMacroInfo(i)
				if mb.UserMacros[i] == nil then mb.UserMacros[i] = {} end
				if name ~= nil then
					mb.UserMacros[i][mb.CharacterID] = { ["name"] = name, ["texture"] = texture, ["body"] = body }
				end
			end
		end
	end

	if event == "PLAYER_LEAVING_WORLD" then
		if UserMacros == nil then UserMacros = {} end
		-- if MacroChangelog == nil then MacroChangelog = {} end
	
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