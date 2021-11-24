local addon, mb = ...

-- local frame = CreateFrame("Frame", nil, UIParent)
-- frame:RegisterEvent("ADDON_LOADED")
-- frame:SetScript("OnEvent", function(f, event, arg)
--     if event == "ADDON_LOADED" and arg == "Blizzard_MacroUI" then

--         -- local bin = { MacroEditButton, MacroExitButton, MacroSaveButton, MacroCancelButton, MacroDeleteButton, MacroNewButton, MacroFrameEnterMacroText, MacroButtonScrollFrameTop, MacroButtonScrollFrameBottom, MacroButtonScrollFrameMiddle, MacroFrameSelectedMacroBackground, MacroHorizontalBarLeft, MacroPopupFrame, MacroButtonScrollFrameTop, MacroButtonScrollFrameBottom, MacroButtonScrollFrameMiddle }

--         --------------------------------
--         -- Goldpaw's Big-Brain Corner --
--         --------------------------------
--         -- local hider = CreateFrame("Frame")
--         -- hider:Hide()

--         -- for _, trash in ipairs(bin) do
--         --     trash:SetParent(hider)
--         -- end

--         -- local MacroHorizontalBarRight
--         -- for i = 1, MacroFrame:GetNumRegions() do
--         --     local region = select(i, MacroFrame:GetRegions())
--         --     local point, anchor, rpoint = region:GetPoint()
--         --     if point == "LEFT" and anchor == MacroHorizontalBarLeft and rpoint == "RIGHT" then
--         --         local tex = region.GetTexture and region:GetTexture()
--         --         if tex == MacroHorizontalBarLeft:GetTexture() then
--         --             MacroHorizontalBarRight = region -- tadaaa!
--         --             break
--         --         end
--         --     end
--         -- end
--         --------------------------------
--         --------------------------------

--         -- NUM_MACROS_PER_ROW = 6;
--         -- NUM_ICONS_PER_ROW = 10;
--         -- NUM_ICON_ROWS = 9;
--         -- NUM_MACRO_ICONS_SHOWN = NUM_ICONS_PER_ROW * NUM_ICON_ROWS;
--         -- MACRO_ICON_ROW_HEIGHT = 36;
--         -- local MACRO_ICON_FILENAMES = nil;

--         -- UIPanelWindows["MacroFrame"] = { area = "left", pushable = 1, whileDead = 1, width = PANEL_DEFAULT_WIDTH };
--         UIPanelWindows["MacroFrame"] = { area = "left", pushable = 1, whileDead = 1, width = 600 }

--         -- StaticPopupDialogs["CONFIRM_DELETE_SELECTED_MACRO"] = {
--         --     text = CONFIRM_DELETE_MACRO,
--         --     button1 = OKAY,
--         --     button2 = CANCEL,
--         --     OnAccept = function(self)
--         --         MacroFrame_DeleteMacro()
--         --     end,
--         --     timeout = 0,
--         --     whileDead = 1,
--         --     showAlert = 1
--         -- };

--         -- MacroFrame_Show = function()
--         --     ShowUIPanel(MacroFrame);
--         -- end

--         -- MacroFrame_OnLoad = function(self)
--         --     MacroFrame_SetAccountMacros();
--         --     PanelTemplates_SetNumTabs(MacroFrame, 2);
--         --     PanelTemplates_SetTab(MacroFrame, 1);
--         -- end

--         -- MacroFrame_OnShow = function(self)
--         --     MacroFrame_Update();
--         --     PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
--         --     UpdateMicroButtons();
--         --     if ( not self.iconArrayBuilt ) then
--         --         BuildIconArray(MacroPopupFrame, "MacroPopupButton", "MacroPopupButtonTemplate", NUM_ICONS_PER_ROW, NUM_ICON_ROWS);
--         --         self.iconArrayBuilt = true;
--         --     end
--         -- end

--         MacroFrame:HookScript("OnShow", function(self)
--             MacroBlocks:Show()
--             -- mb.Frame:Show()
-- 			-- mb.Init()
-- 			-- mb.FillStack(MacroFrame.selectedMacro)

-- 			-- self.textChanged = nil
-- 			-- self.changes = false

-- 			-- MacroSaveButton:Disable()
-- 			-- MacroCancelButton:Disable()

-- 			-- MacroFrameText.saved = true
-- 		end)

--         -- MacroFrame_OnHide = function(self)
--         --     MacroPopupFrame:Hide();
--         --     MacroFrame_SaveMacro();
--         --     --SaveMacros();
--         --     PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE);
--         --     UpdateMicroButtons();
--         --     MACRO_ICON_FILENAMES = nil;
--         --     collectgarbage();
--         -- end

