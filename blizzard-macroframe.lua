local addon, mb = ...

mb.textureLoadGroup=CreateFromMixins(TextureLoadingGroupMixin)
mb.textureLoadGroup:AddTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_normal.tga")
mb.textureLoadGroup:AddTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_pushed.tga")
-- mb.textureLoadGroup:AddTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_highlight.tga")
mb.textureLoadGroup:AddTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_disabled.tga")

local MACRO_FRAME_BUTTONS_SETENABLED = function(bool)
	MacroSaveButton:SetEnabled(bool)
	MacroCancelButton:SetEnabled(bool)
end

local MACRO_NAME_ONENTERPRESSED = function(self)
    self:ClearFocus()
	local index = 1
	local iconTexture = MFSM.Button.Icon:GetTexture()
	local text = self:GetText()
	text = string.gsub(text, "\"", "")
	index = EditMacro(MacroFrame.selectedMacro, text, iconTexture)
	MacroFrame_SelectMacro(index)
	MacroFrame_Update()
end

local MACRO_NAME_ONESCAPEPRESSED = function(self)
	self:ClearFocus()
	MacroFrame_Update()
	MacroPopupFrame.selectedIcon = nil
end

local MACRO_TEXT_ONTEXTCHANGED = function(self, userInput)
    local cCount = MacroFrameText:GetNumLetters()
	MacroFrame.textChanged = 1

	if ( MacroPopupFrame.mode == "new" ) then MacroPopupFrame:Hide(); end

	MacroFrameCharLimitText:SetText("["..cCount.."/255]")

	if cCount >= 170 and cCount < 210 then
		MacroFrameCharLimitText:SetTextColor(1, 1, 0, 0.4)
	elseif cCount >= 210 then
		MacroFrameCharLimitText:SetTextColor(1, 0, 0, 0.5)
	else
		MacroFrameCharLimitText:SetTextColor(1, 1, 1, 0.3)
	end

	MACRO_FRAME_BUTTONS_SETENABLED(true)

	ScrollingEdit_OnTextChanged(self, self:GetParent());
end

local MACRO_SAVE_ONCLICK = function()
	-- mb.LogEditHistory(MacroFrame.selectedMacro, date("%y-%m-%d_%X"))

	for _, block in pairs(mb.Stack.blocks) do
		block.saved = true
	end

	if MacroFrame.selectedMacro > 120 then
		mb.UserMacros[MacroFrame.selectedMacro][mb.CharacterID]["body"] = MacroFrameText:GetText()
	else
		mb.UserMacros[MacroFrame.selectedMacro]["body"] = MacroFrameText:GetText()
	end

	MACRO_FRAME_BUTTONS_SETENABLED(false)

end

local MACRO_CANCEL_ONCLICK = function()
	mb.Stack.preserve = true

    local clearBlocks = {}
	for _, block in pairs(mb.Stack.blocks) do table.insert(clearBlocks, block) end

    for _, block in pairs(clearBlocks) do
		if not block.saved then
			-- if block.group == "SMT" then block.UNHOOK() end
  			mb.Stack.remBlock(block)
		    MB_OnDragStop(block)
	    end
	end


	if MacroFrame.selectedMacro > 120 then
		MacroFrameText:SetText(mb.UserMacros[MacroFrame.selectedMacro][mb.CharacterID]["body"])
	else
		MacroFrameText:SetText(mb.UserMacros[MacroFrame.selectedMacro]["body"])
	end
	MacroFrame.changes = false

	clearBlocks = nil
	
	mb.Stack.preserve = false
	MACRO_FRAME_BUTTONS_SETENABLED(false)
end

local MACRO_NEW_ONCLICK = function()
	MacroFrame_SaveMacro()
	MacroPopupFrame.mode = "new"
	MacroPopupFrame:Show()
end

local MACRO_DELETE_ONCLICK = function()
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	StaticPopup_Show("CONFIRM_DELETE_SELECTED_MACRO")
end

