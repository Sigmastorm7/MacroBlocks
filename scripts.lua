local addon, mb = ...

local MakeBlock = mb.MakeBlock
local classColors = mb.ClassColors

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
        MBStack.remBlock(self)
    end

    MBFrame.dragging = self
    MBStack:SetScript("OnUpdate", StackDisplaceCheck)

end

function MB_OnDragStop(self)

    self:StopMovingOrSizing()
	self:SetUserPlaced(false)

    if MouseIsOver(MBStack) then
        if not self.stacked then
            MBPaletteBasic.blocks[self.paletteID] = mb.MakeBlock(self.group, self.data, self.paletteID)
        end
        if self.group == "Smart" then
            if self.ORPHAN() and self.PLACEMENT() then
                self.STACK() -- MBStack.addBlock(self)
            else
                mb.BlockPoolCollection:Release(MBPaletteBasic.blocks[self.paletteID])
                MBPaletteBasic.blocks[self.paletteID] = self
                self.stacked = false
            end
        else
            MBStack.addBlock(self)
        end
    elseif not MouseIsOver(MBStack) and self.stacked then
        if self.data.func ~= nil then
            if self.data.func == "USER_SOCKET" then
                self.data.payload = ""
                self.socket.icon:SetColorTexture(0, 0, 0, 0)
            elseif self.data.func == "USER_EDIT" then
                self.data.payload = ""
                self.edit:SetText("")
            elseif self.data.func == "MOD_CONDITION" then
                self.config.closeFunc(self, self.config)
            end
        end

        if self.smartHook ~= nil then
            MBStack.remBlock(self.smartHook)

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

    MBFrame.dragging = nil
    MBStack:SetScript("OnUpdate", nil)

    -- Make sure to update displace arguments to prevent any frames from getting stuck in their displaced position
    MBStack.displace = false
    MBStack.displaceID = 0

    StackAdjust()
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

    MBStack.displace = true
    MBStack.displaceID = sb.data.sbIndex

    return sb
    -- MBStack.addBlock(sb)

end]]

-- User socket block handlers
function MB_SOCKET_OnClick(self, button, down)
    local group, name, spellID, itemID, mountID, iconID

    -- sbData.make = false

    if GetCursorInfo() ~= nil then
        group, itemID, mountID, spellID = GetCursorInfo()
        if group == "spell" then
            name, _, iconID = GetSpellInfo(spellID)
            self:GetParent().data.payload = name
        elseif group == "item" then
            iconID = C_Item.GetItemIconByID(itemID)
            self:GetParent().data.payload = "item:"..itemID
        elseif group == "mount" then
            name, _, iconID = C_MountJournal.GetMountInfoByID(itemID)
            self:GetParent().data.payload = name
        elseif group == "battlepet" then
            local petGUID = itemID
            local petInfo = C_PetJournal.GetPetInfoTableByPetID(petGUID)

            iconID = petInfo.icon
            self:GetParent().data.payload = petInfo.name

            --[[sbData.name = "/sp"
            sbData.payload = "/sp"
            sbData.sbIndex = self:GetParent().stackID - 2
            sbData.make = true]]

        -- elseif group == "" then
        -- elseif group == "" then
        -- elseif group == "" then
        end

        --[[if sbData.make then
            MBStack.addBlock(SmartBlock())
        end]]

	    self.icon:SetTexture(iconID)
        ClearCursor()
        UpdateMacroBlockText()
    end
end

-- User edit block handlers
function MB_EDIT_OnTextChanged(self, userInput)

    self.instructions:SetShown(self:GetText() == "")

    -- local parent = self:GetParent()

    self:GetParent().data.payload = self:GetText()

    UpdateMacroBlockText()
end

-- Conditional modifier block handlers
local function ModOption_SetShown(block)
    block.shift:SetShown(block.config.open)
    block.ctrl:SetShown(block.config.open)
    block.alt:SetShown(block.config.open)

    StackAdjust()
end

local MOD_OPEN = function(block, button)
    button.text:SetText("❬❬")
    button.open = true
    block:SetWidth(156)

    ModOption_SetShown(block)
end
local MOD_CLOSE = function(block, button)
    button.text:SetText("❭❭")
    button.open = false
    block:SetWidth(57)

    ModOption_SetShown(block)
end

function MB_MOD_OnLoad(self)
    MB_OnLoad(self)
    self.config.openFunc = MOD_OPEN
    self.config.closeFunc = MOD_CLOSE

    self.mods = 0
end

function MB_MOD_OnShow(self)
    self:SetBackdropColor(0, 128/255, 77/255)
    self.text:Hide()
    self.shift:SetShown(self.config.open)
    self.ctrl:SetShown(self.config.open)
    self.alt:SetShown(self.config.open)
end

function MB_MOD_ConfigOnClick(self, button, down)
    local p = self:GetParent()

    if not p.stacked then return end

    if not self.open then self.openFunc(p, self) elseif self.open then self.closeFunc(p, self) end
end

local textColor = {
    [false] = { 0.55, 0.55, 0.55, },
    [true] = { 1, 150/255, 0, },
}

function MB_MOD_OptionOnLoad(self)
    self:RegisterForClicks("LeftButtonUp")
    self:SetWidth(self.text:GetStringWidth())
    self.enabled = false
    self.text:SetTextColor(unpack(textColor[self.enabled]))
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

function MB_MOD_OptionOnClick(self, button, down)
    local p = self:GetParent()
    if not self.enabled then
        self.enabled = true
        p.mods = p.mods + self.val
    elseif self.enabled then
        self.enabled = false
        p.mods = p.mods - self.val
    end

    p.data.payload = modCase[p.mods] or "[mod]"
    UpdateMacroBlockText()
    self.text:SetTextColor(unpack(textColor[self.enabled]))
end