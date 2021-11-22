local addon, mb = ...

local groupColors = mb.GroupColors

-- Blizzard API
local Item = C_Item
local Mounts = C_MountJournal
local Pets = C_PetJournal
local ToyBox = C_ToyBox

mb.flyoutText = { [false] = "❭❭", [true] = "❬❬" }

mb.ResetBlock = function(block)

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

            block.value = 0
            block.config.value = block.value
            block.payload = "[mod]"

        elseif label == "SPEC" then

            for i=1, #block.config.buttons do

                btn = block["choice"..i]

                btn:Hide()

                btn.enabled = i == block.config.value
                btn.text:SetTextColor(unpack(block.config.textColor[i == block.config.value]))

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
            block.value = "0/0"
        end

        block:SetWidth(block.closeWidth)
        block.flyout.text:SetText(mb.flyoutText[false])
        block.flyout.open = false

    elseif block.group == "USR" then

        block.payload = "{empty}"

        if label == "SOCKET" then

            block.socket.icon:SetColorTexture(0, 0, 0, 0)

        elseif label == "EDIT" then

            block.edit:SetText("")
            block.value = "{empty}"
            block.edit:ClearFocus()

        end
    end

end

function MB_OnLoad(self)

    self:SetClampedToScreen(true)
    self:RegisterForDrag("LeftButton")
    self:RegisterEvent("MODIFIER_STATE_CHANGED")

    self.ttEnabled = false
end

function MB_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -8, 8)
	GameTooltip:AddLine(mb.BasicTooltips[self.paletteIndex][1])
    GameTooltip:AddLine(mb.BasicTooltips[self.paletteIndex][2])
    GameTooltip:AddLine(mb.BasicTooltips[self.paletteIndex][3])
    GameTooltip:AddLine(mb.BasicTooltips[self.paletteIndex][4])
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
            mb.Palette.blocks[self.paletteIndex] = mb.MakeBlock(mb.GetFlags(self))
        end
        if self.group ~= "LOG" or self.param.name == "true" then
            mb.Stack:addBlock(self)
        elseif self.group == "LOG" then
            if mb.LogicPlacement(self) then
                mb.Stack:addBlock(self)
            else
                mb.BlockPools:Release(mb.Palette.blocks[self.paletteIndex])
                mb.Palette.blocks[self.paletteIndex] = self
                self.InStack = false
                mb.Stack.displace = false
                mb.Stack:Adjust()
            end
        end

    elseif mb.Stack:IsMouseOver() and mb.Stack.displace then

        mb.Stack.displace = false

    elseif not mb.Stack:IsMouseOver() and self.InStack then
        mb.EraseBlock(self)
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

    local p = self:GetParent()
    local iconID

    if GetCursorInfo() ~= nil then

        --[[
        if itemType == "spell" then

            mb.GetAbilityInfo("spell")
            name, _, iconID = GetSpellInfo(spellID)

            p.value = name
            abilityID = spellID

        elseif itemType == "item" then
            iconID = Item.GetItemIconByID(itemID)

            if ToyBox.GetToyInfo(itemID) then
                itemType = "toy"
            end

            p.value = "item:"..itemID
            abilityID = itemID

        elseif itemType == "mount" then
            name, _, iconID = Mounts.GetMountInfoByID(itemID)

            p.value = name
            abilityID = itemID

        elseif itemType == "battlepet" then
            local petInfo = Pets.GetPetInfoTableByPetID(itemID)

            iconID = petInfo.icon
            p.value = petInfo.name
            abilityID = itemID

        end
        ]]

        p.value, p.payload, p.itemType, iconID = mb.GetAbilityInfo(GetCursorInfo())

        mb.Stack.payloadTable[p.StackID] = p.payload

        p.config.abilityID = p.value

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
    local p = self:GetParent()

    self.instructions:SetShown(self:GetText() == "")

    if userInput then

        p.value = self:GetText()
        p.payload = p.value

        mb.Stack.payloadTable[p.StackID] = p.payload
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

    self.text:SetText(mb.flyoutText[self.open])

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
            p.value = p.value + self.value

        elseif self.enabled then

            self.enabled = false
            p.value = p.value - self.value

        end

        p.config.buttons[self:GetID()] = self.enabled
        p.config.sum = p.value

        p.payload = p.config.modCombos[p.value]
        mb.Stack.payloadTable[p.StackID] = p.payload
        self.text:SetTextColor(unpack(p.config.textColor[self.enabled]))
    elseif p.param.label == "SPEC" then
        for i=1, #p.config.buttons do
            p["choice"..i].enabled = p["choice"..i].value == self.value
            p["choice"..i].text:SetTextColor(unpack(p.config.textColor[p["choice"..i].value == self.value]))
        end
        p.value = self.value
        p.payload = "[spec:"..self.value.."]"
        mb.Stack.payloadTable[p.StackID] = p.payload
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
                    p.value = i.."/"..j
                    tBtn:LockHighlight()
                else
                    tBtn:UnlockHighlight()
                end

            end
        end
        p.payload = "[talent:"..self.value.."]"
        mb.Stack.payloadTable[p.StackID] = p.payload
    end
    UpdateMacroBlockText()
end