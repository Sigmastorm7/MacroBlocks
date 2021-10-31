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

MBPaletteBasic = CreateFrame("Frame", "$parentPaletteBasic", mb.Frame, "InsetFrameTemplate")
MBPaletteBasic.blocks = {}

mb.Stack = CreateFrame("Frame", "$parentStack", mb.Frame, "BackdropTemplate")
mb.Stack:SetBackdrop(mb.stackBackdrop)
mb.Stack.Instructions = mb.Stack:CreateFontString("$parentInstructions", "ARTWORK")
mb.Stack.Instructions:SetPoint("CENTER")
mb.Stack.Instructions:SetFontObject("MacroBlocksFont_Large")
mb.Stack.Instructions:SetText("Drag & Drop Blocks Here")

mb.Stack.blocks = {}
mb.Stack.payloadTable = {}
mb.Stack.string = ""
mb.Stack.displace = false
mb.Stack.displaceID = 0
mb.Stack.undo = ""
mb.Stack.preserve = false

mb.BlockPoolCollection = CreateFramePoolCollection()

local templates = {
	{ ["name"] = "MacroBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "SocketBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "EditBlockTemplate", ["type"] = "Frame" },
	{ ["name"] = "ChoiceBlockTemplate", ["type"] = "Frame" },
}

for i=1, #templates do
	mb.BlockPoolCollection:CreatePool(templates[i].type, MBPaletteBasic, templates[i].name)
end

mb.SMTBlock = function(self, smartData)

	local funcTable = {}

	funcTable.GROUPCHECK = function()
		local bool = false
		for _, block in pairs(mb.Stack.blocks) do
			bool = bool or block.group == smartData.group
		end
		return bool
	end

	funcTable.PLACEMENT = function()
		if not mb.Stack.displace then return false end
		return mb.Stack.blocks[mb.Stack.displaceID].group == smartData.group
	end

	funcTable.HOOK = function()
		
	end

	funcTable.UNHOOK = function()
		
	end

	for k, v in pairs(funcTable) do
		self[k] = v
	end

end

-- Acquires a new block from one of the block frame pools
mb.MakeBlock = function(group, data, paletteID)

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
		mb.SMTBlock(b, data.smartData)
	end

	b.group = group
	b.data = data

	if group == "CON" then
		b.data.hookedPayload = string.sub(data.payload, 2, string.len(data.payload) -1)
	end

	b.paletteID = paletteID or #MBPaletteBasic.blocks + 1

	b:SetBackdrop(mb.blockBackdrop)
	b:SetBackdropColor(unpack(mb.GroupColors[group].rgb))
	b:SetBackdropBorderColor(unpack(mb.GroupColors[group].rgb))

	b:Show()

	if b.paletteID == -1 then
		b.stacked = true
		mb.Stack.addBlock(b)
	else
		b.stacked = false
	end

	return b
end

local function delimSwitch(index, block)
	local bool = false

	bool = bool or block.data.func == "NEW_LINE"
	bool = bool or index == 1
	bool = bool or #mb.Stack.blocks == 1
	bool = bool or mb.Stack.blocks[index-1].group == "SMT"
	bool = bool or block.group == "CON" and mb.Stack.blocks[index-1].group == "CON"
	bool = bool or mb.Stack.payloadTable[i] == ""

	if bool then return "" else return " " end
end

function UpdateMacroBlockText()

	if not mb_init or mb.Stack.preserve then return end

	local delim, str
	local preDelim, postDelim

	mb.Stack.string = ""

	for _, payload in pairs(mb.Stack.payloadTable) do
		mb.Stack.string = mb.Stack.string..payload
	end

	--[[
	for i, block in pairs(mb.Stack.blocks) do

		delim = delimSwitch(i, block)

		if block.group ~= "SMT" then

			if block.hooked then
				str = mb.Stack.blocks[i-1].HOOK_PAYLOAD(block.data.payload)
			else
				str = mb.Stack.payloadTable[block.stackID]
			end

			mb.Stack.string = mb.Stack.string..delim..str

		end

	end
	]]
	MacroFrameText:SetText(mb.Stack.string)
end

function UpdatePayloadTable()
	for i, block in pairs(mb.Stack.blocks) do
		if not block.hooked then
			mb.Stack.payloadTable[i] = block.data.payload
		else
			mb.Stack.payloadTable[i] = block.data.hookedPayload
		end
	end

	--[[
	if #hooks > 0 then
		for hooker, _ in pairs(hooks) do
			local hookIDs = hooker.data.smt.hooks
			if #hookIDs == 2 then
				mb.Stack.payloadTable[] = "["..mb.Stack.payloadTable[]
				mb.Stack.payloadTable[] = mb.Stack.payloadTable[].."]"
			else
				mb.Stack.payloadTable[] = "["..mb.Stack.payloadTable[]
				mb.Stack.payloadTable[] = mb.Stack.payloadTable[].."]"
			end
		end
	end
	]]

	UpdateMacroBlockText()