--         MacroFrame:HookScript("OnHide", function(_self)
-- 			MacroBlocks:Hide()
--             -- mb.Frame:Hide()
--             -- mb.EmptyStack()
-- 		end)

--         -- MacroFrame_SetAccountMacros = function()
--         --     MacroFrame.macroBase = 0;
--         --     MacroFrame.macroMax = MAX_ACCOUNT_MACROS;
--         --     local numAccountMacros, numCharacterMacros = GetNumMacros();
--         --     if ( numAccountMacros > 0 ) then
--         --         MacroFrame_SelectMacro(MacroFrame.macroBase + 1);
--         --     else
--         --         MacroFrame_SelectMacro(nil);
--         --     end
--         -- end

--         -- MacroFrame_SetCharacterMacros = function()
--         --     MacroFrame.macroBase = MAX_ACCOUNT_MACROS;
--         --     MacroFrame.macroMax = MAX_CHARACTER_MACROS;
--         --     local numAccountMacros, numCharacterMacros = GetNumMacros();
--         --     if ( numCharacterMacros > 0 ) then
--         --         MacroFrame_SelectMacro(MacroFrame.macroBase + 1);
--         --     else
--         --         MacroFrame_SelectMacro(nil);
--         --     end
--         -- end

--         -- MacroFrame_Update = function()
--         --     local numMacros;
--         --     local numAccountMacros, numCharacterMacros = GetNumMacros();
--         --     local macroButtonName, macroButton, macroIcon, macroName;
--         --     local name, texture, body;
--         --     local selectedName, selectedBody, selectedIcon;

--         --     if ( MacroFrame.macroBase == 0 ) then
--         --         numMacros = numAccountMacros;
--         --     else
--         --         numMacros = numCharacterMacros;
--         --     end

--         --     -- Macro List
--         --     local maxMacroButtons = max(MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS);
--         --     for i=1, maxMacroButtons do
--         --         macroButtonName = "MacroButton"..i;
--         --         macroButton = _G[macroButtonName];
--         --         macroIcon = _G[macroButtonName.."Icon"];
--         --         macroName = _G[macroButtonName.."Name"];
--         --         if ( i <= MacroFrame.macroMax ) then
--         --             if ( i <= numMacros ) then
--         --                 name, texture, body = GetMacroInfo(MacroFrame.macroBase + i);
--         --                 macroIcon:SetTexture(texture);
--         --                 macroName:SetText(name);
--         --                 macroButton:Enable();
--         --                 -- Highlight Selected Macro
--         --                 if ( MacroFrame.selectedMacro and (i == (MacroFrame.selectedMacro - MacroFrame.macroBase)) ) then
--         --                     macroButton:SetChecked(true);
--         --                     MacroFrameSelectedMacroName:SetText(name);
--         --                     MacroFrameText:SetText(body);
--         --                     MacroFrameSelectedMacroButton:SetID(i);
--         --                     MacroFrameSelectedMacroButtonIcon:SetTexture(texture);
--         --                     if (type(texture) == "number") then
--         --                         MacroPopupFrame.selectedIconTexture = texture;
--         --                     elseif (type(texture) == "string") then
--         --                         MacroPopupFrame.selectedIconTexture = gsub( strupper(texture), "INTERFACE\\ICONS\\", "");
--         --                     else
--         --                         MacroPopupFrame.selectedIconTexture = nil;
--         --                     end
--         --                 else
--         --                     macroButton:SetChecked(false);
--         --                 end
--         --             else
--         --                 macroButton:SetChecked(false);
--         --                 macroIcon:SetTexture("");
--         --                 macroName:SetText("");
--         --                 macroButton:Disable();
--         --             end
--         --             macroButton:Show();
--         --         else
--         --             macroButton:Hide();
--         --         end
--         --     end

