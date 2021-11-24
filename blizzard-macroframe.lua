local addon, mb = ...

mb.textureLoadGroup=CreateFromMixins(TextureLoadingGroupMixin)
mb.textureLoadGroup:AddTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_normal.tga")
mb.textureLoadGroup:AddTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_pushed.tga")
-- mb.textureLoadGroup:AddTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_highlight.tga")
mb.textureLoadGroup:AddTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_disabled.tga")

local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg)
    if event == "ADDON_LOADED" and arg == "Blizzard_MacroUI" then
		if not MacroFrame then return end

		-- Resize the macro frame and change it's UIPanel attributes to correct repositioning interactions
		MacroFrame:SetSize(600, 560)


		-- Make the macro frame moveable by the user
		MacroFrame:SetMovable(true)
		MacroFrame:RegisterForDrag()
		MacroFrame:SetClampedToScreen(true)

		MacroFrameEnterMacroText:SetText("")

		-- Trash all the original MacroFrame elements in favor of replacing them with our own
		local bin = { MacroEditButton, MacroExitButton, MacroSaveButton, MacroCancelButton, MacroDeleteButton, MacroNewButton, MacroFrameEnterMacroText, MacroButtonScrollFrameTop, MacroButtonScrollFrameBottom, MacroButtonScrollFrameMiddle, MacroFrameSelectedMacroBackground, MacroHorizontalBarLeft, MacroPopupFrame, MacroButtonScrollFrameTop, MacroButtonScrollFrameBottom, MacroButtonScrollFrameMiddle }

		for _, trash in ipairs(bin) do
			trash:SetParent(UIParent)
			trash:Hide()
			trash:ClearAllPoints()
		end

		-- Hide the things we can't put in the bin neatly
		MacroFrame.TopTileStreaks:Hide()
		MacroFrame.TopTileStreaks:ClearAllPoints()

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

		---------------------
		-- MacroPopupFrame --
		---------------------
		local iconInfo = MacroPopupFrame.BorderBox:CreateFontString("IconPath", "ARTWORK", "MacroBlocksFont")
		iconInfo:SetPoint("BOTTOMLEFT", "$parent", "BOTTOMLEFT", 8, 8)
		iconInfo:SetPoint("TOPRIGHT", MacroPopupFrame.BorderBox.OkayButton, "TOPLEFT")

		local function MacroPopupButton_OnEnter(_self)
			iconInfo:SetText(self:GetTexture())
		end



		-- Macro frame inset adjustment
		MacroFrame.Inset:SetPoint("BOTTOMRIGHT", -12 - 256, 26 + 128 + 193)

		-- Redfine selected macro frames
		MFSM=CreateFrame("Frame", "MBSelectedMacro", mb.Frame)
		MFSM:SetSize(324, 56)
		MFSM:SetPoint("TOP", MacroFrame.Inset, "BOTTOM", 0, -4)

		MacroFrameTextBackground:SetPoint("TOPLEFT", MFSM, "BOTTOMLEFT", 0, -2)
		MacroFrameScrollFrame:SetPoint("TOPLEFT", MFSM, "BOTTOMLEFT", 11, -8)

		local btn = {}

		btn.selected=MacroFrameSelectedMacroButton
		btn.selected:SetPoint("TOPLEFT", MFSM, "TOPLEFT")
		btn.selected:SetSize(56, 56)

		btn.selected.Config=CreateFrame("Button", "$parentConfig", btn.selected)
		btn.selected.Config:SetSize(18, 18)
		btn.selected.Config:SetPoint("BOTTOMRIGHT", 2, -1)
		btn.selected.Config:SetNormalTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_normal.tga")
		btn.selected.Config:SetPushedTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_pushed.tga")
		-- btn.selected.Config:SetHighlightTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_highlight.tga")
		btn.selected.Config:SetDisabledTexture("Interface\\AddOns\\MacroBlocks\\media\\textures\\gear_disabled.tga")

		btn.selected.Icon=MacroFrameSelectedMacroButtonIcon
		btn.selected.Icon:SetAllPoints()

		btn.selected.mask=btn.selected:CreateMaskTexture(nil, "BACKGROUND")
		btn.selected.mask:SetAllPoints(btn.selected.Icon)
		btn.selected.mask:SetAtlas("UI-Frame-IconMask")

		btn.selected.Icon:AddMaskTexture(btn.selected.mask)

		btn.selected.highlight = btn.selected:CreateTexture(nil, "HIGHLIGHT")
		btn.selected.highlight:SetSize(68, 68)
		btn.selected.highlight:SetPoint("CENTER")
		btn.selected.highlight:SetAtlas("bags-newitem")
		btn.selected.highlight:AddMaskTexture(btn.selected.mask)

		btn.selected:SetHighlightTexture(btn.selected.highlight, "ADD")

		btn.selected.Border=btn.selected:CreateTexture(nil, "OVERLAY")
		btn.selected.Border:SetAtlas("adventures-spell-border")
		btn.selected.Border:SetPoint("CENTER")
		btn.selected.Border:SetSize(62, 62)

		btn.selected.bg=btn.selected:CreateTexture("$parentBackground", "BACKGROUND")
		btn.selected.bg:SetAtlas("auctionhouse-itemicon-empty")
		btn.selected.bg:SetAllPoints()

		btn.name=CreateFrame("EditBox", "$parentName", mb.Frame, "InputBoxTemplate")
		btn.name:SetAutoFocus(false)
		btn.name:SetSize(164, 24)
		btn.name:SetPoint("TOPLEFT", btn.selected, "TOPRIGHT", 10, -1)
		btn.name:SetMaxLetters(16)

		btn.save=CreateFrame("Button", "$parentSave", mb.Frame, "SharedButtonSmallTemplate")
		btn.save:SetPoint("TOPLEFT", btn.name, "BOTTOMLEFT", -8, -4)
		btn.save:SetSize(86, 28)
		btn.save:SetText("Save")

		btn.cancel=CreateFrame("Button", "$parentCancel", mb.Frame, "SharedButtonSmallTemplate")
		btn.cancel:SetPoint("TOPLEFT", btn.save, "TOPRIGHT", 2, 0)
		btn.cancel:SetSize(86, 28)
		btn.cancel:SetText("Cancel")

		btn.delete=CreateFrame("Button", "$parentDelete", mb.Frame, "SharedButtonSmallTemplate")
		btn.delete:SetPoint("TOPLEFT", btn.cancel, "TOPRIGHT", 2, 0)
		btn.delete:SetSize(86, 28)
		btn.delete:SetText("Delete")

		btn.new=CreateFrame("Button", "$parentNew", mb.Frame, "SharedButtonSmallTemplate")
		btn.new:SetPoint("BOTTOM", btn.delete, "TOP", 0, 2)
		btn.new:SetSize(86, 28)
		btn.new:SetText("New")

		local info = CreateFrame("Frame", "$parentInfo", mb.Frame)
		info:SetPoint("TOPRIGHT", -6, -29)
		info:SetSize(36, 36)
		info.text = info:CreateFontString(nil, "ARTWORK", "MacroBlocksSymbolFont_Large")
		info.text:SetPoint("CENTER")
		info.text:SetAlpha(0.5)
		info.text:SetText("🛈")
		info:SetScript("OnEnter", function(_self)
			info.text:SetAlpha(1)
			GameTooltip:SetOwner(_self, "ANCHOR_RIGHT", 0, -_self:GetHeight());
			GameTooltip:AddLine("Macro Blocks")
			GameTooltip:AddLine("Hold 'Shift' with your cursor over any block to display tooltips.")
        	GameTooltip:Show()
		end)
		info:SetScript("OnLeave", function(_self)
			info.text:SetAlpha(0.5)
			if GameTooltip:IsOwned(_self) then
				GameTooltip:Hide()
			end
		end)

		-- btn.copy=CreateFrame("Button", "$parentCopy", mb.Frame, "SharedButtonTemplate")

		btn.name.Left:SetAtlas("auctionhouse-ui-inputfield-left"); btn.name.Left:SetSize(8, 28); btn.name.Left:SetPoint("LEFT", -8, -2)
		btn.name.Right:SetAtlas("auctionhouse-ui-inputfield-right"); btn.name.Right:SetSize(8, 28); btn.name.Right:SetPoint("RIGHT", 0, -2)
		btn.name.Middle:SetAtlas("auctionhouse-ui-inputfield-middle"); btn.name.Middle:SetSize(179, 28)

		MacroFrameSelectedMacroButtonIcon = btn.selected.Icon
		MacroFrameSelectedMacroButtonName = btn.selected.Name
		MacroFrameSelectedMacroButton = btn.selected
		MacroFrameSelectedMacroName = btn.name
		MacroEditButton = btn.selected.Config
		MacroSaveButton = btn.save
		MacroCancelButton = btn.cancel
		MacroDeleteButton = btn.delete
		MacroNewButton = btn.new

		-- Palette frame positioning
		mb.Palette:SetPoint("TOPLEFT", MacroFrame.Inset, "TOPRIGHT", 2, 0)
		mb.Palette:SetPoint("BOTTOMRIGHT", MacroFrameTextBackground, "BOTTOMRIGHT", 262, 2)

		-- Stack frame positioning
		mb.Stack:SetPoint("TOPRIGHT", mb.Palette, "BOTTOMRIGHT", 0, -4)
		mb.Stack:SetPoint("BOTTOMLEFT", mb.Frame, "BOTTOMLEFT", 6, 7)

		-- Title bar 'handle' that lets the user move the macro frame around the screen
		local dragBar = CreateFrame("Frame", "$parentDragBar", mb.Frame)
		dragBar:SetPoint("TOPLEFT", MacroFrame, "TOPLEFT")
		dragBar:SetPoint("BOTTOMRIGHT", mb.Frame, "TOPRIGHT", -24, -24)
		dragBar:EnableMouse(true)

		btn.selected.Config:SetScript("OnClick", function() MacroFrame_SaveMacro(); MacroPopupFrame.mode = "edit"; MacroPopupFrame:Show(); end)

		dragBar:SetScript("OnMouseDown", function(_self, button)
			if button == "LeftButton" then
				MacroFrame:StartMoving()
			end
		end)

		dragBar:SetScript("OnMouseUp", function(_self, button)
			if button == "LeftButton" then
				MacroFrame:StopMovingOrSizing()
			end
		end)



		btn.new:SetScript("OnClick", function(_self, button)
			MacroFrame_SaveMacro()
			MacroPopupFrame.mode = "new"
			MacroPopupFrame:Show()
		end)

		btn.delete:SetScript("OnClick", function(_self, button)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			StaticPopup_Show("CONFIRM_DELETE_SELECTED_MACRO")
		end)
	end
end)