end

function PaletteAdjust(index, xOff, yOff)

	index = index or 1
	xOff = xOff or 6
	yOff = yOff or -5

	if index <= #MBPaletteBasic.blocks then

		if not MBPaletteBasic.blocks[index]:IsShown() then MBPaletteBasic.blocks[index]:Show() end

		if (xOff + MBPaletteBasic.blocks[index]:GetWidth()) >= (MBPaletteBasic:GetWidth() - 6) then
			xOff = 6
			yOff = yOff - 32
		end

		MBPaletteBasic.blocks[index]:ClearAllPoints()
		MBPaletteBasic.blocks[index]:SetPoint("TOPLEFT", MBPaletteBasic, "TOPLEFT", xOff, yOff)
		xOff = xOff + MBPaletteBasic.blocks[index]:GetWidth()

		PaletteAdjust(index + 1, xOff, yOff)
	else
		return
	end
end

function StackAdjust(index, xOff, yOff)

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
		xOff = xOff + mb.Stack.blocks[index]:GetWidth()

		-- Creates a new line if the updated block is utility block with the NEW_LINE flag
		if mb.Stack.blocks[index].data.func then
			if mb.Stack.blocks[index].data.func == "NEW_LINE" then
				xOff = mb.Stack:GetWidth() - 6
			end
		end
		
		StackAdjust(index + 1, xOff, yOff)
	else
		UpdatePayloadTable()
		return
	end
end

local function StackDisplaceCheck(self)
	-- Escapes
	if not MouseIsOver(mb.Stack) or #mb.Stack.blocks == 0 then return end

	local bool = false
	local dist = 0

	for index, block in pairs(mb.Stack.blocks) do
		if block.displaced then dist = 32 end
		if MouseIsOver(block, 0, 0, -(16+dist), -block:GetWidth()+16) then
			if mb.Stack.dragIsSmart then
				if string.sub(block.data.groupID, 1, 3) == mb.Stack.dragGroup then
					mb.Stack.displaceID = index
					block.displaced = true
					bool = bool or true
				else
					block.displaced = false
					bool = bool or false
				end
			else
				mb.Stack.displaceID = index
				block.displaced = true
				bool = bool or true
			end
		else
			block.displaced = false
			bool = bool or false
		end
	end

	mb.Stack.displace = bool

	StackAdjust()
end

function StackDisplaceSetup()
	if string.sub(mb.Frame.dragging.data.groupID, 1, 3) == "SMT" then
		mb.Stack.dragIsSmart = true
		mb.Stack.dragGroup = mb.Frame.dragging.data.smt.group
	else
		mb.Stack.dragIsSmart = false
		mb.Stack.dragGroup = nil
	end

	mb.Stack:SetScript("OnUpdate", StackDisplaceCheck)
end

mb.Stack.addBlock = function(block)
	block:SetParent(mb.Stack)
	block.stacked = true
	block.saved = false

	if mb.Stack.displace then
		table.insert(mb.Stack.blocks, mb.Stack.displaceID, block)
		-- table.insert(mb.Stack.payloadTable, mb.Stack.displaceID, block.data.payload)
	else
		table.insert(mb.Stack.blocks, block)
		-- table.insert(mb.Stack.payloadTable, block.data.payload)
	end

	for id, b in pairs(mb.Stack.blocks) do
		b.stackID = id
	end

	if block.group == "SMT" then block.HOOK() end

	StackAdjust()

	mb.Stack.Instructions:Hide()
end

mb.Stack.remBlock = function(block)
	block:SetParent(MBPaletteBasic)

	table.remove(mb.Stack.blocks, block.stackID)
	-- table.remove(mb.Stack.payloadTable, block.stackID)

	if block.group == "SMT" then block.UNHOOK() end

	block.stackID = nil

	for id, b in pairs(mb.Stack.blocks) do b.stackID = id end
	StackAdjust()

	if #mb.Stack.blocks == 0 then
		mb.Stack.Instructions:Show()
	end
end

mb.Init = function()
	if mb_init then return end
	mb_init = true

	local itr = 1

	for group, blockData in pairs(mb.BasicBlocks) do
		for i, data in pairs(blockData) do
			MBPaletteBasic.blocks[itr] = mb.MakeBlock(group, data, itr)
			itr = itr + 1
		end
		PaletteAdjust()
	end
end

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
	--[[ Export all available slash commands
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
						  	HT.Commands[_G[cKey]%] = _G[cPrime]
						  	if HT.NormalizedCommands[_G[cPrime]%] then
						  		-- skip it
						  	else
						  		-- make it
								HT.NormalizedCommands[_G[cPrime]%] = {}
						  	end
						  	HT.NormalizedCommands[_G[cPrime]%][_G[cKey]%] = true
						end
				  	else
						break
				  	end
				end
			end
		end
		return CopyTable(HT)
	end
	SlashCommandList = CommandList()
	--]]
--@end-do-not-package@