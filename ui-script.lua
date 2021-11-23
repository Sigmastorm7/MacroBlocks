local addon, mb = ...

mb.NineSlice = {
		["TopRightCorner"] = { atlas = "%s-NineSlice-Corner", mirrorLayout = true, },
		["TopLeftCorner"] = { atlas = "%s-NineSlice-Corner", mirrorLayout = true,},
		["BottomLeftCorner"] = { atlas = "%s-NineSlice-Corner", mirrorLayout = true, },
		["BottomRightCorner"] = { atlas = "%s-NineSlice-Corner",  mirrorLayout = true,},
		["TopEdge"] = { atlas = "_%s-NineSlice-EdgeTop" },
		["BottomEdge"] = { atlas = "_%s-NineSlice-EdgeBottom" },
		["LeftEdge"] = { atlas = "!%s-NineSlice-EdgeLeft" },
		["RightEdge"] = { atlas = "!%s-NineSlice-EdgeRight" },
		["Center"] = { atlas = "%s-NineSlice-Center" },
	}

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