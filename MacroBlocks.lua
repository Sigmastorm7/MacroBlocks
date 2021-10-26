local addon, mb = ...
local frame = CreateFrame("Frame", nil, UIParent)

mb.MakeBlock = nil

-- Math utility
local function round(number, decimals)
    return tonumber((("%%.%df"):format(decimals)):format(number))
end

mb.BlockColors = {
	["Command"] = {0.78431, 0.27059, 0.98039}, 						
	["Social"] = {0.0, 0.8, 1},
	["item"] = {0.0, 0.56863, 0.94902},
	["spell"] = nil,
	["emote"] = {0.65882, 0.65882, 0.65882},
	["User"] = {1.0, 0.50196, 0.0},
	["Utility"] = {0.90196, 0.8, 0.50196},
	["Condition"] = {0.0902, 0.7843, 0.3922},
	["horde"] = {0.90, 0.05, 0.07},
	["alliance"] = {0.29, 0.33, 0.91},
	["mawBG"] = {0.114, 0.153, 0.149},
	["mawEdge"] = {0.31, 0.459, 0.463},
}

local frameColors = {
	{0.718, 0.561, 0.416},			-- RUNEFORGE_LEGENDARY_SPEC_COLOR
}

blockBackdrop = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 24,
	edgeSize = 12,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
}

local nullBlock = {
	["name"] = "null",
	["payload"] = "",
}

local function ColorUnpack(rgb, a, mod)
	a = a or 1
	mod = mod or 0
	local r, g, b = rgb[1] + mod, rgb[2] + mod, rgb[3] + mod
	return r, g, b, a	
end

local function MBBackdropColorSetter(f, color)
	f:SetBackdropColor(ColorUnpack(mb.BlockColors[color], 0.3))
	f:SetBackdropBorderColor(ColorUnpack(mb.BlockColors[color], 1, 0.2))
end

-- PALETTE FRAMES START --
	MBFrame = CreateFrame("Frame", "MacroBlocks", MacroFrame)

	MBPalette = CreateFrame("Frame", "$parentPalette", MBFrame, "TooltipBackdropTemplate")
	MBPalette:SetFrameStrata("HIGH")
	MBPalette:SetBackdropColor(0.05, 0.05, 0.05)
	MBPalette.blocks = {}

	MBBasic = CreateFrame("Frame", "$parentBasic", MBPalette, "TooltipBackdropTemplate")

	MBCommand = CreateFrame("Frame", "$parentCommand", MBPalette, "TooltipBackdropTemplate")
	MBCommand:SetPoint("TOPLEFT", MBPalette, "TOPLEFT")
	MBCommand:SetPoint("BOTTOMRIGHT", MBPalette, "TOPRIGHT", 0, -68)
	MBBackdropColorSetter(MBCommand, "Command")
	MBCommand.blocks = {}

	MBCondition = CreateFrame("Frame", "$parentCondition", MBPalette, "TooltipBackdropTemplate")
	MBCondition:SetPoint("TOPLEFT", MBCommand, "BOTTOMLEFT")
	MBCondition:SetPoint("BOTTOMRIGHT", MBCommand, "BOTTOMRIGHT", 0, -68)
	MBBackdropColorSetter(MBCondition, "Condition")
	MBCondition.blocks = {}

	MBUtility = CreateFrame("Frame", "$parentUtility", MBPalette, "TooltipBackdropTemplate")
	MBUtility:SetPoint("TOPLEFT", MBCondition, "BOTTOMLEFT")
	MBUtility:SetPoint("BOTTOMRIGHT", MBCondition, "BOTTOMRIGHT", 0, -68)
	MBBackdropColorSetter(MBUtility, "Utility")
	MBUtility.blocks = {}

	MBUser = CreateFrame("Frame", "$parentUser", MBPalette, "TooltipBackdropTemplate")
	MBUser:SetPoint("TOPLEFT", MBUtility, "BOTTOMLEFT")
	MBUser:SetPoint("BOTTOMRIGHT", MBUtility, "BOTTOMRIGHT", 0, -68)
	MBBackdropColorSetter(MBUser, "User")
	MBUser.blocks = {}

	MBSocial = CreateFrame("Frame", "$parentSocial", MBPalette, "TooltipBackdropTemplate")
	MBSocial:SetPoint("TOPLEFT", MBUser, "BOTTOMLEFT")
	MBSocial:SetPoint("BOTTOMRIGHT", MBUser, "BOTTOMRIGHT", 0, -68)
	MBBackdropColorSetter(MBSocial, "Social")
	MBSocial.blocks = {}