local MACRO_FRAME_UPDATE = function()
	local numMacros;
	local numAccountMacros, numCharacterMacros = GetNumMacros();
	local macroButtonName, macroButton, macroIcon, macroName;
	local name, texture, body;
	local selectedName, selectedBody, selectedIcon;

	if ( MacroFrame.macroBase == 0 ) then
		numMacros = numAccountMacros;
	else
		numMacros = numCharacterMacros;
	end

	-- Macro List
	local maxMacroButtons = max(MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS);
	for i=1, maxMacroButtons do
		macroButtonName = "MacroButton"..i;
		macroButton = _G[macroButtonName];
		macroIcon = _G[macroButtonName.."Icon"];
		macroName = _G[macroButtonName.."Name"];
		if ( i <= MacroFrame.macroMax ) then
			if ( i <= numMacros ) then
				name, texture, body = GetMacroInfo(MacroFrame.macroBase + i);
				macroIcon:SetTexture(texture);
				macroName:SetText(name);
				macroButton:Enable();
				-- Highlight Selected Macro
				if ( MacroFrame.selectedMacro and (i == (MacroFrame.selectedMacro - MacroFrame.macroBase)) ) then
					macroButton:SetChecked(true);
					MacroFrameSelectedMacroName:SetText(name);
					MacroFrameText:SetText(body);
					MacroFrameSelectedMacroButton:SetID(i);
					MacroFrameSelectedMacroButtonIcon:SetTexture(texture);
					if (type(texture) == "number") then
						MacroPopupFrame.selectedIconTexture = texture;
					elseif (type(texture) == "string") then
						MacroPopupFrame.selectedIconTexture = gsub( strupper(texture), "INTERFACE\\ICONS\\", "");
					else
						MacroPopupFrame.selectedIconTexture = nil;
					end
				else
					macroButton:SetChecked(false);
				end
			else
				macroButton:SetChecked(false);
				macroIcon:SetTexture("");
				macroName:SetText("");
				macroButton:Disable();
			end
			macroButton:Show();
		else
			macroButton:Hide();
		end
	end

	-- Macro Details
	if ( MacroFrame.selectedMacro ~= nil ) then
		MacroFrame_ShowDetails();
		MacroDeleteButton:Enable();
	else
		MacroFrame_HideDetails();
		MacroDeleteButton:Disable();
	end
	
	--Update New Button
	if ( numMacros < MacroFrame.macroMax ) then
		MacroNewButton:Enable();
	else
		MacroNewButton:Disable();
	end

	-- Disable Buttons
	if ( MacroPopupFrame:IsShown() ) then
		MacroEditButton:Disable();
		MacroDeleteButton:Disable();
	else
		MacroEditButton:Enable();
		MacroDeleteButton:Enable();
	end

	if ( not MacroFrame.selectedMacro ) then
		MacroDeleteButton:Disable();
	end
end

