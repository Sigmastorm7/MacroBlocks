local addon, mb = ...

local MakeBlock = mb.MakeBlock
local groupColors = mb.GroupColors

-- Blizzard API
local Item = C_Item
local Mounts = C_MountJournal
local Pets = C_PetJournal
local ToyBox = C_ToyBox

local flyoutWidth = { [true] = 156 }
local flyoutText = { [false] = "❭❭", [true] = "❬❬" }
local choiceTextColor = { [false] = { 0.55, 0.55, 0.55 }, [true] = { 0, 1, 0.4 }, }
local talentIDColor = { [true] = {1, 1, 1}, [false] = {1, 0.8, 0.3} }
local talentIconAlpha = { [true] = 1, [false] = 0.8 }

MB_CHOICE_BLOCK_RESET = function(self)

    if self.data.label == "MOD" then
        for i=1, self.num do
            self["choice"..i].enabled = false
            self["choice"..i]:Hide()
            self["choice"..i].text:SetTextColor(unpack(choiceTextColor[false]))
        end
        self.choiceValueSum = 0
        self.data.payload = self._payload
    elseif self.data.label == "SPEC" then
        for i=1, self.num do
            self["choice"..i].enabled = false
            self["choice"..i]:Hide()
            self["choice"..i].text:SetTextColor(unpack(choiceTextColor[false]))
        end
        self.choice1.enabled = true
        self.choice1.text:SetTextColor(0, 1, 0.4)
    elseif self.data.label == "TALENT" then
        self.bgFrame:Hide()
        local _btn
        for i=1, 7 do
            for j=1, 3 do
                _btn = self["row"..i]["btn"..j]
                _btn.enabled = false
                _btn:Hide()
                _btn:UnlockHighlight()
                _btn.icon:SetAlpha(talentIconAlpha[false])
                _btn.icon:SetDesaturated(true)
                _btn.talentID:SetTextColor(unpack(talentIDColor[false]))
            end
        end
    end

    self:SetWidth(self.closeW)
    self.flyout.text:SetText(flyoutText[false])
    self.flyout.open = false
end

-- Generic block handlers
function MB_OnLoad(self)
    self:SetClampedToScreen(true)
    self:RegisterForDrag("LeftButton")
    self:RegisterEvent("MODIFIER_STATE_CHANGED")
    self.ttEnabled = false
end

function MB_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -8, 8)
	GameTooltip:AddLine(self.tooltip[1])
    GameTooltip:AddLine(self.tooltip[2])
    GameTooltip:AddLine(self.tooltip[3])
    GameTooltip:AddLine(self.tooltip[4])
    GameTooltip:Show()
end

function MB_OnLeave(self)
    if GameTooltip:IsOwned(self) then
        GameTooltip:Hide()
    end
end

function MB_Tooltip(self, event, key, state)
    if event =="MODIFIER_STATE_CHANGED" then
        if strsub(key, 2) == "SHIFT" and state == 1 and not GameTooltip:IsOwned(self) then
            MB_OnEnter(self)
        else
            MB_OnLeave(self)
        end
    end
end

function MB_OnDragStart(self, button)

    self:StartMoving()
    self:SetFrameStrata("TOOLTIP")

    if self.InStack then
        mb.Stack:remBlock(self)
    end

    mb.Frame.dragging = self
    mb.Stack:SetScript("OnUpdate", StackDisplaceCheck)
end

function MB_OnDragStop(self)

    self:StopMovingOrSizing()
	self:SetUserPlaced(false)

    if mb.Stack:IsMouseOver() then
        if not self.InStack then
            mb.Palette.blocks[self.PaletteID] = mb.MakeBlock(strsub(self.GroupID, 1, 3), self.data, self.PaletteID)
        end
        if strsub(self.GroupID, 1, 3) ~= "LOG" then
            mb.Stack:addBlock(self)
        elseif strsub(self.GroupID, 1, 3) == "LOG" then
            if self:CheckNeighbors() then
                mb.Stack:addBlock(self)
            else
                mb.BlockPoolCollection:Release(mb.Palette.blocks[self.PaletteID])
                mb.Palette.blocks[self.PaletteID] = self
                self.InStack = false
                mb.Stack.displace = false
                mb.Stack:Adjust()
            end
        end
    elseif not mb.Stack:IsMouseOver() and self.InStack then
        if self.data.func ~= nil then
            if self.data.func == "USR_SOCKET" then
                self.data.payload = ""
                self.socket.icon:SetColorTexture(0, 0, 0, 0)
            elseif self.data.func == "USR_EDIT" then
                self.data.payload = ""
                self.edit:SetText("")
            elseif self.data.func == "USR_CHOICE" then
                self.reset(self)
            end
        end

        self.saved = false
        self.InStack = false

        mb.BlockPoolCollection:Release(mb.Palette.blocks[self.PaletteID])
        mb.Palette.blocks[self.PaletteID] = self
        
    elseif mb.Stack:IsMouseOver() and mb.Stack.displace then
        mb.Stack.displace = false
    end

    mb.Frame.dragging = nil
    mb.Stack:SetScript("OnUpdate", nil)

    -- Make sure to update displace arguments to prevent any frames from getting stuck in their displaced position
    mb.Stack.displace = false
    mb.Stack.displaceID = 0

    if self.InStack then mb.Stack:Adjust() end
    mb.Palette:Adjust()
end

-- USR input element handler
function MB_USR_ELEMENT_OnShow(self)
    -- self.p = self:GetParent()
    self:SetBackdrop(mb.USRBackdrop)
    self:SetBackdropColor(128/255, 62/255, 5/255)
    self:SetBackdropBorderColor(unpack(groupColors.USR.rgb))
end

