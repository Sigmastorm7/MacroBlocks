local addon, mb = ...

-- Frame backdrop templates
mb.USRBackdrop = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 24,
	edgeSize = 12,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
}

mb.blockBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 24,
	edgeSize = 12,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
}

mb.stackBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background-Maw",
	edgeFile = "Interface\\FriendsFrame\\UI-Toast-Border",
	tile = true,
	tileEdge = true,
	tileSize = 12,
	edgeSize = 12,
	insets = { left = 5, right = 5, top = 5, bottom = 5 },
}

-- Color tables
mb.GroupColors = {
	["HT"] = { -- HUNTER
		["hex"] = "ffa9d271",
		["rgb"] = { 0.6666651964187622, 0.8274491429328918, 0.447057843208313 },
	},
	["WR"] = { -- WARRIOR
		["hex"] = "ffc59a6c",
		["rgb"] = { 0.7764688730239868, 0.6078417897224426, 0.427450031042099 },
	},
	["SH"] = { -- SHAMAN
		["hex"] = "ff006fdc",
		["rgb"] = { 0,  0.4392147064208984, 0.8666647672653198 },
	},
	["CMD"] = { -- MAGE
		["hex"] = "ff3ec6ea",
		["rgb"] = { 0.2470582872629166,  0.7803904414176941, 0.9215666055679321 },
	},
	["PT"] = { -- PRIEST
		["hex"] = "fffefefe",
		["rgb"] = { 0.9999977946281433,  0.9999977946281433, 0.9999977946281433 },
	},
	["SMT"] = { -- PALADIN
		["hex"] = "fff38bb9",
		["rgb"] = { 0.9568606615066528,  0.549018383026123, 0.7294101715087891 },
	},
	["WK"] = { -- WARLOCK
		["hex"] = "ff8687ed",
		["rgb"] = { 0.5294106006622314, 0.5333321690559387, 0.933331310749054 },
	},
	["DH"] = { -- DEMONHUNTER
		["hex"] = "ffa22fc8",
		["rgb"] = { 0.639214277267456,  0.188234880566597, 0.7882335782051086 },
	},
	["DK"] = { -- DEATHKNIGHT
		["hex"] = "ffc31d39",
		["rgb"] = { 0.7686257362365723,  0.117646798491478, 0.2274504750967026 },
	},
	["USR"] = { -- DRUID
		["hex"] = "fffe7b09",
		["rgb"] = { 0.9999977946281433, 0.4862734377384186, 0.03921560198068619 },
	},
	["CON"] = { -- MONK
		["hex"] = "ff00fe97",
		["rgb"] = { 0, 0.9999977946281433, 0.5960771441459656 },
	},
	["UTL"] = { -- ROGUE
		["hex"] = "fffef367",
		["rgb"] = { 0.9999977946281433, 0.9568606615066528, 0.4078422486782074 },
	},
}

