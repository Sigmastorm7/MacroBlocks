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
    local p = self:GetParent()
    self:SetBackdrop(UserBlockBackdrop)
    self:SetBackdropColor(0.325, 0.196, 0.043, 1)
    self:SetBackdropBorderColor(unpack(blockColors.User))
end

-- User socket block handlers
function MB_SOCKET_OnClick(self, button, down)
    local parent = self:GetParent()
    local kind, name, spellID, itemID, mountID, iconID

    if GetCursorInfo() ~= nil then
        kind, itemID, mountID, spellID = GetCursorInfo()
        if kind == "spell" then

            print(spellID)
            name, _, iconID = GetSpellInfo(spellID)

        elseif kind == "item" then

            parent.payload = kind..":"..itemID
            iconID = C_Item.GetItemIconByID(itemID)

        elseif kind == "mount" then

            print(itemID)
            _, _, iconID = C_MountJournal.GetMountInfoByID(itemID)

        end

	    self.icon:SetTexture(iconID)
        ClearCursor()
        UpdateMacroBlockText()
    end
end

-- User edit block handlers
function MB_EDIT_OnTextChanged(self, userInput)

    self.instructions:SetShown(self:GetText() == "")

    local parent = self:GetParent()

    parent.payload = self:GetText()

    UpdateMacroBlockText()
end