-- PALETTE FRAMES END --

local debug = {
	["str"] = "Debug: ",
	["MB_BlockPoolResetter"] = { ["str"] = "resetterFunc x", ["count"] = 0 },
}

local function MB_BlockPoolResetter(self, block)
	debug.MB_BlockPoolResetter.count = debug.MB_BlockPoolResetter.count + 1
	-- print(debug.str..debug.MB_BlockPoolResetter.str..tostring(debug.MB_BlockPoolResetter.count))

	local palette = _G["MacroBlocksPalette"..block.kind] or MBPalette

	-- if not palette then return end

	block:SetParent(palette)

	print(palette[block])

	if block.paletteID then

		-- print(palette.blocks[block.paletteID])

		if not palette.blocks[block.paletteID] then

			palette.blocks[block.paletteID] = block

			if block.kind == "User" then

				if block.data.func == "USER_SOCKET" then

					block.socket.icon:SetColorTexture(0, 0, 0, 0)
					-- TODO: update to clear payload data

				elseif block.data.func == "USER_EDIT" then

					block.edit:SetText("")

				end

		 	-- else

			end

		else

			block:ClearAllPoints()
			block:Hide()

		end
	end
	PaletteAdjust(palette)
	StackAdjust()

	-- print(collectgarbage("count"))
	-- block:ClearAllPoints()
end

MacroBlockPool = CreateFramePool("Frame", MBPalette, "MacroBlockTemplate", MB_BlockPoolResetter)
SocketBlockPool = CreateFramePool("Frame", MBPalette, "SocketBlockTemplate", MB_BlockPoolResetter)
EditBlockPool = CreateFramePool("Frame", MBPalette, "EditBlockTemplate", MB_BlockPoolResetter)

-- Acquires a new block from one of the block frame pools
mb.MakeBlock = function(kind, data, paletteID) -- function MakeBlock(kind, data, paletteID)
	local b

	if data.func == "USER_SOCKET" then
		b = SocketBlockPool:Acquire()
	elseif data.func == "USER_EDIT" then
		b = EditBlockPool:Acquire()
	else
		b = MacroBlockPool:Acquire()

		b.text:SetText(data.name)

		local bw = b.text:GetStringWidth() + 18
		if bw >= 28 then b:SetWidth(bw) else b:SetWidth(28) end

		if data.symbol then
			b.text:SetFontObject(MacroBlockSymbolFont)
			b.text:SetPoint("CENTER", 0, -3)
		end
	end

	b.kind = kind
	b.payload = data.payload

	b:SetParent(_G["MacroBlocksPalette"..kind])
	b.paletteID = paletteID or #_G["MacroBlocksPalette"..kind].blocks + 1
	b.stacked = false

	b.data = data

	b:SetBackdrop(blockBackdrop)
	b:SetBackdropColor(unpack(mb.BlockColors[kind]))
	b:SetBackdropBorderColor(unpack(mb.BlockColors[kind]))

	b:Show()

	_G["MacroBlocksPalette"..kind][b] = true 

	return b
end

function PaletteAdjust(f, index, xOff, yOff)

	index = index or 1
	xOff = xOff or 6
	yOff = yOff or -6

	if index <= #f.blocks then

		if not f.blocks[index]:IsShown() then f.blocks[index]:Show() end

		if (xOff + f.blocks[index]:GetWidth()) >= (f:GetWidth() - 6) then
			xOff = 6
			yOff = yOff - 32
		end

		f.blocks[index]:ClearAllPoints()
		f.blocks[index]:SetPoint("TOPLEFT", f, "TOPLEFT", xOff, yOff)
		xOff = xOff + f.blocks[index]:GetWidth()
		
		PaletteAdjust(f, index + 1, xOff, yOff)
	else
		return
	end
