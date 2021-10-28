local addon, mb = ...
local frame = CreateFrame("Frame", nil, UIParent)

-- Math utility
local function round(number, decimals)
  return tonumber((("%%.%df"):format(decimals)):format(number))
end

mb.ClassColors = {
	["HUNTER"] = { -- HUNTER
		["hex"] = "ffa9d271",
		["rgb"] = { 0.6666651964187622, 0.8274491429328918, 0.447057843208313 },
	},
	["WARRIOR"] = { -- WARRIOR
		["hex"] = "ffc59a6c",
		["rgb"] = { 0.7764688730239868, 0.6078417897224426, 0.427450031042099 },
	},
	["SHAMAN"] = { -- SHAMAN
		["hex"] = "ff006fdc",
		["rgb"] = { 0,  0.4392147064208984, 0.8666647672653198 },
	},
	["Social"] = { -- MAGE
		["hex"] = "ff3ec6ea",
		["rgb"] = { 0.2470582872629166,  0.7803904414176941, 0.9215666055679321 },
	},
	["PRIEST"] = { -- PRIEST
		["hex"] = "fffefefe",
		["rgb"] = { 0.9999977946281433,  0.9999977946281433, 0.9999977946281433 },
	},
	["PALADIN"] = { -- PALADIN
		["hex"] = "fff38bb9",
		["rgb"] = { 0.9568606615066528,  0.549018383026123, 0.7294101715087891 },
	},
	["Command"] = { -- WARLOCK
		["hex"] = "ff8687ed",
		["rgb"] = { 0.5294106006622314, 0.5333321690559387, 0.933331310749054 },
	},
	["DEMONHUNTER"] = { -- DEMONHUNTER
		["hex"] = "ffa22fc8",
		["rgb"] = { 0.639214277267456,  0.188234880566597, 0.7882335782051086 },
	},
	["Smart"] = { -- DEATHKNIGHT
		["hex"] = "ffc31d39",
		["rgb"] = { 0.7686257362365723,  0.117646798491478, 0.2274504750967026 },
	},
	["User"] = { -- DRUID
		["hex"] = "fffe7b09",
		["rgb"] = { 0.9999977946281433, 0.4862734377384186, 0.03921560198068619 },
	},
	["Condition"] = { -- MONK
		["hex"] = "ff00fe97",
		["rgb"] = { 0, 0.9999977946281433, 0.5960771441459656 },
	},
	["Utility"] = { -- ROGUE
		["hex"] = "fffef367",
		["rgb"] = { 0.9999977946281433, 0.9568606615066528, 0.4078422486782074 },
	},
}

local blockBackdrop = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 24,
	edgeSize = 12,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
}

MBFrame = CreateFrame("Frame", "MacroBlocks", MacroFrame, "SimplePanelTemplate")

MBPalette = CreateFrame("Frame", "$parentPalette", MBFrame, "TooltipBackdropTemplate")
MBPalette:SetFrameStrata("HIGH")
MBPalette:SetBackdropColor(0.05, 0.05, 0.05)
MBPalette.blocks = {}

mb.BlockPoolCollection = CreateFramePoolCollection()

local templates = {
	"MacroBlockTemplate",
	"SocketBlockTemplate",
	"EditBlockTemplate",
	"ModBlockTemplate",
}

for i=1, #templates do
	mb.BlockPoolCollection:CreatePool("Frame", MBPalette, templates[i])
end

mb.SmartBlock = function(sBlock, smart)

	local funcTable = {}

	if not smart.orphan then
		funcTable.ORPHAN = function()
			local bool = false
			for _, block in pairs(MBStack.blocks) do
				bool = bool or block.group == smart.group
			end
			return bool
		end
	end

	funcTable.PLACEMENT = function()
		if not MBStack.displace then return false end
		return MBStack.blocks[MBStack.displaceID].group == smart.group
	end

	if smart.hookPayload ~= nil then
		local index = smart.hookPayload[1]
		local str = smart.hookPayload[2]

		funcTable.HOOK_PAYLOAD = function(payload)
			return string.sub(payload, index-1, index-1)..str..string.sub(payload, index)
		end

		funcTable.UNHOOK_PAYLOAD = function()
			MBStack.blocks[sBlock.stackID+1].hooked = false
			UpdateMacroBlockText()
		end
	end

	funcTable.STACK = function()
		MBStack.addBlock(sBlock)
		MBStack.blocks[sBlock.stackID+1].hooked = true
		MBStack.blocks[sBlock.stackID+1].smartHook = sBlock
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

		b.text:SetText(data.name)

		if data.func ~= "MOD_CONDITION" then
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

	b.paletteID = paletteID or #MBPalette.blocks + 1

	b:SetBackdrop(blockBackdrop)
	b:SetBackdropColor(unpack(mb.ClassColors[group].rgb))
	b:SetBackdropBorderColor(unpack(mb.ClassColors[group].rgb))

	b:Show()

	if b.paletteID == -1 then
		b.stacked = true
		MBStack.addBlock(b)
	else
		b.stacked = false
	end

	return b
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
	bool = bool or MBStack.blocks[index-1].group == "Smart"
	-- bool = bool or 

	if bool then return "" else return " " end

