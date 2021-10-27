local addon, mb = ...

local MakeBlock = mb.MakeBlock
local blockColors = mb.BlockColors

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
    self.p = self:GetParent()
    self:SetBackdrop(UserBlockBackdrop)
    self:SetBackdropColor(0.325, 0.196, 0.043, 1)
    self:SetBackdropBorderColor(unpack(blockColors.User))
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