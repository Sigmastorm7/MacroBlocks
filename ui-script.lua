local addon, mb = ...

MB_BACKDROP = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface\\AddOns\\MacroBlocks\\media\\textures\\hd_border.tga",
	tile = true,
	tileSize = 24,
	tileEdge = true,
	edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 },
}

MB_COLOR_METAL_LIGHT = CreateColor(0.769, 0.745, 0.745)
MB_COLOR_METAL_MEDIUM = CreateColor(0.4, 0.373, 0.373)
MB_COLOR_METAL_DARK = CreateColor(0.227, 0.2, 0.2)
MB_COLOR_ORANGE = CreateColor(1, 0.5, 0)
MB_COLOR_WHITE = CreateColor(0.96, 0.96, 1)
MB_COLOR_YELLOW = CreateColor(1, 0.74, 0.3)

-- local p, w, h, l, r, t, b
-- p = 1/1024
-- l = 0.0009765625
-- r = 0.1640625
-- t = 0.5791015625
-- b = 0.7412109375
-- w = (r-l)*1024
-- h = (b-t)*1024

-- local atlasTest = CreateFrame("Frame", nil, UIParent)
-- atlasTest:SetPoint("TOPLEFT", UIParent, "CENTER", -80, 80)
-- atlasTest:SetPoint("BOTTOMRIGHT", UIParent, "CENTER", 80, -80)

-- local tex1 = atlasTest:CreateTexture(nil, "BACKGROUND")
-- tex1:SetTexture("Interface\\FrameGeneral\\UIFrameMechagon")
-- tex1:SetTexCoord(l, r, t, b)
-- tex1:SetSize(120, 120)
-- tex1:SetPoint("CENTER", atlasTest, "TOPLEFT")

-- local tex2 = atlasTest:CreateTexture(nil, "BACKGROUND")
-- tex2:SetTexture("Interface\\FrameGeneral\\UIFrameMechagon")
-- tex2:SetTexCoord(r, l, t, b)
-- tex2:SetSize(120, 120)
-- tex2:SetPoint("CENTER", atlasTest, "TOPRIGHT")

-- local tex3 = atlasTest:CreateTexture(nil, "BACKGROUND")
-- tex3:SetTexture("Interface\\FrameGeneral\\UIFrameMechagon")
-- tex3:SetTexCoord(l, r, b, t)
-- tex3:SetSize(120, 120)
-- tex3:SetPoint("CENTER", atlasTest, "BOTTOMLEFT")

-- local tex4 = atlasTest:CreateTexture(nil, "BACKGROUND")
-- tex4:SetTexture("Interface\\FrameGeneral\\UIFrameMechagon")
-- tex4:SetTexCoord(r, l, b, t)
-- tex4:SetSize(120, 120)
-- tex4:SetPoint("CENTER", atlasTest, "BOTTOMRIGHT")

local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(f, event, arg)
    if event == "ADDON_LOADED" and arg == "Blizzard_MacroUI" then
        MacroFrame:HookScript("OnShow", function(self)
            MacroBlocks:Show()
		end)
        MacroFrame:HookScript("OnHide", function(_self)
			MacroBlocks:Hide()
		end)
    end
end)