end

MBStack = CreateFrame("Frame", "$parentStack", MBFrame, "TooltipBackdropTemplate")
MBStack:SetFrameStrata("HIGH")
MBStack:SetBackdropColor(0.114, 0.153, 0.149)

MBStack.blocks = {}
MBStack.sTable = {}
MBStack.string = ""
MBStack.displace = false
MBStack.displaceID = 0

local function delimSwitch(index, block)
	local bool = false

	bool = bool or block.data.func == "NEW_LINE"
	bool = bool or index == 1
	-- bool = bool or index == #MBStack.blocks
	bool = bool or #MBStack.blocks == 1
	-- bool = bool or 
	-- bool = bool or 

	if bool then return "" else return " " end

end

function UpdateMacroBlockText()

	local delim

	MBStack.string = ""
	MBStack.sTable = {}

	for i, block in pairs(MBStack.blocks) do
		MBStack.sTable[block.stackID] = block.payload

		delim = delimSwitch(i, block)

		MBStack.string = MBStack.string..delim..block.payload
	end

	MacroFrameText:SetText(MBStack.string)
end

function StackAdjust(index, xOff, yOff)

	index = index or 1
	xOff = xOff or 6
	yOff = yOff or -6

	local wedge

	if index <= #MBStack.blocks then

		if (xOff + MBStack.blocks[index]:GetWidth()) >= (MBStack:GetWidth() - 6) then
			xOff = 6
			yOff = yOff - 32
		end

		if index == MBStack.displaceID and MBStack.displace then
			xOff = xOff + 32
		end

		MBStack.blocks[index]:ClearAllPoints()
		MBStack.blocks[index]:SetPoint("TOPLEFT", MBStack, "TOPLEFT", xOff, yOff)
		xOff = xOff + MBStack.blocks[index]:GetWidth()

		-- Creates a new line if the updated block is utility block with the NEW_LINE flag
		if MBStack.blocks[index].data.func then
			if MBStack.blocks[index].data.func == "NEW_LINE" then
				xOff = MBStack:GetWidth() - 6
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
	local tempID = 0

	if not MouseIsOver(MBStack) then return end

	for index, block in pairs(MBStack.blocks) do
		if block.displaced then dis = 32 end
		if MouseIsOver(block, 0, 0, -(16+dis), -block:GetWidth()+16) then
			MBStack.displaceID = index
			block.displaced = true
			bool = bool or true
		else
			block.displaced = false
			bool = bool or false
		end
	end

	MBStack.displace = bool

	StackAdjust()
end

MBStack.addBlock = function(block)

	if _G["MacroBlocksPalette"..block.kind][block] then
		_G["MacroBlocksPalette"..block.kind].blocks[block.paletteID] = mb.MakeBlock(block.kind, block.data, block.paletteID)
	end

	PaletteAdjust(_G["MacroBlocksPalette"..block.kind])

	block:SetParent(MBStack)
	block.stacked = true
	_G["MacroBlocksPalette"..block.kind][block] = false

	if MBStack.displace then
		table.insert(MBStack.blocks, MBStack.displaceID, block)
		MBStack.displace = false
		MBStack.displaceID = 0
	else
		table.insert(MBStack.blocks, block)
	end

	for id, block in pairs(MBStack.blocks) do block.stackID = id end

	StackAdjust()
end

MBStack.remBlock = function(block)
	block:SetParent(_G["MacroBlocksPalette"..block.kind])
	block.stacked = false

	table.remove(MBStack.blocks, block.stackID)

	for id, block in pairs(MBStack.blocks) do block.stackID = id end

	StackAdjust()
end