-- Default blocks shown in the basic palette
mb.BasicBlocks = {
	["UTL"] = {
		{
			["groupID"] = "UTL1",
			["name"] = "#showtooltip",
			["payload"] = "#showtooltip\n",
			["func"] = "NEW_LINE",
		},
		{
			["groupID"] = "UTL2",
			["name"] = "#show",
			["payload"] = "#show\n",
			["func"] = "NEW_LINE",
		},
		{
			["groupID"] = "UTL3",
			["name"] = "⮐",
			["payload"] = "\n",
			["symbol"] = true,
			["func"] = "NEW_LINE",
		},
		{
			["groupID"] = "UTL4",
			["name"] = ";",
			["payload"] = ";",
		},
	},
	["CMD"] = {
		{
			["groupID"] = "CMD1",
			["name"] = "/use",
			["payload"] = "/use",
		},
		{
			["groupID"] = "CMD2",
			["name"] = "/cast",
			["payload"] = "/cast",
		},
		{
			["groupID"] = "CMD3",
			["name"] = "/target",
			["payload"] = "/tar",
		},
		{
			["groupID"] = "CMD4",
			["name"] = "/cleartarget",
			["payload"] = "/cleartarget",
		},--[[
		{
			["groupID"] = "CMD#",
			["name"] = "/targetlasttarget",
			["payload"] = "/targetlasttarget",
		},]]
		{
			["groupID"] = "CMD5",
			["name"] = "/focus",
			["payload"] = "/focus",
		},
		{
			["groupID"] = "CMD6",
			["name"] = "/clearfocus",
			["payload"] = "/clearfocus",
		},--[[
		{
			["groupID"] = "CMD7",
			["name"] = "/assist",
			["payload"] = "/a",
		},]]
		{
			["groupID"] = "CMD7",
			["name"] = "/equip",
			["payload"] = "/eq",
		},--[[
		{
			["groupID"] = "CMD#",
			["name"] = "/equipset",
			["payload"] = "/equipset",
		},
		{
			["groupID"] = "CMD#",
			["name"] = "/equipslot",
			["payload"] = "/equipslot",
		},
		{
			["groupID"] = "CMD#",
			["name"] = "/click",
			["payload"] = "/click",
		},
		{
			["groupID"] = "CMD#",
			["name"] = "/golfclap",
			["payload"] = "/golfclap",
		},]]
		{
			["groupID"] = "CMD8",
			["name"] = "/summonpet",
			["payload"] = "/sp"
		},
	},
	["CON"] = {
		{
			["groupID"] = "CON1",
			["name"] = "mod",
			["payload"] = "[mod]",
			["template"] = "ChoiceBlockTemplate",
			["func"] = "USR_CHOICE",
			["choices"] = {
				{ ["name"] = "shift", ["value"] = 1, },
				{ ["name"] = "ctrl", ["value"] = 2, },
				{ ["name"] = "alt", ["value"] = 4, },
			}
		},--[[
		{
			["groupID"] = "CON#",
			["name"] = "combat",
			["payload"] = "[combat]",
		},
		{
			["groupID"] = "CON#",
			["name"] = "exists",
			["payload"] = "[exists]",
		},]]
		{
			["groupID"] = "CON2",
			["name"] = "help",
			["payload"] = "[help]",
		},
		{
			["groupID"] = "CON3",
			["name"] = "harm",
			["payload"] = "[harm]",
		},--[[
		{
			["groupID"] = "CON#",
			["name"] = "dead",
			["payload"] = "[dead]",
		},]]
		{
			["groupID"] = "CON4",
			["name"] = "@mouseover",
			["payload"] = "[@mouseover]",
		},
		{
			["groupID"] = "CON5",
			["name"] = "@cursor",
			["payload"] = "[@cursor]",
		},
		{
			["groupID"] = "CON6",
			["name"] = "@focus",
			["payload"] = "[@focus]",
		},
	},--[[
	["Social"] = {
		["@#"] = {
			["name"] = "AaBbCc",
			["payload"] = "AaBbCc",
		},
	},]]
	["USR"] = {
		{
			["groupID"] = "USR1",
			["name"] = "socket",
			["payload"] = "",
			["func"] = "USR_SOCKET",
			["template"] = "SocketBlockTemplate"
		},
		{
			["groupID"] = "USR2",
			["name"] = "custom input",
			["payload"] = "",
			["func"] = "USR_EDIT",
			["template"] = "EditBlockTemplate"
		},
	},
	["SMT"] = {
		{
			["groupID"] = "SMT1",
			["name"] = "no",
			["payload"] = "[no",
			["smartData"] = {
				["hooks"] = { 1, },
				["palette"] = true,
				["group"] = "CON",
			}
		},
		{
			["groupID"] = "SMT2",
			["name"] = "and",
			["payload"] = ",",
			["smartData"] = {
				["hooks"] = { -1, 1, },
				["palette"] = true,
				["group"] = "CON",
			}
		},
	},
}

mb.AdvancedBlocks = {
    
}