--         --     -- Macro Details
--         --     if ( MacroFrame.selectedMacro ~= nil ) then
--         --         MacroFrame_ShowDetails();
--         --         MacroDeleteButton:Enable();
--         --     else
--         --         MacroFrame_HideDetails();
--         --         MacroDeleteButton:Disable();
--         --     end

--         --     --Update New Button
--         --     if ( numMacros < MacroFrame.macroMax ) then
--         --         MacroNewButton:Enable();
--         --     else
--         --         MacroNewButton:Disable();
--         --     end

--         --     -- Disable Buttons
--         --     if ( MacroPopupFrame:IsShown() ) then
--         --         MacroEditButton:Disable();
--         --         MacroDeleteButton:Disable();
--         --     else
--         --         MacroEditButton:Enable();
--         --         MacroDeleteButton:Enable();
--         --     end

--         --     if ( not MacroFrame.selectedMacro ) then
--         --         MacroDeleteButton:Disable();
--         --     end
--         -- end

--         local mbUpdate = function()
--             mb.EmptyStack()
--             mb.FillStack()
--         end
--         hooksecurefunc("MacroFrame_Update", mbUpdate)

--         -- MacroFrame_AddMacroLine = function(line)
--         --     if ( MacroFrameText:IsVisible() ) then
--         --         MacroFrameText:SetText(MacroFrameText:GetText()..line);
--         --     end
--         -- end

--         -- MacroButton_OnClick = function(self, button)
--         --     MacroFrame_SaveMacro();
--         --     MacroFrame_SelectMacro(MacroFrame.macroBase + self:GetID());
--         --     MacroFrame_Update();
--         --     MacroPopupFrame:Hide();
--         --     MacroFrameText:ClearFocus();
--         -- end

--         -- MacroFrameSaveButton_OnClick = function()
--         --     PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
--         --     MacroFrame_SaveMacro();
--         --     MacroFrame_Update();
--         --     MacroPopupFrame:Hide();
--         --     MacroFrameText:ClearFocus();
--         -- end

--         -- MacroFrameCancelButton_OnClick = function()
--         --     PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
--         --     MacroFrame_Update();
--         --     MacroPopupFrame:Hide();
--         --     MacroFrameText:ClearFocus();
--         -- end

--         -- MacroFrame_SelectMacro = function(id)
--         --     MacroFrame.selectedMacro = id;
--         -- end

--         -- MacroFrame_DeleteMacro = function()
--         --     local selectedMacro = MacroFrame.selectedMacro;
--         --     DeleteMacro(selectedMacro);
--         --     -- the order of the return values (account macros, character macros) matches up with the IDs of the tabs
--         --     local numMacros = select(PanelTemplates_GetSelectedTab(MacroFrame), GetNumMacros());
--         --     if ( selectedMacro > numMacros + MacroFrame.macroBase) then
--         --         selectedMacro = selectedMacro - 1;
--         --     end
--         --     if ( selectedMacro <= MacroFrame.macroBase ) then
--         --         MacroFrame.selectedMacro = nil;
--         --     else
--         --         MacroFrame.selectedMacro = selectedMacro;
--         --     end
--         --     MacroFrame_Update();
--         --     MacroFrameText:ClearFocus();
--         -- end

--         -- MacroNewButton_OnClick = function(self, button)
--         --     MacroFrame_SaveMacro();
--         --     MacroPopupFrame.mode = "new";
--         --     MacroPopupFrame:Show();
--         -- end

