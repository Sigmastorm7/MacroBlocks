local addon, mb = ...

local MakeBlock = mb.MakeBlock
local classColors = mb.ClassColors

-- Blizzard API
local Item = C_Item
local Mounts = C_MountJournal
local Pets = C_PetJournal

local flyoutWidth = { [true] = 156 }
local flyoutText = { [false] = "❭❭", [true] = "❬❬" }
local choiceTextColor = { [false] = { 0.55, 0.55, 0.55, }, [true] = { 0, 1, 0.4, }, }

MB_CHOICE_BLOCK_RESET = function(self)
    for i=1, #self.data.choices do
        self["choice"..i].enabled = false
        self["choice"..i]:Hide()
        self["choice"..i].text:SetTextColor(unpack(choiceTextColor[false]))
    end
    self.choiceNum = 0
    self.data.payload = self._payload
    self:SetWidth(self.origWidth)
    self.flyout.text:SetText(flyoutText[false])
    self.flyout.open = false
end

UserBlockBackdrop = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 24,
	edgeSize = 12,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
}

-- Generic block handlers
function MB_OnLoad(self)
    self:SetClampedToScreen(true)
    self:RegisterForDrag("LeftButton")
end

function MB_OnDragStart(self, button)

    self:StartMoving()
    self:SetFrameStrata("TOOLTIP")

    if self.stacked then
        if self.group == "Smart" then self.UNHOOK_PAYLOAD() end
        mb.Stack.remBlock(self)
    end

    mb.Frame.dragging = self
    mb.Stack:SetScript("OnUpdate", StackDisplaceCheck)

end

function MB_OnDragStop(self)

    self:StopMovingOrSizing()
	self:SetUserPlaced(false)

    if MouseIsOver(mb.Stack) then
        if not self.stacked then
            MBPaletteBasic.blocks[self.paletteID] = mb.MakeBlock(self.group, self.data, self.paletteID)
        end
        if self.group == "Smart" then
            if self.ORPHAN() and self.PLACEMENT() then
                self.STACK() -- mb.Stack.addBlock(self)
            else
                mb.BlockPoolCollection:Release(MBPaletteBasic.blocks[self.paletteID])
                MBPaletteBasic.blocks[self.paletteID] = self
                self.stacked = false
            end
        else
            mb.Stack.addBlock(self)
        end
    elseif not MouseIsOver(mb.Stack) and self.stacked then
        if self.data.func ~= nil then
            if self.data.func == "USER_SOCKET" then
                self.data.payload = ""
                self.socket.icon:SetColorTexture(0, 0, 0, 0)
            elseif self.data.func == "USER_EDIT" then
                self.data.payload = ""
                self.edit:SetText("")
            elseif self.data.func == "USER_CHOICE" then
                self.reset(self)
            end
        end

        if self.smartHook ~= nil then
            mb.Stack.remBlock(self.smartHook)

            mb.BlockPoolCollection:Release(MBPaletteBasic.blocks[self.smartHook.paletteID])
            MBPaletteBasic.blocks[self.smartHook.paletteID] = self.smartHook
            self.smartHook.stacked = false

            self.hooked = false
            self.smartHook = nil
        end

        self.saved = false

        mb.BlockPoolCollection:Release(MBPaletteBasic.blocks[self.paletteID])
        MBPaletteBasic.blocks[self.paletteID] = self
        self.stacked = false
    end

    mb.Frame.dragging = nil
    mb.Stack:SetScript("OnUpdate", nil)

    -- Make sure to update displace arguments to prevent any frames from getting stuck in their displaced position
    mb.Stack.displace = false
    mb.Stack.displaceID = 0

    if self.stacked then StackAdjust() end
    PaletteAdjust()
end

-- User input element handler
function MB_USER_ELEMENT_OnShow(self)
    -- self.p = self:GetParent()
    self:SetBackdrop(UserBlockBackdrop)
    self:SetBackdropColor(128/255, 62/255, 5/255)
    self:SetBackdropBorderColor(unpack(classColors.User.rgb))
end

-- Smart block generator for specific instances
--[[local sbData = {}
local function SmartBlock()
    local sb = mb.MakeBlock("Command", sbData, -1)

    mb.Stack.displace = true
    mb.Stack.displaceID = sb.data.sbIndex

    return sb
    -- mb.Stack.addBlock(sb)

end]]

-- User socket block handlers
function MB_SOCKET_OnClick(self, button, down)
    local itemType, name, spellID, itemID, mountID, iconID

    -- sbData.make = false

    if GetCursorInfo() ~= nil then
        itemType, itemID, mountID, spellID = GetCursorInfo()
        if itemType == "spell" then
            name, _, iconID = GetSpellInfo(spellID)
            self:GetParent().data.payload = name
        elseif itemType == "item" then
            iconID = Item.GetItemIconByID(itemID)

            if ToyBox.GetToyInfo(itemID) then
                itemType = "toy"
            end

            self:GetParent().data.payload = "item:"..itemID
        elseif itemType == "mount" then
            name, _, iconID = Mounts.GetMountInfoByID(itemID)
            self:GetParent().data.payload = name
        elseif itemType == "battlepet" then
            local petInfo = Pets.GetPetInfoTableByPetID(itemID)

            iconID = petInfo.icon
            self:GetParent().data.payload = petInfo.name

        -- elseif itemType == "" then
        -- elseif itemType == "" then
        -- elseif itemType == "" then
        end

        --[[if sbData.make then
            mb.Stack.addBlock(SmartBlock())
        end]]

	    self.icon:SetTexture(iconID)
        ClearCursor()
        UpdateMacroBlockText()
    end
end

-- User edit block handlers
function MB_EDIT_OnTextChanged(self, userInput)
    self.instructions:SetShown(self:GetText() == "")
    self:GetParent().data.payload = self:GetText()

    if userInput then UpdateMacroBlockText() end
end

-- Choice block handlers
function MB_CHOICE_BLOCK_OnLoad(self) MB_OnLoad(self); self.choiceNum = 0; end

function MB_CHOICE_BLOCK_OnShow(self)
    self:SetBackdropColor(0, 128/255, 77/255)
    self.text:Hide()
end

function MB_CHOICE_FlyoutOnClick(self, button, down)
    local p = self:GetParent()

    if not p.stacked then return end

    if button == nil then
        self.open = true
    else
        self.open = not self.open
    end

    for i=1, #p.data.choices do p["choice"..i]:SetShown(self.open) end

    self.text:SetText(flyoutText[self.open])

    p:SetWidth(flyoutWidth[self.open] or p.origWidth)
end

function MB_CHOICE_BUTTON_OnLoad(self)
    self:RegisterForClicks("LeftButtonUp")
    self:SetWidth(self.text:GetStringWidth())
    self.enabled = false
    self.text:SetTextColor(unpack(choiceTextColor[self.enabled]))
end

local modCase = {
    "[mod:shift]",
    "[mod:ctrl]",
    "[mod:shiftctrl]",
    "[mod:alt]",
    "[mod:shiftalt]",
    "[mod:ctrlalt]",
    "[mod:shiftctrlalt]",
}

function MB_CHOICE_BUTTON_OnClick(self, button, down)
    local p = self:GetParent()
    if not self.enabled then
        self.enabled = true
        p.choiceNum = p.choiceNum + self.value
    elseif self.enabled then
        self.enabled = false
        p.choiceNum = p.choiceNum - self.value
    end

    p.data.payload = modCase[p.choiceNum] or "[mod]"
    UpdateMacroBlockText()
    self.text:SetTextColor(unpack(choiceTextColor[self.enabled]))
end