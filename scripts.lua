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
		MBStack.remBlock(self)
		-- self.stacked = false
    else
        -- MBPalette.blocks[self.paletteID] = nil
    end

    MBFrame.dragging = self
    MBStack:SetScript("OnUpdate", StackDisplaceCheck)

end

function MB_OnDragStop(self)

    self:StopMovingOrSizing()
	self:SetUserPlaced(false)

    if MouseIsOver(MBStack) then
        if not self.stacked then
            MBPalette.blocks[self.paletteID] = mb.MakeBlock(self.kind, self.data, self.paletteID)
        end
        MBStack.addBlock(self)
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
        mb.BlockPoolCollection:Release(MBPalette.blocks[self.paletteID])
        MBPalette.blocks[self.paletteID] = self
        self.stacked = false
    end

    MBFrame.dragging = nil
    MBStack:SetScript("OnUpdate", nil)
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
    local kind, name, spellID, itemID, mountID, iconID

    -- sbData.make = false

    if GetCursorInfo() ~= nil then
        kind, itemID, mountID, spellID = GetCursorInfo()
        if kind == "spell" then
            name, _, iconID = GetSpellInfo(spellID)
            self:GetParent().data.payload = name
        elseif kind == "item" then
            iconID = C_Item.GetItemIconByID(itemID)
            self:GetParent().data.payload = "item:"..itemID
        elseif kind == "mount" then
            name, _, iconID = C_MountJournal.GetMountInfoByID(itemID)
            self:GetParent().data.payload = name
        elseif kind == "battlepet" then
            local petGUID = itemID
            local petInfo = C_PetJournal.GetPetInfoTableByPetID(petGUID)

            iconID = petInfo.icon
            self:GetParent().data.payload = petInfo.name

            --[[sbData.name = "/sp"
            sbData.payload = "/sp"
            sbData.sbIndex = self:GetParent().stackID - 2
            sbData.make = true]]

        -- elseif kind == "" then
        -- elseif kind == "" then
        -- elseif kind == "" then
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
    button.text:SetText("❬")
    button.open = true
    block:SetWidth(156)

    ModOption_SetShown(block)
end
local MOD_CLOSE = function(block, button)
    button.text:SetText("❭")
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
    [-1] = { 1, 0, 0, },
    [0] = { 1, 1, 1, },
    [1] = { 0, 1, 0, },
}

function MB_MOD_OptionOnLoad(self)
    self:RegisterForClicks("LeftButtonUp") -- , "RightButtonUp", "MiddleButtonUp")
    self:SetWidth(self.text:GetStringWidth())
    self.enabled = 0
    self.text:SetTextColor(unpack(textColor[0]))
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
    -- if button == "LeftButton" then
        if self.enabled == 0 then
            self.enabled = 1
            p.mods = p.mods + self.val
        elseif self.enabled == 1 then
            self.enabled = 0
            p.mods = p.mods - self.val
        end
        print(p.mods)
    -- elseif button == "RightButton" then
    --     if self.enabled >= 0 then
    --         self.enabled = -1
    --     elseif self.enabled == -1 then
    --         self.enabled = 0
    --     end
    -- elseif button == "MiddleButton" then
    --     self.enabled = 0
    -- end

    p.data.payload = modCase[p.mods] or "[mod]"
    UpdateMacroBlockText()
    self.text:SetTextColor(unpack(textColor[self.enabled]))
end