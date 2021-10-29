local addon, mb = ...
local frame = CreateFrame("Frame", nil, UIParent)

SLASH_PRINT1 = "/print"
SlashCmdList["PRINT"] = function(msg, editBox)
	SlashCmdList.SCRIPT("print("..msg..")")
end

local mb_init = false

-- Math utility
local function round(number, decimals)
	return tonumber((("%%.%df"):format(decimals)):format(number))
end

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
	-- bool = bool or index == #mb.Stack.blocks
	bool = bool or #mb.Stack.blocks == 1
	bool = bool or mb.Stack.blocks[index-1].group == "Smart"
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
	xOff = xOff or 7
	yOff = yOff or -6

	if index <= #mb.Stack.blocks then

		if (xOff + mb.Stack.blocks[index]:GetWidth()) >= (mb.Stack:GetWidth() - 6) then
			xOff = 4
			yOff = yOff - 32
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

mb.Stack.saveBlocks = function()

end

--[[
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
		MacroFrameCharLimitText:SetParent(MacroFrameTextBackground)
		MacroFrameCharLimitText:SetPoint("BOTTOMRIGHT", MacroFrameTextBackground, "BOTTOMRIGHT", -28, 9)

		-- Parent our addon's parent frame to the macro frame
		mb.Frame:SetParent(MacroFrame)
		mb.Frame:SetAllPoints()

		-- Reposition buttons croll frame
		MacroButtonScrollFrame:SetPoint("TOPLEFT", 12, -64)

		-- Reposition scroll bar
		MacroButtonScrollFrameScrollBar:SetPoint("TOPLEFT", MacroButtonScrollFrame, "TOPRIGHT", 3, -16)
		MacroButtonScrollFrameScrollBar:SetPoint("BOTTOMLEFT", MacroButtonScrollFrame, "BOTTOMRIGHT", 3, 16)

		MacroFrameTextBackground:SetBackdrop(BACKDROP_TOAST_12_12)
		MacroFrameScrollFrameScrollBar:SetPoint("TOPLEFT", MacroFrameScrollFrame, "TOPRIGHT", 3, -16)
		MacroFrameScrollFrameScrollBar:SetPoint("BOTTOMLEFT", MacroFrameScrollFrame, "BOTTOMRIGHT", 3, 18)
		MacroFrameTextBackground:SetSize(326, 112)
		MacroFrameScrollFrame:SetSize(290, 102)
		MacroFrameText:SetSize(290, 112)
		MacroFrameTextButton:SetSize(290, 100)

		MacroFrameCharLimitText:SetJustifyH("LEFT")
		MacroFrameCharLimitText:SetFontObject(MacroBlockMonoFont)

		MacroFrameText:SetScript("OnTextChanged", function(_self, userInput)
			local cCount = MacroFrameText:GetNumLetters()
			MacroFrame.textChanged = 1;

			if ( MacroPopupFrame.mode == "new" ) then MacroPopupFrame:Hide(); end

			MacroFrameCharLimitText:SetText("["..cCount.."/255]")

			if cCount >= 170 and cCount < 210 then
				MacroFrameCharLimitText:SetTextColor(1, 1, 0, 0.4)
			elseif cCount >= 210 then
				MacroFrameCharLimitText:SetTextColor(1, 0, 0, 0.5)
			else
				MacroFrameCharLimitText:SetTextColor(1, 1, 1, 0.3)
			end

			ScrollingEdit_OnTextChanged(_self, _self:GetParent());
		end)

		-- Hide all the stupid ugly shit
		MacroButtonScrollFrameTop:Hide()
		MacroButtonScrollFrameBottom:Hide()
		MacroButtonScrollFrameMiddle:Hide()
		MacroFrame.TopTileStreaks:Hide()
		MacroFrameSelectedMacroBackground:SetColorTexture(0, 0, 0, 0) -- Can't hide this texture before it's shown
		MacroFrameEnterMacroText:SetText("")
		MacroEditButton:SetParent(UIParent)
		MacroEditButton:ClearAllPoints()
		MacroEditButton:Hide()
		MacroEditButton:Disable()
		MacroEditButton:SetPoint("TOPLEFT", MacroFrame, "TOPRIGHT", 20, 0)
		MacroSaveButton:ClearAllPoints()
		MacroSaveButton:SetPoint("TOPLEFT", MacroFrame, "TOPRIGHT", 20, -20)
		MacroCancelButton:ClearAllPoints()
		MacroCancelButton:SetPoint("TOPLEFT", MacroFrame, "TOPRIGHT", 20, -40)
		MacroDeleteButton:ClearAllPoints()
		MacroDeleteButton:SetPoint("TOPLEFT", MacroFrame, "TOPRIGHT", 20, -60)
		MacroNewButton:ClearAllPoints()
		MacroNewButton:SetPoint("TOPLEFT", MacroFrame, "TOPRIGHT", 20, -80)
		MacroExitButton:ClearAllPoints()
		MacroExitButton:SetPoint("TOPLEFT", MacroFrame, "TOPRIGHT", 20, -100)
		-- YEEEEET this fuckin' dumb bar outta here cos the right half
		-- can't be accessed and we want both halves GONE (Blizzard pls name your frames...)
		MacroHorizontalBarLeft:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -1000, 1000)

		-- Macro frame inset adjustment
		MacroFrame.Inset:SetPoint("BOTTOMRIGHT", -12 - 256, 26 + 128 + 193)

		-- Redfine selected macro frames
		MFSM = CreateFrame("Frame", "MacroFrameSelectedMacro", MacroFrame)
		MFSM:SetSize(324, 56)
		MFSM:SetPoint("TOP", MacroFrame.Inset, "BOTTOM", 0, -4)

		MacroFrameTextBackground:SetPoint("TOPLEFT", MFSM, "BOTTOMLEFT", 0, -2)
		MacroFrameScrollFrame:SetPoint("TOPLEFT", MFSM, "BOTTOMLEFT", 11, -8)

		-- MFSM.bg = MFSM:CreateTexture("$parentBackground", "BACKGROUND")
		-- MFSM.bg:SetAtlas("auctionhouse-itemheaderframe")
		-- MFSM.bg:SetPoint("TOPLEFT", 58, -1)
		-- MFSM.bg:SetPoint("BOTTOMRIGHT", 0, 1)

		MFSM.Button = MacroFrameSelectedMacroButton

		MFSM.Button:SetPoint("TOPLEFT", MFSM, "TOPLEFT")
		MFSM.Button:SetSize(56, 56)

		MFSM.Button.Config = CreateFrame("Button", "$parentConfig", MFSM.Button)
		MFSM.Button.Config:SetSize(18, 18)
		MFSM.Button.Config:SetPoint("BOTTOMRIGHT", 1, -1)
		MFSM.Button.Config.tex = MFSM.Button.Config:CreateTexture(nil, "ARTWORK")
		MFSM.Button.Config.tex:SetPoint("CENTER", -2, 2)
		MFSM.Button.Config.tex:SetSize(14, 14)
		MFSM.Button.Config.tex:SetTexture("Interface\\Worldmap\\Gear_64Grey")
		MFSM.Button.Config.tex:SetAlpha(0.6)

		MFSM.Button.Config:SetScript("OnEnter", function(_self) _self.tex:SetAlpha(1) end)
		MFSM.Button.Config:SetScript("OnLeave", function(_self) _self.tex:SetAlpha(0.6) end)
		MFSM.Button.Config:SetScript("OnClick", function() MacroFrame_SaveMacro(); MacroPopupFrame.mode = "edit"; MacroPopupFrame:Show(); end)
		-- MFSM.Button.Name = MacroFrameSelectedMacroButtonName

		MFSM.Button.Icon = MacroFrameSelectedMacroButtonIcon
		MFSM.Button.Icon:SetAllPoints()
		MFSM.Button.Mask = MFSM.Button:CreateMaskTexture(nil, "BACKGROUND")
		MFSM.Button.Mask:SetAllPoints(MFSM.Button.Icon)
		MFSM.Button.Mask:SetAtlas("UI-Frame-IconMask")
		MFSM.Button.Icon:AddMaskTexture(MFSM.Button.Mask)

		MFSM.Button.Border = MFSM.Button:CreateTexture(nil, "OVERLAY")
		MFSM.Button.Border:SetAtlas("adventures-spell-border")
		MFSM.Button.Border:SetPoint("CENTER")
		MFSM.Button.Border:SetSize(62, 62)

		MFSM.Button.bg = MFSM.Button:CreateTexture("$parentBackground", "BACKGROUND")
		MFSM.Button.bg:SetAtlas("auctionhouse-itemicon-empty")
		MFSM.Button.bg:SetAllPoints()

		MFSM.Name=CreateFrame("EditBox", "MacroFrameSelectedMacroName", MacroFrame, "InputBoxTemplate")
		MFSM.Name:SetAutoFocus(false)
		MFSM.Name:SetSize(164, 24)
		MFSM.Name:SetPoint("TOPLEFT", MFSM.Button, "TOPRIGHT", 10, -1)
		MFSM.Name:SetMaxLetters(16)
		MFSM.Name.Left:SetAtlas("auctionhouse-ui-inputfield-left"); MFSM.Name.Left:SetSize(8, 28); MFSM.Name.Left:SetPoint("LEFT", -8, -2)
		MFSM.Name.Right:SetAtlas("auctionhouse-ui-inputfield-right"); MFSM.Name.Right:SetSize(8, 28); MFSM.Name.Right:SetPoint("RIGHT", 0, -2)
		MFSM.Name.Middle:SetAtlas("auctionhouse-ui-inputfield-middle"); MFSM.Name.Middle:SetSize(179, 28)
		MFSM.Name:SetScript("OnEnterPressed", function(_self)
			_self:ClearFocus()
			local index = 1
			local iconTexture = MFSM.Button.Icon:GetTexture()
			local text = _self:GetText()
			text = string.gsub(text, "\"", "")
			index = EditMacro(MacroFrame.selectedMacro, text, iconTexture)
			MacroFrame_SelectMacro(index)
			MacroFrame_Update()
		end)
		MFSM.Name:SetScript("OnEscapePressed", function(_self)
			_self:ClearFocus()
			MacroFrame_Update()
			MacroPopupFrame.selectedIcon = nil
		end)

		MacroFrameSelectedMacroButtonIcon = MFSM.Button.Icon
		MacroFrameSelectedMacroButtonName = MFSM.Button.Name
		MacroFrameSelectedMacroButton = MFSM.Button
		MacroFrameSelectedMacroName = MFSM.Name

		-- Palette frame positioning
		MBPaletteBasic:SetPoint("TOPLEFT", MacroFrame.Inset, "TOPRIGHT", 2, 0)
		MBPaletteBasic:SetPoint("BOTTOMRIGHT", MacroFrameTextBackground, "BOTTOMRIGHT", 262, 2)

		-- Stack frame positioning
		mb.Stack:SetPoint("TOPRIGHT", MBPaletteBasic, "BOTTOMRIGHT", 0, -4)
		mb.Stack:SetPoint("BOTTOMLEFT", mb.Frame, "BOTTOMLEFT", 6, 7)

		-- Title bar 'handle' that lets the user move the macro frame around the screen
		local dragBar = CreateFrame("Frame", "MBDragBar", MacroFrame)
		dragBar:SetPoint("TOPLEFT", MacroFrame, "TOPLEFT")
		dragBar:SetPoint("BOTTOMRIGHT", mb.Frame, "TOPRIGHT", -24, -24)
		dragBar:EnableMouse(true)
		dragBar:SetScript("OnMouseDown", function(_self, button) if button == "LeftButton" then MacroFrame:StartMoving() end end)
		dragBar:SetScript("OnMouseUp", function(_self, button) if button == "LeftButton" then MacroFrame:StopMovingOrSizing() end end)

		MacroSaveButton:HookScript("OnClick", function()
			for _, block in pairs(mb.Stack.blocks) do
				block.saved = true
			end
		end)

		MacroCancelButton:HookScript("OnClick", function()
			local clearBlocks = {}
			for _, block in pairs(mb.Stack.blocks) do
				table.insert(clearBlocks, block)
			end
			for _, block in pairs(clearBlocks) do
				if not block.saved then
					if block.group == "Smart" then block.UNHOOK_PAYLOAD() end
    	    		mb.Stack.remBlock(block)

					MB_OnDragStop(block)
				end
			end
			clearBlocks = nil
		end)

		-- Attach addon's visibility to blizzard's macro frame visibility
		MacroFrame:HookScript("OnShow", function()
			mb.Frame:Show()

			-- MacroFrameSelectedMacroBackground:Hide()

			--[-[MacroSaveButton.Left:SetTexture("Interface/Buttons/128RedButton")
			MacroSaveButton.Middle:SetTexture("Interface/Buttons/128RedButton")
			MacroSaveButton.Right:SetTexture("Interface/Buttons/128RedButton")

			MacroSaveButton.Left:SetTexCoord(0.763671875, 0.986328125, 0.44482421875, 0.50732421875)
			MacroSaveButton.Middle:SetTexCoord(0, 0.125, 0.00048828125, 0.06298828125)
			MacroSaveButton.Right:SetTexCoord(0.001953125, 0.572265625, 0.25439453125, 0.31689453125)]-]

			MacroBlocks_mb_Init()

		end)
		MacroFrame:HookScript("OnHide", function()
			mb.Frame:Hide()
		end)
	end
end)
]]

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