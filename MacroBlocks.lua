local addon, mb = ...
local frame = CreateFrame("Frame", nil, UIParent)

local mb_init = false


-- Math utility
local function round(number, decimals)
	return tonumber((("%%.%df"):format(decimals)):format(number))
end

local blockBackdrop = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 24,
	edgeSize = 12,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
}

MBFrame = CreateFrame("Frame", "MacroBlocks", MacroFrame)

MBPaletteBasic = CreateFrame("Frame", "$parentPaletteBasic", MBFrame, "InsetFrameTemplate")
MBPaletteBasic.blocks = {}

MBStack = CreateFrame("Frame", "$parentStack", MBFrame, "InsetFrameTemplate")

MBStack.blocks = {}
MBStack.sTable = {}
MBStack.string = ""
MBStack.displace = false
MBStack.displaceID = 0

mb.BlockPoolCollection = CreateFramePoolCollection()

local templates = {
	"MacroBlockTemplate",
	"SocketBlockTemplate",
	"EditBlockTemplate",
	"ModBlockTemplate",
}

for i=1, #templates do
	mb.BlockPoolCollection:CreatePool("Frame", MBPaletteBasic, templates[i])
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

	b.paletteID = paletteID or #MBPaletteBasic.blocks + 1

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

local function delimSwitch(index, block)
	local bool = false

	bool = bool or block.data.func == "NEW_LINE"
	bool = bool or index == 1
	-- bool = bool or index == #MBStack.blocks
	bool = bool or #MBStack.blocks == 1
	bool = bool or MBStack.blocks[index-1].group == "Smart"
	bool = bool or block.group == "Condition"
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
	xOff = xOff or 4
	yOff = yOff or -5

	if index <= #MBStack.blocks then

		if (xOff + MBStack.blocks[index]:GetWidth()) >= (MBStack:GetWidth() - 6) then
			xOff = 4
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
	block.saved = false

	if MBStack.displace then
		table.insert(MBStack.blocks, MBStack.displaceID, block)
	else
		table.insert(MBStack.blocks, block)
	end

	for id, b in pairs(MBStack.blocks) do b.stackID = id end
	StackAdjust()
end

MBStack.remBlock = function(block)
	block:SetParent(MBPaletteBasic)

	table.remove(MBStack.blocks, block.stackID)

	for id, b in pairs(MBStack.blocks) do b.stackID = id end
	StackAdjust()
end

local function MacroBlocks_mb_Init()
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

MBStack.saveBlocks = function()

