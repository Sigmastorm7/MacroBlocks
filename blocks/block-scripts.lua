local addon, mb = ...

local MakeBlock = mb.MakeBlock
local groupColors = mb.GroupColors

-- Blizzard API
local Item = C_Item
local Mounts = C_MountJournal
local Pets = C_PetJournal
local ToyBox = C_ToyBox

local flyoutText = { [false] = "❭❭", [true] = "❬❬" }

local function MB_Reset(block)

    local label = block.param.label
    local btn

    if block.group == "CON" then
        if label == "MOD" then

            for i=1, #block.config.buttons do

                btn = block["choice"..i]

                btn.enabled = false
                btn:Hide()
                btn.text:SetTextColor(unpack(block.config.textColor[false]))

            end

            block.sum = 0
            block.config.sum = block.sum
            block.payload = "[mod]"

        elseif label == "SPEC" then

            for i=1, #block.config.buttons do

                btn = block["choice"..i]

                btn:Hide()

                btn.enabled = i == block.config.enabledSpec
                btn.text:SetTextColor(unpack(block.config.textColor[i == block.config.enabledSpec]))

            end

        elseif label == "TALENT" then

            block.bgFrame:Hide()
            for i=1, 7 do

                for j=1, 3 do

                    btn = block["row"..i]["btn"..j]

                    btn.enabled = false

                    btn:Hide()
                    btn:UnlockHighlight()

                    btn.icon:SetAlpha(block.config.iconAlpha[false])
                    btn.icon:SetDesaturated(true)

                    btn.talentID:SetTextColor(unpack(block.config.textColor[false]))

                end

            end
            block.payload = "[talent:0/0]"
        end
    elseif block.group == "USR" then

        self.payload = "{empty}"

        if label == "SOCKET" then

            self.socket.icon:SetColorTexture(0, 0, 0, 0)

        elseif label == "EDIT" then

            self.edit:SetText("")
            self.edit:ClearFocus()

        end
    end

    block:SetWidth(block.closeWidth)
    block.flyout.text:SetText(flyoutText[false])
    block.flyout.open = false

end

function MB_OnLoad(self)

    self:SetClampedToScreen(true)
    self:RegisterForDrag("LeftButton")
    self:RegisterEvent("MODIFIER_STATE_CHANGED")

    self.ttEnabled = false
end

function MB_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -8, 8)
	GameTooltip:AddLine(mb.BasicTooltips[self.ID][1])
    GameTooltip:AddLine(mb.BasicTooltips[self.ID][2])
    GameTooltip:AddLine(mb.BasicTooltips[self.ID][3])
    GameTooltip:AddLine(mb.BasicTooltips[self.ID][4])
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
            mb.Palette.blocks[self.ID] = mb.BlockGen(self.group, self.ID, self.param)
        end
        if self.group ~= "LOG" then
            mb.Stack:addBlock(self)
        elseif self.group == "LOG" then
            if self:checkString() then
                mb.Stack:addBlock(self)
            else
                mb.BlockPools:Release(mb.Palette.blocks[self.ID])
                mb.Palette.blocks[self.ID] = self
                self.InStack = false
                mb.Stack.displace = false
                mb.Stack:Adjust()
            end
        end

    elseif mb.Stack:IsMouseOver() and mb.Stack.displace then

        mb.Stack.displace = false

    elseif not mb.Stack:IsMouseOver() and self.InStack then

        if self.param.label then
            if self.param.label == "SOCKET" then
            elseif self.param.label == "USR_EDIT" then
                self.payload = ""
                self.edit:SetText("")
            -- elseif self.param.label == "USR_CHOICE" then
            --     MB_CHOICE_BLOCK_RESET(self)
            end
        end

        if self.config and self.group == "CON" then
            MB_CHOICE_BLOCK_RESET(self)
        end

        self.saved = false
        self.InStack = false

        mb.BlockPools:Release(mb.Palette.blocks[self.ID])
        mb.Palette.blocks[self.ID] = self

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
    self.sum = 0

    self.backdropFrame:SetBackdrop(mb.USRBackdrop);
    self.backdropFrame:SetBackdropColor(0, 0.9999977946281433, 0.5960771441459656);
    self.backdropFrame:SetBackdropBorderColor(0, 0.9999977946281433, 0.5960771441459656);
end

function MB_CHOICE_BLOCK_OnShow(self)
    self:SetBackdropColor(0, 128/255, 77/255)
    self.text:Hide()

    if self.param then
        if self.param.label == "TALENT" then
            self.bgFrame:SetBackdrop(mb.USRBackdrop);
            self.bgFrame:SetBackdropColor(0, 0, 0, 0.8) -- 0, 128/255, 77/255);
            self.bgFrame:SetBackdropBorderColor(0, 0.9999977946281433, 0.5960771441459656);
        end
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

    if p.param.label ~= "TALENT" then
        for i=1, #p.config.buttons do p["choice"..i]:SetShown(self.open) end
        if self.open then
            p:SetWidth(p.closeWidth + p.openWidth)
        else
            p:SetWidth(p.closeWidth)
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
            p:SetWidth(p.closeWidth + p.openWidth)
        else
            p:SetWidth(p.closeWidth)
        end
    end

    self.text:SetText(flyoutText[self.open])

    mb.Stack:Adjust()
end

function MB_CHOICE_BUTTON_OnLoad(self)
    local p = self:GetParent()
    if p.config then
        self:RegisterForClicks("LeftButtonUp")
        self.enabled = false
        if self.text then
            self:SetWidth(self.text:GetStringWidth())
            self.text:SetTextColor(unpack(p.config.textColor[self.enabled]))
        end
    end
end

function MB_CHOICE_BUTTON_OnClick(self, button, down)
    local p = self:GetParent()

    if not p.param then p = p:GetParent() end

    if p.param.label == "MOD" then

        if not self.enabled then

            self.enabled = true
            p.sum = p.sum + self.value

        elseif self.enabled then

            self.enabled = false
            p.sum = p.sum - self.value

        end

        p.config.buttons[self:GetID()] = self.enabled
        p.config.sum = p.sum

        mb.Stack.payloadTable[p.StackID] = p.config.modCombos[p.sum]
        self.text:SetTextColor(unpack(p.config.textColor[self.enabled]))
    elseif p.param.label == "SPEC" then
        for i=1, #p.config.buttons do
            p["choice"..i].enabled = p["choice"..i].value == self.value
            p["choice"..i].text:SetTextColor(unpack(p.config.textColor[p["choice"..i].value == self.value]))
        end
        mb.Stack.payloadTable[p.StackID] = "[spec:"..self.value.."]" or p.payload
    elseif p.param.label == "TALENT" then
        local tBtn
        for i=1, 7 do
            for j=1, 3 do

                tBtn = p["row"..i]["btn"..j]

                tBtn.enabled = tBtn == self
                p.config.buttons[i][j] = tBtn == self

                tBtn.icon:SetAlpha(p.config.iconAlpha[tBtn.enabled])
                tBtn.icon:SetDesaturated(not tBtn.enabled)

                tBtn.talentID:SetTextColor(unpack(p.config.textColor[tBtn.enabled]))

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