local frame = CreateFrame("Frame", nil, UIParent)
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

		-- Trash all the original MacroFrame elements in favor of replacing them with our own
		local bin = { MacroEditButton, MacroExitButton, MacroSaveButton, MacroCancelButton, MacroDeleteButton, MacroNewButton, MacroFrameEnterMacroText, MacroButtonScrollFrameTop, MacroButtonScrollFrameBottom, MacroButtonScrollFrameMiddle, MacroFrameSelectedMacroBackground, MacroHorizontalBarLeft, MacroPopupFrame, MacroButtonScrollFrameTop, MacroButtonScrollFrameBottom, MacroButtonScrollFrameMiddle }

		for _, trash in pairs(bin) do
			trash:SetParent(UIParent)
			trash:ClearAllPoints()
			trash:Hide()
		end

		-- Hide the things we can't put in the bin neatly
		MacroFrame.TopTileStreaks:Hide()

		-- YEEEEET this dumb bar outta here, the right half can't be accessed so its anchor has to be sent somewhere
		MacroHorizontalBarLeft:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -1000, 1000)

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
		MacroFrameCharLimitText:SetFontObject(MacroBlocksMonoFont)

		-- Macro frame inset adjustment
		MacroFrame.Inset:SetPoint("BOTTOMRIGHT", -12 - 256, 26 + 128 + 193)

		-- Redfine selected macro frames
		MFSM=CreateFrame("Frame", "MBSelectedMacro", mb.Frame)
		MFSM:SetSize(324, 56)
		MFSM:SetPoint("TOP", MacroFrame.Inset, "BOTTOM", 0, -4)

		MacroFrameTextBackground:SetPoint("TOPLEFT", MFSM, "BOTTOMLEFT", 0, -2)
		MacroFrameScrollFrame:SetPoint("TOPLEFT", MFSM, "BOTTOMLEFT", 11, -8)

		MFSM.Button=MacroFrameSelectedMacroButton
		MFSM.Button:SetPoint("TOPLEFT", MFSM, "TOPLEFT")
		MFSM.Button:SetSize(56, 56)

		MFSM.Button.Config=CreateFrame("Button", "$parentConfig", MFSM.Button)
		MFSM.Button.Config:SetSize(18, 18)
		MFSM.Button.Config:SetPoint("BOTTOMRIGHT", 2, -1)
		MFSM.Button.Config:SetNormalTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_normal.tga")
		MFSM.Button.Config:SetPushedTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_pushed.tga")
		-- MFSM.Button.Config:SetHighlightTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_highlight.tga")
		MFSM.Button.Config:SetDisabledTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_disabled.tga")

		MFSM.Button.Icon=MacroFrameSelectedMacroButtonIcon
		MFSM.Button.Icon:SetAllPoints()

		MFSM.Button.mask=MFSM.Button:CreateMaskTexture(nil, "BACKGROUND")
		MFSM.Button.mask:SetAllPoints(MFSM.Button.Icon)
		MFSM.Button.mask:SetAtlas("UI-Frame-IconMask")

		MFSM.Button.Icon:AddMaskTexture(MFSM.Button.mask)

		MFSM.Button.highlight = MFSM.Button:CreateTexture(nil, "HIGHLIGHT")
		MFSM.Button.highlight:SetSize(68, 68)
		MFSM.Button.highlight:SetPoint("CENTER")
		MFSM.Button.highlight:SetAtlas("bags-newitem")
		MFSM.Button.highlight:AddMaskTexture(MFSM.Button.mask)

		MFSM.Button:SetHighlightTexture(MFSM.Button.highlight, "ADD")

		MFSM.Button.Border=MFSM.Button:CreateTexture(nil, "OVERLAY")
		MFSM.Button.Border:SetAtlas("adventures-spell-border")
		MFSM.Button.Border:SetPoint("CENTER")
		MFSM.Button.Border:SetSize(62, 62)

		MFSM.Button.bg=MFSM.Button:CreateTexture("$parentBackground", "BACKGROUND")
		MFSM.Button.bg:SetAtlas("auctionhouse-itemicon-empty")
		MFSM.Button.bg:SetAllPoints()

		MFSM.Name=CreateFrame("EditBox", "$parentName", mb.Frame, "InputBoxTemplate")
		MFSM.Name:SetAutoFocus(false)
		MFSM.Name:SetSize(164, 24)
		MFSM.Name:SetPoint("TOPLEFT", MFSM.Button, "TOPRIGHT", 10, -1)
		MFSM.Name:SetMaxLetters(16)

		MFSM.Save=CreateFrame("Button", "$parentSave", mb.Frame, "SharedButtonSmallTemplate")
		MFSM.Save:SetPoint("TOPLEFT", MFSM.Name, "BOTTOMLEFT", -8, -4)
		MFSM.Save:SetSize(86, 28)
		MFSM.Save:SetText("Save")

		MFSM.Cancel=CreateFrame("Button", "$parentCancel", mb.Frame, "SharedButtonSmallTemplate")
		MFSM.Cancel:SetPoint("TOPLEFT", MFSM.Save, "TOPRIGHT", 2, 0)
		MFSM.Cancel:SetSize(86, 28)
		MFSM.Cancel:SetText("Cancel")

		MFSM.Delete=CreateFrame("Button", "$parentDelete", mb.Frame, "SharedButtonSmallTemplate")
		MFSM.Delete:SetPoint("TOPLEFT", MFSM.Cancel, "TOPRIGHT", 2, 0)
		MFSM.Delete:SetSize(86, 28)
		MFSM.Delete:SetText("Delete")

		MFSM.New=CreateFrame("Button", "$parentNew", mb.Frame, "SharedButtonSmallTemplate")
		MFSM.New:SetPoint("BOTTOM", MFSM.Delete, "TOP", 0, 2)
		MFSM.New:SetSize(86, 28)
		MFSM.New:SetText("New")

		MFSM.Copy=CreateFrame("Button", "$parentCopy", mb.Frame, "SharedButtonTemplate")

		MFSM.Name.Left:SetAtlas("auctionhouse-ui-inputfield-left"); MFSM.Name.Left:SetSize(8, 28); MFSM.Name.Left:SetPoint("LEFT", -8, -2)
		MFSM.Name.Right:SetAtlas("auctionhouse-ui-inputfield-right"); MFSM.Name.Right:SetSize(8, 28); MFSM.Name.Right:SetPoint("RIGHT", 0, -2)
		MFSM.Name.Middle:SetAtlas("auctionhouse-ui-inputfield-middle"); MFSM.Name.Middle:SetSize(179, 28)

		MacroFrameSelectedMacroButtonIcon = MFSM.Button.Icon
		MacroFrameSelectedMacroButtonName = MFSM.Button.Name
		MacroFrameSelectedMacroButton = MFSM.Button
		MacroFrameSelectedMacroName = MFSM.Name
		MacroEditButton = MFSM.Button.Config
		MacroSaveButton = MFSM.Save
		MacroCancelButton = MFSM.Cancel
		MacroDeleteButton = MFSM.Delete
		MacroNewButton = MFSM.New

		-- Palette frame positioning
		MBPaletteBasic:SetPoint("TOPLEFT", MacroFrame.Inset, "TOPRIGHT", 2, 0)
		MBPaletteBasic:SetPoint("BOTTOMRIGHT", MacroFrameTextBackground, "BOTTOMRIGHT", 262, 2)

		-- Stack frame positioning
		mb.Stack:SetPoint("TOPRIGHT", MBPaletteBasic, "BOTTOMRIGHT", 0, -4)
		mb.Stack:SetPoint("BOTTOMLEFT", mb.Frame, "BOTTOMLEFT", 6, 7)

		-- Title bar 'handle' that lets the user move the macro frame around the screen
		local dragBar = CreateFrame("Frame", "$parentDragBar", mb.Frame)
		dragBar:SetPoint("TOPLEFT", MacroFrame, "TOPLEFT")
		dragBar:SetPoint("BOTTOMRIGHT", mb.Frame, "TOPRIGHT", -24, -24)
		dragBar:EnableMouse(true)

		MFSM.Button.Config:SetScript("OnClick", function() MacroFrame_SaveMacro(); MacroPopupFrame.mode = "edit"; MacroPopupFrame:Show(); end)

		dragBar:SetScript("OnMouseDown", function(_self, button) if button == "LeftButton" then MacroFrame:StartMoving() end end)
		dragBar:SetScript("OnMouseUp", function(_self, button) if button == "LeftButton" then MacroFrame:StopMovingOrSizing() end end)

        MFSM.Name:SetScript("OnEnterPressed", MACRO_NAME_ONENTERPRESSED)
        MFSM.Name:SetScript("OnEscapePressed", MACRO_NAME_ONESCAPEPRESSED)

		MFSM.New:SetScript("OnClick", MACRO_NEW_ONCLICK)
		MFSM.Delete:SetScript("OnClick", MACRO_DELETE_ONCLICK)

        MacroFrameText:SetScript("OnTextChanged", MACRO_TEXT_ONTEXTCHANGED)

		MacroSaveButton:HookScript("OnClick", MACRO_SAVE_ONCLICK)
		MacroCancelButton:HookScript("OnClick", MACRO_CANCEL_ONCLICK)

		MacroFrame_Update = MACRO_FRAME_UPDATE

		-- Attach addon's visibility to blizzard's macro frame visibility
		MacroFrame:HookScript("OnShow", function()
			mb.Frame:Show()
			mb.Init()
			MacroFrame.changes = false
			MacroSaveButton:Disable()
			MFSM.Save:Disable()
			MacroCancelButton:Disable()
			MFSM.Cancel:Disable()
		end)
		MacroFrame:HookScript("OnHide", function()
			mb.Frame:Hide()
		end)
	end
end)