local addon, mb = ...
local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEAVING_WORLD")

SLASH_PRINT1 = "/print"
SlashCmdList["PRINT"] = function(msg, editBox)
	SlashCmdList.SCRIPT("print("..msg..")")
end

local mb_init = false

local blockBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 24,
	edgeSize = 12,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
}

local stackBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background-Maw",
	edgeFile = "Interface\\FriendsFrame\\UI-Toast-Border",
	tile = true,
	tileEdge = true,
	tileSize = 12,
	edgeSize = 12,
	insets = { left = 5, right = 5, top = 5, bottom = 5 },
}

mb.Frame = CreateFrame("Frame", "MacroBlocks", MacroFrame)

MBPaletteBasic = CreateFrame("Frame", "$parentPaletteBasic", mb.Frame, "InsetFrameTemplate")
MBPaletteBasic.blocks = {}

mb.Stack = CreateFrame("Frame", "$parentStack", mb.Frame, "BackdropTemplate")
mb.Stack:SetBackdrop(stackBackdrop) -- BACKDROP_TOAST_12_12)
-- mb.Stack:SetBackdropColor(1, 1, 1)

mb.Stack.blocks = {}
mb.Stack.sTable = {}
mb.Stack.string = ""
mb.Stack.displace = false
mb.Stack.displaceID = 0
mb.Stack.undo = ""

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

mb.SmartBlock = function(sBlock, smart)

	local funcTable = {}

	if not smart.orphan then
		funcTable.ORPHAN = function()
			local bool = false
			for _, block in pairs(mb.Stack.blocks) do
				bool = bool or block.group == smart.group
			end
			return bool
		end
	end

	funcTable.PLACEMENT = function()
		if not mb.Stack.displace then return false end
		return mb.Stack.blocks[mb.Stack.displaceID].group == smart.group
	end

	if smart.hookPayload ~= nil then
		local index = smart.hookPayload[1]
		local str = smart.hookPayload[2]

		funcTable.HOOK_PAYLOAD = function(payload)
			return string.sub(payload, index-1, index-1)..str..string.sub(payload, index)
		end

		funcTable.UNHOOK_PAYLOAD = function()
			mb.Stack.blocks[sBlock.stackID+1].hooked = false
			UpdateMacroBlockText()
		end
	end

	funcTable.STACK = function()
		mb.Stack.addBlock(sBlock)
		mb.Stack.blocks[sBlock.stackID+1].hooked = true
		mb.Stack.blocks[sBlock.stackID+1].smartHook = sBlock
		UpdateMacroBlockText()
	end

	for k, v in pairs(funcTable) do
		sBlock[k] = v
	end

end

-- Acquires a new block from one of the block frame pools
mb.MakeBlock = function(group, data, paletteID)

	local b = mb.BlockPoolCollection:Acquire(data.template or "MacroBlockTemplate")

	if not data.func or (data.func ~= "USER_SOCKET" and data.func ~= "USER_EDIT") then

		if data.func == "USER_CHOICE" then

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
			b.text:SetFontObject(MacroBlockSymbolFont)
			b.text:SetPoint("CENTER", 0, -3)
		end
	end

	if group == "Smart" then
		b.smartFunc = mb.SmartBlock(b, data.smart)
	end

	b.group = group
	b.data = data

	b.paletteID = paletteID or #MBPaletteBasic.blocks + 1

	b:SetBackdrop(blockBackdrop)
	b:SetBackdropColor(unpack(mb.ClassColors[group].rgb))
	b:SetBackdropBorderColor(unpack(mb.ClassColors[group].rgb))

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
	bool = bool or mb.Stack.blocks[index-1].group == "Smart"
	bool = bool or block.group == "Condition" and mb.Stack.blocks[index-1].group == "Condition"
	-- bool = bool or index == #mb.Stack.blocks
	-- bool = bool or 
	-- bool = bool or 
	-- bool = bool or 
	-- bool = bool or 
	-- bool = bool or 
	-- bool = bool or 
	-- bool = bool or 

	if bool then return "" else return " " end

end

function UpdateMacroBlockText()

	if not mb_init then return end

	local delim, str
	local preDelim, postDelim

	mb.Stack.string = ""
	mb.Stack.sTable = {}

	for i, block in pairs(mb.Stack.blocks) do

		if block.group ~= "Smart" then

			mb.Stack.sTable[block.stackID] = block.data.payload

			delim = delimSwitch(i, block)

			if block.hooked then
				str = mb.Stack.blocks[i-1].HOOK_PAYLOAD(block.data.payload)
			else
				str = block.data.payload
			end

			mb.Stack.string = mb.Stack.string..delim..str

		end

	end
	MacroFrameText:SetText(mb.Stack.string)
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

	StackAdjust()
end

mb.Stack.addBlock = function(block)
	block:SetParent(mb.Stack)
	block.stacked = true
	block.saved = false

	if mb.Stack.displace then
		table.insert(mb.Stack.blocks, mb.Stack.displaceID, block)
	else
		table.insert(mb.Stack.blocks, block)
	end

	for id, b in pairs(mb.Stack.blocks) do b.stackID = id end
	StackAdjust()
end

mb.Stack.remBlock = function(block)
	block:SetParent(MBPaletteBasic)

	table.remove(mb.Stack.blocks, block.stackID)

	for id, b in pairs(mb.Stack.blocks) do b.stackID = id end
	StackAdjust()
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

mb.GeneralMacros = {}
mb.CharacterMacros =  {}

mb.LogEditHistory = function(index, timestamp)

	local name, iconID, body = GetMacroInfo(index)

	if name ~=nil then
		if index <= 120 then
			mb.GeneralMacros[index]["changelog"][timestamp] = { ["name"] = name, ["iconID"] = iconID, ["body"] = body }
		elseif index > 120 then
			mb.CharacterMacros[index]["changelog"][timestamp] = { ["name"] = name, ["iconID"] = iconID, ["body"] = body }
		end
	end
end

frame:SetScript("OnEvent", function(self, event, arg)
	if event == "PLAYER_ENTERING_WORLD" then

		if UserGeneralMacros == nil then UserGeneralMacros = {} end
		if UserCharacterMacros == nil then UserCharacterMacros = {} end

		mb.CharacterMacros["character"] = PlayerName:GetText()
		mb.CharacterMacros["realm"] = GetNormalizedRealmName()

		local numGen, numChar = GetNumMacros()
		local name, iconID, body
		
		if numGen > 0 then
			for i=1, numGen do
				name, iconID, body = GetMacroInfo(i)
				if name ~= nil then
					mb.GeneralMacros[i] = { ["name"] = name, ["iconID"] = iconID, ["body"] = body }

					if mb.GeneralMacros[i]["changelog"] == nil then mb.GeneralMacros[i]["changelog"] = {} end
				end
			end
		end
	
		if numChar > 0 then
			for i=1+120, numChar+120 do
				name, iconID, body = GetMacroInfo(i)
				if name ~= nil then
					mb.CharacterMacros[i] = { ["name"] = name, ["iconID"] = iconID, ["body"] = body }
				
					if mb.CharacterMacros[i]["changelog"] == nil then mb.CharacterMacros[i]["changelog"] = {} end
				end
			end
		end
	end

	if event == "PLAYER_LEAVING_WORLD" then
		UserGeneralMacros = mb.GeneralMacros
		UserCharacterMacros = mb.CharacterMacros
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