--         -- MacroEditButton_OnClick = function(self, button)
--         --     MacroFrame_SaveMacro();
--         --     MacroPopupFrame.mode = "edit";
--         --     MacroPopupFrame:Show();
--         -- end

--         -- MacroFrame_HideDetails = function()
--         --     MacroEditButton:Hide();
--         --     MacroFrameCharLimitText:Hide();
--         --     MacroFrameText:Hide();
--         --     MacroFrameSelectedMacroName:Hide();
--         --     MacroFrameSelectedMacroBackground:Hide();
--         --     MacroFrameSelectedMacroButton:Hide();
--         -- end

--         -- MacroFrame_ShowDetails = function()
--         --     MacroEditButton:Show();
--         --     MacroFrameCharLimitText:Show();
--         --     MacroFrameEnterMacroText:Show();
--         --     MacroFrameText:Show();
--         --     MacroFrameSelectedMacroName:Show();
--         --     MacroFrameSelectedMacroBackground:Show();
--         --     MacroFrameSelectedMacroButton:Show();
--         -- end

--         -- MacroButtonContainer_OnLoad = function(self)
--         --     local button;
--         --     local maxMacroButtons = max(MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS);
--         --     for i=1, maxMacroButtons do
--         --         button = CreateFrame("CheckButton", "MacroButton"..i, self, "MacroButtonTemplate");
--         --         button:SetID(i);
--         --         if ( i == 1 ) then
--         --             button:SetPoint("TOPLEFT", self, "TOPLEFT", 6, -6);
--         --         elseif ( mod(i, NUM_MACROS_PER_ROW) == 1 ) then
--         --             button:SetPoint("TOP", "MacroButton"..(i-NUM_MACROS_PER_ROW), "BOTTOM", 0, -10);
--         --         else
--         --             button:SetPoint("LEFT", "MacroButton"..(i-1), "RIGHT", 13, 0);
--         --         end
--         --     end
--         -- end

--         -- local MACRO_POPUP_FRAME_MINIMUM_PADDING = 40;
--         -- MacroPopupFrame_AdjustAnchors = function(self)
--         --     local rightSpace = GetScreenWidth() - MacroFrame:GetRight();
--         --     self.parentLeft = MacroFrame:GetLeft();
--         --     local leftSpace = self.parentLeft;

--         --     self:ClearAllPoints();
--         --     if ( leftSpace >= rightSpace ) then
--         --         if ( leftSpace < self:GetWidth() + MACRO_POPUP_FRAME_MINIMUM_PADDING ) then
--         --             self:SetPoint("TOPRIGHT", MacroFrame, "TOPLEFT", self:GetWidth() + MACRO_POPUP_FRAME_MINIMUM_PADDING - leftSpace, 0);
--         --         else
--         --             self:SetPoint("TOPRIGHT", MacroFrame, "TOPLEFT", -5, 0);
--         --         end
--         --     else
--         --         if ( rightSpace < self:GetWidth() + MACRO_POPUP_FRAME_MINIMUM_PADDING ) then
--         --             self:SetPoint("TOPLEFT", MacroFrame, "TOPRIGHT", rightSpace - (self:GetWidth() + MACRO_POPUP_FRAME_MINIMUM_PADDING), 0);
--         --         else
--         --             self:SetPoint("TOPLEFT", MacroFrame, "TOPRIGHT", 0, 0);
--         --         end
--         --     end
--         -- end

--         -- MacroPopupFrame_OnLoad = function(self)
--         --     MacroPopupScrollFrame.ScrollBar.scrollStep = 8 * MACRO_ICON_ROW_HEIGHT;
--         -- end

--         -- MacroPopupFrame_OnShow = function(self)
--         --     MacroPopupFrame_AdjustAnchors(self);
--         --     MacroPopupEditBox:SetFocus();