end

function UpdateMacroBlockText()

	local delim, str

	MBStack.string = ""
	MBStack.sTable = {}

	for i, block in pairs(MBStack.blocks) do

		if block.group ~= "Smart" then

			MBStack.sTable[block.stackID] = block.data.payload

			delim = delimSwitch(i, block)

			if block.hooked then
				str = MBStack.blocks[i-1].HOOK_PAYLOAD(block.data.payload)
			else
				str = block.data.payload
			end

			MBStack.string = MBStack.string..delim..str

		end

	end
	MacroFrameText:SetText(MBStack.string)
end

function PaletteAdjust(index, xOff, yOff)

	index = index or 1
	xOff = xOff or 6
	yOff = yOff or -10

	if index <= #MBPalette.blocks then

		if not MBPalette.blocks[index]:IsShown() then MBPalette.blocks[index]:Show() end

		if (xOff + MBPalette.blocks[index]:GetWidth()) >= (MBPalette:GetWidth() - 6) then
			xOff = 6
			yOff = yOff - 32
		end

		MBPalette.blocks[index]:ClearAllPoints()
		MBPalette.blocks[index]:SetPoint("TOPLEFT", MBPalette, "TOPLEFT", xOff, yOff)
		xOff = xOff + MBPalette.blocks[index]:GetWidth()

		PaletteAdjust(index + 1, xOff, yOff)
	else
		return
	end
end

function StackAdjust(index, xOff, yOff)

	index = index or 1
	xOff = xOff or 6
	yOff = yOff or -10

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
	block:SetParent(MBStack)
	block.stacked = true

	if MBStack.displace then
		table.insert(MBStack.blocks, MBStack.displaceID, block)
	else
		table.insert(MBStack.blocks, block)
	end

	for id, b in pairs(MBStack.blocks) do b.stackID = id end
	StackAdjust()
end

MBStack.remBlock = function(block)
	block:SetParent(MBPalette)

	table.remove(MBStack.blocks, block.stackID)

	for id, b in pairs(MBStack.blocks) do b.stackID = id end
	StackAdjust()
end

local blocks = {
	["Utility"] = {
		{	["name"] = "#showtooltip",
			["payload"] = "#showtooltip\n",
			["func"] = "NEW_LINE",
		},
		{	["name"] = "#show",
			["payload"] = "#show\n",
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
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/summonpet",
			["payload"] = "/sp"
		},
	},
	["Condition"] = {
		{	["name"] = "mod",
			["payload"] = "[mod]",
			["func"] = "MOD_CONDITION",
			["template"] = "ModBlockTemplate"
		},
		{	["name"] = "combat",
			["payload"] = "[combat]",
		},
		{	["name"] = "exists",
			["payload"] = "[exists]",
		},
		{	["name"] = "help",
			["payload"] = "[help]",
		},
		{	["name"] = "harm",
			["payload"] = "[harm]",
		},
		{	["name"] = "dead",
			["payload"] = "[dead]",
		},
		{	["name"] = "@mouseover",
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
			["template"] = "SocketBlockTemplate"
		},
		{	["name"] = "custom input",
			["payload"] = "",
			["func"] = "USER_EDIT",
			["template"] = "EditBlockTemplate"
		},
	},
	["Smart"] = {
		{	["name"] = "no",
			-- ["payload"] = "no",
			["func"] = "NO_CONDITION",
			["smart"] = {
				["palette"] = true,
				["group"] = "Condition",
				["hookPayload"] = { 2, "no" },
				["orphan"] = false,
			}
		}
	}
}

local blockFamilies = {"Command", "Condition", "User", "Social", "Utility"}

local init = false
local function MacroBlocks_Init()
	if init then return end
	init = true

	local itr = 1

	for group, blockData in pairs(blocks) do
		for i, data in pairs(blockData) do
			MBPalette.blocks[itr] = mb.MakeBlock(group, data, itr)
			itr = itr + 1
		end
		PaletteAdjust()
	end
end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg)
	if event == "ADDON_LOADED" and arg == "Blizzard_MacroUI" then
		if not MacroFrame then return end

		-- Alter blizzard's macro frame
		MacroFrame:SetHeight(603)
		MacroFrame:SetWidth(MacroFrame:GetWidth() * 1.75)
		-- MacroFrame.Inset:SetPoint("BOTTOMRIGHT", "$parent", "BOTTOM", -6, 200)
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

		-- Attach addon's visibility to blizzard's macro frame visibility
		MacroFrame:HookScript("OnShow", function()
			MBFrame:Show()

			MacroBlocks_Init()

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