-- USR socket block handlers
function MB_SOCKET_OnClick(self, button, down)
    local itemType, name, spellID, itemID, mountID, iconID

    -- sbData.make = false

    if GetCursorInfo() ~= nil then
        itemType, itemID, mountID, spellID = GetCursorInfo()
        if itemType == "spell" then
            name, _, iconID = GetSpellInfo(spellID)

            mb.Stack.payloadTable[self:GetParent().StackID] = name

        elseif itemType == "item" then
            iconID = Item.GetItemIconByID(itemID)

            if ToyBox.GetToyInfo(itemID) then
                itemType = "toy"
            end

            mb.Stack.payloadTable[self:GetParent().StackID] = "item:"..itemID

        elseif itemType == "mount" then
            name, _, iconID = Mounts.GetMountInfoByID(itemID)

            mb.Stack.payloadTable[self:GetParent().StackID] = name

        elseif itemType == "battlepet" then
            local petInfo = Pets.GetPetInfoTableByPetID(itemID)

            iconID = petInfo.icon
            mb.Stack.payloadTable[self:GetParent().StackID] = petInfo.name

        end

	    self.icon:SetTexture(iconID)
        ClearCursor()
        UpdateMacroBlockText()
    end
end

-- USR edit block handlers
function MB_EDIT_OnEditFocusGained(self)
    if not self:GetParent().InStack then
        self:ClearFocus()
        return
    else
        self:HighlightText();
    end
end
function MB_EDIT_OnTextChanged(self, userInput)
    self.instructions:SetShown(self:GetText() == "")
    if userInput then
        mb.Stack.payloadTable[self:GetParent().StackID] = self:GetText()
        UpdateMacroBlockText()
    end
end

-- Choice block handlers
function MB_CHOICE_BLOCK_OnLoad(self)
    MB_OnLoad(self)
    self.choiceValueSum = 0

    self.backdropFrame:SetBackdrop(mb.USRBackdrop);
    self.backdropFrame:SetBackdropColor(0, 0.9999977946281433, 0.5960771441459656);
    self.backdropFrame:SetBackdropBorderColor(0, 0.9999977946281433, 0.5960771441459656);
end

function MB_CHOICE_BLOCK_OnShow(self)
    self:SetBackdropColor(0, 128/255, 77/255)
    self.payload = self._payload
    self.text:Hide()

    if self.label == "TALENT" then
        self.bgFrame:SetBackdrop(mb.USRBackdrop);
        self.bgFrame:SetBackdropColor(0, 0, 0, 0.8) -- 0, 128/255, 77/255);
        self.bgFrame:SetBackdropBorderColor(0, 0.9999977946281433, 0.5960771441459656);
    end
end

function MB_CHOICE_FlyoutOnClick(self, button, down)
    local p = self:GetParent()

    if not p.InStack then return end

    if button == nil then
        self.open = true
    else
        self.open = not self.open
    end

    if p.data.label ~= "TALENT" then
        for i=1, p.num do p["choice"..i]:SetShown(self.open) end
        if self.open then
            p:SetWidth(p.closeW + p.openW)
        else
            p:SetWidth(p.closeW)
        end
    else
        local row
        for i=1, 7 do
            row = p["row"..i]
            row:SetShown(self.open)
            for j=1, 3 do
                row["btn"..j]:SetShown(self.open)
            end
        end
        p.bgFrame:SetShown(self.open)
        if self.open then
            p:SetWidth(p.closeW + p.openW)
        else
            p:SetWidth(p.closeW)
        end
    end

    self.text:SetText(flyoutText[self.open])

    mb.Stack:Adjust()
end

function MB_CHOICE_BUTTON_OnLoad(self)
    self:RegisterForClicks("LeftButtonUp")
    self.enabled = false
    if self.text then
        self:SetWidth(self.text:GetStringWidth())
        self.text:SetTextColor(unpack(choiceTextColor[self.enabled]))
    else

    end
end

function MB_CHOICE_BUTTON_OnClick(self, button, down)
    local p = self:GetParent()

    if not p.data then p = p:GetParent() end

    if p.data.label == "MOD" then
        if not self.enabled then
            self.enabled = true
            p.choiceValueSum = p.choiceValueSum + self.value
        elseif self.enabled then
            self.enabled = false
            p.choiceValueSum = p.choiceValueSum - self.value
        end
        mb.Stack.payloadTable[p.StackID] = mb.ModCombos[p.choiceValueSum] or "[mod]"
        self.text:SetTextColor(unpack(choiceTextColor[self.enabled]))
    elseif p.data.label == "SPEC" then
        for i=1, p.num do
            p["choice"..i].enabled = p["choice"..i].value == self.value
            p["choice"..i].text:SetTextColor(unpack(choiceTextColor[p["choice"..i].value == self.value]))
        end
        mb.Stack.payloadTable[p.StackID] = "[spec:"..self.value.."]" or p.payload
    elseif p.data.label == "TALENT" then
        local tBtn
        for i=1, 7 do
            for j=1, 3 do
                tBtn = p["row"..i]["btn"..j]
                tBtn.enabled = tBtn == self
                tBtn.icon:SetAlpha(talentIconAlpha[tBtn.enabled])
                tBtn.icon:SetDesaturated(not tBtn.enabled)
                tBtn.talentID:SetTextColor(unpack(talentIDColor[tBtn.enabled]))
                tBtn.selected:SetShown(mb.User.talents[i][j])
                if tBtn.enabled then
                    tBtn:LockHighlight()
                else
                    tBtn:UnlockHighlight()
                end
            end
        end
        mb.Stack.payloadTable[p.StackID] = "[talent:"..self.value.."]" or p.payload
    end
    UpdateMacroBlockText()
end