--         --     PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
--         --     RefreshPlayerSpellIconInfo();
--         --     MacroPopupFrame_Update(self);
--         --     MacroPopupOkayButton_Update();

--         --     if ( self.mode == "new" ) then
--         --         MacroFrameText:Hide();
--         --         MacroPopupButton_SelectTexture(1);
--         --     end

--         --     -- Disable Buttons
--         --     MacroEditButton:Disable();
--         --     MacroDeleteButton:Disable();
--         --     MacroNewButton:Disable();
--         --     MacroFrameTab1:Disable();
--         --     MacroFrameTab2:Disable();

--         -- end

--         -- MacroPopupFrame_OnUpdate = function(self)
--         --     if (self.parentLeft ~= MacroFrame:GetLeft()) then
--         --         MacroPopupFrame_AdjustAnchors(self);
--         --     end
--         -- end

--         -- MacroPopupFrame_OnHide = function(self)
--         --     if ( self.mode == "new" ) then
--         --         MacroFrameText:Show();
--         --         MacroFrameText:SetFocus();
--         --     end

--         --     -- Enable Buttons
--         --     MacroEditButton:Enable();
--         --     MacroDeleteButton:Enable();
--         --     local numMacros;
--         --     local numAccountMacros, numCharacterMacros = GetNumMacros();
--         --     if ( MacroFrame.macroBase == 0 ) then
--         --         numMacros = numAccountMacros;
--         --     else
--         --         numMacros = numCharacterMacros;
--         --     end
--         --     if ( numMacros < MacroFrame.macroMax ) then
--         --         MacroNewButton:Enable();
--         --     end
--         --     -- Enable tabs
--         --     PanelTemplates_UpdateTabs(MacroFrame);
--         -- end

--         -- --[[
--         -- RefreshPlayerSpellIconInfo() builds the table MACRO_ICON_FILENAMES with known spells followed by all icons (could be repeats)
--         -- ]]
--         -- RefreshPlayerSpellIconInfo = function()
--         --     if ( MACRO_ICON_FILENAMES ) then
--         --         return;
--         --     end

--         --     -- We need to avoid adding duplicate spellIDs from the spellbook tabs for your other specs.
--         --     local activeIcons = {};

--         --     for i = 1, GetNumSpellTabs() do
--         --         local tab, tabTex, offset, numSpells, _ = GetSpellTabInfo(i);
--         --         offset = offset + 1;
--         --         local tabEnd = offset + numSpells;
--         --         for j = offset, tabEnd - 1 do
--         --             --to get spell info by slot, you have to pass in a pet argument
--         --             local spellType, ID = GetSpellBookItemInfo(j, "player");
--         --             if (spellType ~= "FUTURESPELL") then
--         --                 local fileID = GetSpellBookItemTexture(j, "player");
--         --                 if (fileID) then
--         --                     activeIcons[fileID] = true;
--         --                 end
--         --             end
--         --             if (spellType == "FLYOUT") then
--         --                 local _, _, numSlots, isKnown = GetFlyoutInfo(ID);
--         --                 if (isKnown and numSlots > 0) then
--         --                     for k = 1, numSlots do
--         --                         local spellID, overrideSpellID, isKnown = GetFlyoutSlotInfo(ID, k)
--         --                         if (isKnown) then
--         --                             local fileID = GetSpellTexture(spellID);
--         --                             if (fileID) then
--         --                                 activeIcons[fileID] = true;
--         --                             end
--         --                         end
--         --                     end
--         --                 end
--         --             end
--         --         end
--         --     end