local blocks = {
	["Utility"] = {
		{	["name"] = "#show",
			["payload"] = "#show|n",
			["func"] = "NEW_LINE",
		},
		{	["name"] = "#showtooltip",
			["payload"] = "#showtooltip|n",
			["func"] = "NEW_LINE",
		},
		{	["name"] = "⮐",
			["payload"] = "\n",
			["symbol"] = true,
			["func"] = "NEW_LINE",
		},
		{	["name"] = ";",
			["payload"] = ";",
		},
	},
	["Command"] = {
		{	["name"] = "/use",
			["payload"] = "/use",
		},
		{	["name"] = "/cast",
			["payload"] = "/cast",
		},
	},
	["Condition"] = {
		{	["name"] = "[ctrl]",
			["payload"] = "[mod:ctrl]",
		},
		{	["name"] = "[shift]",
			["payload"] = "[mod:shift]",
		},
		{	["name"] = "[alt]",
			["payload"] = "[mod:alt]",
		},
		{	["name"] = "[@mouseover]",
			["payload"] = "[@mouseover]",
		},
	},
	["Social"] = {
		{	["name"] = "AaBbCc",
			["payload"] = "AaBbCc",
		},
	},
	["User"] = {
		{	["name"] = "socket",
			["payload"] = "",
			["func"] = "USER_SOCKET",
		},
		{	["name"] = "custom input",
			["payload"] = "",
			["func"] = "USER_EDIT",
		},
	},
}

local init = false
local function MacroBlocks_Init()
	if init then return end
	init = true

	local parent

	for kind, blockData in pairs(blocks) do
		parent = _G["MacroBlocksPalette"..kind]
		parent.blocks = {}
		for i, data in pairs(blockData) do
			parent.blocks[i] = mb.MakeBlock(kind, data, i) -- MakeBlock(kind, data)
		end
		PaletteAdjust(parent)
	end
end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg)
	if event == "ADDON_LOADED" and arg == "Blizzard_MacroUI" then
		if not MacroFrame then return end

		-- Alter blizzard's macro frame
		MacroFrame:SetHeight(603)
		MacroFrame:SetWidth(MacroFrame:GetWidth() * 2)
		MacroFrame.Inset:SetPoint("BOTTOMRIGHT", "$parent", "BOTTOM", -6, 200)
		MacroFrame.TopTileStreaks:Hide()
		MacroButtonScrollFrame:SetWidth(292)
		MacroFrameTextBackground:SetPoint("TOPLEFT", MacroFrameSelectedMacroBackground, "BOTTOMLEFT", 2, -6)
		MacroFrameCharLimitText:ClearAllPoints()
		MacroFrameCharLimitText:SetPoint("TOP", MacroFrameTextBackground, "BOTTOM", 0, -2)

		MBFrame:SetScale(MacroFrame:GetEffectiveScale())
		MBFrame:SetPoint("TOPLEFT", MacroFrame.Inset, "TOPRIGHT")
		MBFrame:SetPoint("BOTTOMRIGHT", MacroFrame, "BOTTOMRIGHT", -6, 26)

		MBStack:SetPoint("TOPLEFT", MacroFrameTextBackground, "BOTTOMLEFT", -2, -20)
		MBStack:SetPoint("BOTTOMRIGHT", MBFrame, "BOTTOMRIGHT", 0, 2)

		MBPalette:SetPoint("TOPLEFT", MacroButtonScrollFrameTop, "TOPRIGHT")
		MBPalette:SetPoint("BOTTOMRIGHT", MBFrame, "RIGHT", 0, -84)

		MacroCancelButton:HookScript("OnClick", function()
			for _, block in pairs(MBStack.blocks) do
				if block.kind == "User" then
					if block.data.func == "USER_SOCKET" then
						MacroBlockPool:Release(block)
					elseif block.data.func == "USER_EDIT" then
						SocketBlockPool:Release(block)
					end
				else
					EditBlockPool:Release(block)
				end
			end
		end)

		-- Attach addon's visibility to blizzard's macro frame visibility
		MacroFrame:HookScript("OnShow", function()
			MBFrame:Show()

			MacroBlocks_Init()

			--[[
			for i, data in pairs(blocks) do
				MBPalette.blocks[i] = MakeBlock(data)
			end

			PaletteAdjust(MBPalette)]]

		end)
		MacroFrame:HookScript("OnHide", function()
			MBFrame:Hide()
		end)
	end
end)


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
				if strsub(_G[cPrime], 1, 1) == "/" and 
				   strsub(_G[cKey], 1, 1) == "/" then
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
]]