end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg)
	if event == "ADDON_LOADED" and arg == "Blizzard_MacroUI" then
		if not MacroFrame then return end

		-- Resize the macro frame and change it's UIPanel attributes to correct repositioning interactions
		MacroFrame:SetSize(600, 560)
		UIPanelWindows["MacroFrame"] = { area = "left", pushable = 1, whileDead = 1, width = 600 }

		-- Make the macro frame moveable by the user
		MacroFrame:SetMovable(true)
		MacroFrame:RegisterForDrag()
		MacroFrame:SetClampedToScreen(true)

		-- MacroFrameTextBackground:SetPoint("TOPLEFT", MacroFrameSelectedMacroBackground, "BOTTOMLEFT", 2, -6)

		-- Attach the character count to the text box for easier adjustment of frames
		MacroFrameCharLimitText:ClearAllPoints()
		MacroFrameCharLimitText:SetPoint("TOPLEFT", MacroFrameTextBackground, "BOTTOMLEFT", 6, -2)

		-- Parent our addon's parent frame to the macro frame
		MBFrame:SetParent(MacroFrame)
		MBFrame:SetAllPoints()

		-- Reposition buttons croll frame
		MacroButtonScrollFrame:SetPoint("TOPLEFT", 12, -64)

		-- Reposition scroll bar
		MacroButtonScrollFrameScrollBar:SetPoint("TOPLEFT", MacroButtonScrollFrame, "TOPRIGHT", 3, -16)
		MacroButtonScrollFrameScrollBar:SetPoint("BOTTOMLEFT", MacroButtonScrollFrame, "BOTTOMRIGHT", 3, 16)

		-- Hide all the stupid ugly shit
		MacroButtonScrollFrameTop:Hide()
		MacroButtonScrollFrameBottom:Hide()
		MacroButtonScrollFrameMiddle:Hide()
		MacroFrame.TopTileStreaks:Hide()
		MacroFrameSelectedMacroBackground:SetColorTexture(0, 0, 0, 0) -- Can't hide this texture before it's shown
		MacroFrameEnterMacroText:SetText("")

		-- YEET this stupid bar outta here
		MacroHorizontalBarLeft:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -1000, 1000)

		-- Macro frame inset adjustment
		MacroFrame.Inset:SetPoint("BOTTOMRIGHT", -12 - 256, 26 + 128 + 193)

		-- Move selected macro button + its related assets
		MacroFrameSelectedMacroButton:SetPoint("TOPLEFT", MacroButtonScrollFrame, "BOTTOMLEFT", 6, -12)
		MFSM_Edit = CreateFrame("Button", "EditMacroIcon", MacroFrameSelectedMacroButton)
		MFSM_Edit:SetPoint("BOTTOMRIGHT", 0, -3)
		MFSM_Edit:SetSize(16, 16)
		MFSM_Edit:SetNormalFontObject(MacroBlockSymbolFont_Normal)
		MFSM_Edit:SetHighlightFontObject(MacroBlockSymbolFont_Highlight)
		MFSM_Edit:SetDisabledFontObject(MacroBlockSymbolFont_Disabled)
		MFSM_Edit:SetPushedTextOffset(1, -1)
		MFSM_Edit:SetText("🖍")
		MFSM_Edit:SetScript("OnLeave", function(_self) _self:SetButtonState("NORMAL") end)
		MFSM_Edit:SetScript("OnClick", function(_self, button)
			MacroFrame_SaveMacro();	MacroPopupFrame.mode = "edit"; MacroPopupFrame:Show();
		end)

		MacroFrameSelectedMacroName = CreateFrame("EditBox", "SelectedMacroName", MacroFrame, "InputBoxTemplate")
		MacroFrameSelectedMacroName:SetAutoFocus(false)
		MacroFrameSelectedMacroName:SetSize(128, 18)
		MacroFrameSelectedMacroName:SetPoint("TOPLEFT", MacroFrameSelectedMacroButton, "TOPRIGHT", 16, 0)
		MFSM_Accept = CreateFrame("Button", "AcceptMacroName", MacroFrameSelectedMacroName, "SquareIconButtonTemplate")
		MFSM_Accept.iconAtlas = "common-icon-checkmark"
		MFSM_Accept:SetSize(26, 26)
		MFSM_Accept:SetPoint("LEFT", MacroFrameSelectedMacroName, "RIGHT", -2, 0)
		MFSM_Reject = CreateFrame("Button", "RejectMacroName", MacroFrameSelectedMacroName, "SquareIconButtonTemplate")
		MFSM_Reject.iconAtlas = "common-icon-redx"
		MFSM_Reject:SetSize(26, 26)
		MFSM_Reject:SetPoint("LEFT", MFSM_Accept, "RIGHT", -6, 0)
		MacroFrameSelectedMacroName:SetMaxLetters(16)
		MacroFrameSelectedMacroName:SetScript("OnEnterPressed", function(_self)
			_self:ClearFocus()
			local index = 1
			local iconTexture = MacroFrameSelectedMacroButtonIcon:GetTexture()
			local text = _self:GetText()
			text = string.gsub(text, "\"", "")
			index = EditMacro(MacroFrame.selectedMacro, text, iconTexture)
			MacroFrame_SelectMacro(index)
			MacroFrame_Update()
		end)
		MacroFrameSelectedMacroName:SetScript("OnEscapePressed", function(_self)
			_self:ClearFocus()
			MacroFrame_Update()
			MacroPopupFrame.selectedIcon = nil
		end)

		-- :SetFont("Interface\\AddOns\\MacroBlocks\\media\\NotoSansMono\\NotoSansMono-ExtraBold.ttf", 18)
		MacroFrameSelectedMacroButtonIcon:SetSize(38, 38)

		-- Palette frame positioning
		MBPaletteBasic:SetPoint("TOPLEFT", MBFrame, "TOPRIGHT", -256 - 10, -60)
		MBPaletteBasic:SetPoint("BOTTOMRIGHT", MBFrame, "BOTTOMRIGHT", -6, 128)

		-- Stack frame positioning
		MBStack:SetPoint("TOPLEFT", MBFrame, "BOTTOMLEFT", 4, 128 - 3)
		MBStack:SetPoint("BOTTOMRIGHT", MBFrame, "BOTTOMRIGHT", -6, 8)

		-- Title bar 'handle' that lets the user move the macro frame around the screen
		local dragBar = CreateFrame("Frame", "MBDragBar", MacroFrame)
		dragBar:SetPoint("TOPLEFT", MacroFrame, "TOPLEFT")
		dragBar:SetPoint("BOTTOMRIGHT", MBFrame, "TOPRIGHT", -24, -24)
		dragBar:EnableMouse(true)
		dragBar:SetScript("OnMouseDown", function(_self, button) if button == "LeftButton" then MacroFrame:StartMoving() end end)
		dragBar:SetScript("OnMouseUp", function(_self, button) if button == "LeftButton" then MacroFrame:StopMovingOrSizing() end end)

		MacroSaveButton:HookScript("OnClick", function()
			for _, block in pairs(MBStack.blocks) do
				block.saved = true
			end
		end)

		MacroCancelButton:HookScript("OnClick", function()
			local clearBlocks = {}
			for _, block in pairs(MBStack.blocks) do
				table.insert(clearBlocks, block)
			end
			for _, block in pairs(clearBlocks) do
				if not block.saved then
					if block.group == "Smart" then block.UNHOOK_PAYLOAD() end
    	    		MBStack.remBlock(block)

					MB_OnDragStop(block)
				end
			end
			clearBlocks = nil
		end)

		-- Attach addon's visibility to blizzard's macro frame visibility
		MacroFrame:HookScript("OnShow", function()
			MBFrame:Show()

			-- MacroFrameSelectedMacroBackground:Hide()

			--[[MacroSaveButton.Left:SetTexture("Interface/Buttons/128RedButton")
			MacroSaveButton.Middle:SetTexture("Interface/Buttons/128RedButton")
			MacroSaveButton.Right:SetTexture("Interface/Buttons/128RedButton")

			MacroSaveButton.Left:SetTexCoord(0.763671875, 0.986328125, 0.44482421875, 0.50732421875)
			MacroSaveButton.Middle:SetTexCoord(0, 0.125, 0.00048828125, 0.06298828125)
			MacroSaveButton.Right:SetTexCoord(0.001953125, 0.572265625, 0.25439453125, 0.31689453125)]]

			MacroBlocks_mb_Init()

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