--         --     MACRO_ICON_FILENAMES = { "INV_MISC_QUESTIONMARK" };
--         --     for fileDataID in pairs(activeIcons) do
--         --         MACRO_ICON_FILENAMES[#MACRO_ICON_FILENAMES + 1] = fileDataID;
--         --     end

--         --     GetLooseMacroIcons( MACRO_ICON_FILENAMES );
--         --     GetLooseMacroItemIcons( MACRO_ICON_FILENAMES );
--         --     GetMacroIcons( MACRO_ICON_FILENAMES );
--         --     GetMacroItemIcons( MACRO_ICON_FILENAMES );
--         -- end

--         -- GetSpellorMacroIconInfo = function(index)
--         --     if ( not index ) then
--         --         return;
--         --     end
--         --     local texture = MACRO_ICON_FILENAMES[index];
--         --     local texnum = tonumber(texture);
--         --     if (texnum ~= nil) then
--         --         return texnum;
--         --     else
--         --         return texture;
--         --     end
--         -- end

--         -- MacroPopupFrame_Update = function(self)
--         --     self = self or MacroPopupFrame;
--         --     local numMacroIcons = #MACRO_ICON_FILENAMES;
--         --     local macroPopupIcon, macroPopupButton;
--         --     local macroPopupOffset = FauxScrollFrame_GetOffset(MacroPopupScrollFrame);
--         --     local index;

--         --     -- Determine whether we're creating a new macro or editing an existing one
--         --     if ( self.mode == "new" ) then
--         --         MacroPopupEditBox:SetText("");
--         --     elseif ( self.mode == "edit" ) then
--         --         local name, _, body = GetMacroInfo(MacroFrame.selectedMacro);
--         --         MacroPopupEditBox:SetText(name);
--         --     end

--         --     -- Icon list
--         --     local texture;
--         --     for i=1, NUM_MACRO_ICONS_SHOWN do
--         --         macroPopupIcon = _G["MacroPopupButton"..i.."Icon"];
--         --         macroPopupButton = _G["MacroPopupButton"..i];
--         --         index = (macroPopupOffset * NUM_ICONS_PER_ROW) + i;
--         --         texture = GetSpellorMacroIconInfo(index);

--         --         if ( index <= numMacroIcons and texture ) then
--         --             if(type(texture) == "number") then
--         --                 macroPopupIcon:SetTexture(texture);
--         --             else
--         --                 macroPopupIcon:SetTexture("INTERFACE\\ICONS\\"..texture);
--         --             end
--         --             macroPopupButton:Show();
--         --         else
--         --             macroPopupIcon:SetTexture("");
--         --             macroPopupButton:Hide();
--         --         end
--         --         if ( MacroPopupFrame.selectedIcon and (index == MacroPopupFrame.selectedIcon) ) then
--         --             macroPopupButton:SetChecked(true);
--         --         elseif ( MacroPopupFrame.selectedIconTexture == texture ) then
--         --             macroPopupButton:SetChecked(true);
--         --         else
--         --             macroPopupButton:SetChecked(false);
--         --         end
--         --     end

--         --     -- Scrollbar stuff
--         --     FauxScrollFrame_Update(MacroPopupScrollFrame, ceil(numMacroIcons / NUM_ICONS_PER_ROW) + 1, NUM_ICON_ROWS, MACRO_ICON_ROW_HEIGHT );
--         -- end

--         -- MacroPopupFrame_CancelEdit = function()
--         --     MacroPopupFrame:Hide();
--         --     MacroFrame_Update();
--         --     MacroPopupFrame.selectedIcon = nil;
--         -- end

--         -- MacroPopupOkayButton_Update = function()
--         --     local text = MacroPopupEditBox:GetText();
--         --     text = string.gsub(text, "\"", "");
--         --     if ( (strlen(text) > 0) and MacroPopupFrame.selectedIcon ) then
--         --         MacroPopupFrame.BorderBox.OkayButton:Enable();
--         --     else
--         --         MacroPopupFrame.BorderBox.OkayButton:Disable();
--         --     end
--         --     if ( MacroPopupFrame.mode == "edit" and (strlen(text) > 0) ) then
--         --         MacroPopupFrame.BorderBox.OkayButton:Enable();
--         --     end
--         -- end

--         -- MacroPopupButton_SelectTexture = function(selectedIcon)
--         --     MacroPopupFrame.selectedIcon = selectedIcon;
--         --     -- Clear out selected texture
--         --     MacroPopupFrame.selectedIconTexture = nil;
--         --     local curMacroInfo = GetSpellorMacroIconInfo(MacroPopupFrame.selectedIcon);
--         --     if(type(curMacroInfo) == "number") then
--         --         MacroFrameSelectedMacroButtonIcon:SetTexture(curMacroInfo);
--         --     else
--         --         MacroFrameSelectedMacroButtonIcon:SetTexture("INTERFACE\\ICONS\\"..curMacroInfo);
--         --     end
--         --     MacroPopupOkayButton_Update();
--         --     local mode = MacroPopupFrame.mode;
--         --     MacroPopupFrame.mode = nil;
--         --     MacroPopupFrame_Update(MacroPopupFrame);
--         --     MacroPopupFrame.mode = mode;
--         -- end

--         -- MacroPopupButton_OnClick = function(self, button)
--         --     MacroPopupButton_SelectTexture(self:GetID() + (FauxScrollFrame_GetOffset(MacroPopupScrollFrame) * NUM_ICONS_PER_ROW));
--         -- end

--         -- MacroPopupOkayButton_OnClick = function(self, button)
--         --     local index = 1
--         --     local iconTexture = GetSpellorMacroIconInfo(MacroPopupFrame.selectedIcon);
--         --     local text = MacroPopupEditBox:GetText();
--         --     text = string.gsub(text, "\"", "");
--         --     if ( MacroPopupFrame.mode == "new" ) then
--         --         index = CreateMacro(text, iconTexture, nil, (MacroFrame.macroBase > 0));
--         --     elseif ( MacroPopupFrame.mode == "edit" ) then
--         --         index = EditMacro(MacroFrame.selectedMacro, text, iconTexture);
--         --     end
--         --     MacroPopupFrame:Hide();
--         --     MacroFrame_SelectMacro(index);
--         --     MacroFrame_Update();
--         -- end

--         -- MacroFrame_SaveMacro = function()
--         --     if ( MacroFrame.textChanged and MacroFrame.selectedMacro ) then
--         --         EditMacro(MacroFrame.selectedMacro, nil, nil, MacroFrameText:GetText());
--         --         MacroFrame.textChanged = nil;
--         --     end
--         -- end

--         local mbSaveMacro = function()
-- 			local t = {}
--             local selected = MacroFrame.selectedMacro

-- 			for i,block in ipairs(mb.Stack.blocks) do
-- 				block.saved = true
-- 				t[i] = mb.GetFlags(block)
-- 			end

-- 			if MacroFrame.selectedMacro > 120 then
-- 				mb.UserMacros[selected][mb.Char]["body"] = MacroFrameText:GetText()
-- 				mb.UserBlocks[selected][mb.Char] = t
-- 			else
-- 				mb.UserMacros[selected]["body"] = MacroFrameText:GetText()
-- 				mb.UserBlocks[selected] = t
-- 			end
-- 		end

--         hooksecurefunc("MacroFrame_SaveMacro", mbSaveMacro)

--         -- XML frame scripts

--         for i=1, 120 do
-- 			_G["MacroButton"..i]:SetScript("OnClick", MBMacroButton_OnClick)
-- 		end

--         -- MacroFrameTab1:SetScript("OnClick",	MBMacroFrameTab_OnClick)
-- 		-- MacroFrameTab2:SetScript("OnClick",	MBMacroFrameTab_OnClick)

--         -- for i=1, 90 do
-- 		-- 	_G["MacroPopupButton"..i.."Icon"]:SetScript("OnEnter", MacroPopupButton_OnEnter)
-- 		-- end

--         MacroFrameText:SetScript("OnTextChanged", function(_self, userInput)

-- 			if _self.saved and (userInput or _self.blockInput)then
-- 				MACRO_FRAME_BUTTONS_SETENABLED(true)
-- 				_self.saved = false
-- 			end

-- 			local cCount = MacroFrameText:GetNumLetters()

-- 			if ( MacroPopupFrame.mode == "new" ) then MacroPopupFrame:Hide(); end

-- 			MacroFrameCharLimitText:SetText("["..cCount.."/255]")

-- 			if cCount >= 170 and cCount < 210 then
-- 				MacroFrameCharLimitText:SetTextColor(1, 1, 0, 0.4)
-- 			elseif cCount >= 210 then
-- 				MacroFrameCharLimitText:SetTextColor(1, 0, 0, 0.5)
-- 			else
-- 				MacroFrameCharLimitText:SetTextColor(1, 1, 1, 0.3)
-- 			end

-- 			MacroFrame.textChanged = 1
-- 			MacroFrameText.payloadUpdate = false
-- 			ScrollingEdit_OnTextChanged(_self, _self:GetParent())
-- 		end)

--         btn.name:SetScript("OnEnterPressed", function(self)
--             self:ClearFocus()
--             local index = 1
--             local iconTexture = btn.selected.Icon:GetTexture()
--             local text = self:GetText()
--             text = string.gsub(text, "\"", "")
--             index = EditMacro(MacroFrame.selectedMacro, text, iconTexture)
--             MacroFrame_SelectMacro(index)
--             MacroFrame_Update()
--         end)

--         btn.name:SetScript("OnEscapePressed", function(self)
--             self:ClearFocus()
--             MacroFrame_Update()
--             MacroPopupFrame.selectedIcon = nil
--         end)

--         MacroSaveButton:SetScript("OnClick", function(self, button, down)
--             PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
--             MacroFrame_SaveMacro()
--             MACRO_FRAME_UPDATE()
--             MacroPopupFrame:Hide()
--             MacroFrameText:ClearFocus()

--             -- local t = {}

--             -- for i, block in pairs(mb.Stack.blocks) do
--             -- 	block.saved = true
--             -- 	t[i] = { block.group, block.ID, block.param }
--             -- end

--             -- if MacroFrame.selectedMacro > 120 then
--             -- 	mb.UserMacros[MacroFrame.selectedMacro][mb.Char]["body"] = MacroFrameText:GetText()
--             -- 	mb.UserBlocks[MacroFrame.selectedMacro][mb.Char] = t
--             -- else
--             -- 	mb.UserMacros[MacroFrame.selectedMacro]["body"] = MacroFrameText:GetText()
--             -- 	mb.UserBlocks[MacroFrame.selectedMacro] = t
--             -- end

--             MacroFrameText.blockInput = false
--             MacroFrameText.saved = true
--             MACRO_FRAME_BUTTONS_SETENABLED(false)
--         end)

-- 		MacroCancelButton:SetScript("OnClick", function(self, button, down)
--             PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
--             MACRO_FRAME_UPDATE()
--             MacroPopupFrame:Hide()
--             MacroFrameText:ClearFocus()

--             -- mb.Stack.preserve = true

--             local clearTable = {}
--             for _, block in pairs(mb.Stack.blocks) do table.insert(clearTable, block) end
--             for _, block in pairs(clearTable) do
--                 if preserve then
--                     if not block.saved then
--                           mb.Stack:remBlock(block)
--                         MB_OnDragStop(block)
--                     end
--                 else
--                     mb.Stack:remBlock(block)
--                     MB_OnDragStop(block)
--                 end
--             end

--             if MacroFrame.selectedMacro > 120 then
--                 MacroFrameText:SetText(mb.UserMacros[MacroFrame.selectedMacro][mb.Char]["body"])
--             else
--                 MacroFrameText:SetText(mb.UserMacros[MacroFrame.selectedMacro]["body"])
--             end
--             MacroFrame.changes = false

--             -- clearBlocks = nil

--             MacroFrameText.saved = true
--             -- mb.Stack.preserve = false
--             MacroFrameText.blockInput = false
--             MACRO_FRAME_BUTTONS_SETENABLED(false)
--         end)

--     end
-- end)