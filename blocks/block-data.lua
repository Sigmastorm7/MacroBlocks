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
	["LOG"] = { -- PALADIN
		["hex"] = "fff38bb9",
		["rgb"] = { 0.9568606615066528,  0.549018383026123, 0.7294101715087891 },
	},
	["TAR"] = { -- WARLOCK
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
	["CMD"] = { -- slash commands
		{
			["name"] = "/use",
			["payload"] = "/use",
		},{
			["name"] = "/cast",
			["payload"] = "/cast",
		},{
			["name"] = "/target",
			["payload"] = "/tar",
		},{
			["name"] = "/focus",
			["payload"] = "/focus",
		},{
			["name"] = "/cleartarget",
			["payload"] = "/cleartarget",
		},{
			["name"] = "/clearfocus",
			["payload"] = "/clearfocus",
		},{
			["name"] = "/equip",
			["payload"] = "/eq",
		},{
			["name"] = "/equipset",
			["payload"] = "/equipset",
		},{
			["name"] = "/equipslot",
			["payload"] = "/equipslot",
		},{
			["name"] = "/targetfriend",
			["payload"] = "/targetfriend",
		},{
			["name"] = "/targetenemy",
			["payload"] = "/targetenemy",
		},--[[{
			["name"] = "/click",
			["payload"] = "/click",
		},{
			["name"] = "/assist",
			["payload"] = "/a",
		},{
			["name"] = "/golfclap",
			["payload"] = "/golfclap",
		},{
			["name"] = "/summonpet",
			["payload"] = "/sp"
		},]]
	},
	["CON"] = { -- conditionals
		{
			["name"] = "combat",
			["payload"] = "[combat]",
		},{
			["name"] = "exists",
			["payload"] = "[exists]",
		},{
			["name"] = "help",
			["payload"] = "[help]",
		},{
			["name"] = "harm",
			["payload"] = "[harm]",
		},{
			["name"] = "dead",
			["payload"] = "[dead]",
		},--[[{
			["name"] = "ghost",
			["payload"] = "[ghost]",
		},{
			["name"] = "stealth",
			["payload"] = "[stealth]",
		},]]
		{
			["name"] = "mod",
			["payload"] = "[mod]",
			["template"] = "ChoiceBlockTemplate",
			["func"] = "USR_CHOICE",
			["label"] = "MOD",
		},{
			["name"] = "spec",
			["template"] = "ChoiceBlockTemplate",
			["func"] = "USR_CHOICE",
			["label"] = "SPEC"
		},{
			["name"] = "talent",
			["payload"] = "[talent]",
			["template"] = "TalentBlockTemplate",
			["func"] = "USR_CHOICE",
			["label"] = "TALENT"
		},--[[{
			["name"] = "button",
			["payload"] = "[btn]",
			["template"] = "ChoiceBlockTemplate",
			["func"] = "USR_CHOICE",
			["choices"] = {
				{ ["name"] = "Left", ["value"] = 1, },
				{ ["name"] = "Right", ["value"] = 2, },
				{ ["name"] = "Middle", ["value"] = 3, },
			}
		},]]
	},
	["TAR"] = { -- target modifiers
		{
			["name"] = "@player",
			["payload"] = "[@player]",
		},{
			["name"] = "@target",
			["payload"] = "[@target]",
		},{
			["name"] = "@focus",
			["payload"] = "[@focus]",
		},{
			["name"] = "@pet",
			["payload"] = "[@pet]",
		},{
			["name"] = "@mouseover",
			["payload"] = "[@mouseover]",
		},{
			["name"] = "@cursor",
			["payload"] = "[@cursor]",
		},--[[{
			["name"] = "@party1",
			["payload"] = "[@party1]",
		},{
			["name"] = "@arena1",
			["payload"] = "[@arena1]",
		},{
			["name"] = "@boss1",
			["payload"] = "[@boss1]",
		},{
			["name"] = "@targettarget",
			["payload"] = "[@targettarget]",
		},]]
	},--[[
	["Social"] = {
		["@#"] = {
			["name"] = "AaBbCc",
			["payload"] = "AaBbCc",
		},
	},]]
	["USR"] = { -- user input
		{
			["name"] = "socket",
			["payload"] = "",
			["func"] = "USR_SOCKET",
			["template"] = "SocketBlockTemplate"
		},{
			["name"] = "custom input",
			["payload"] = "",
			["func"] = "USR_EDIT",
			["template"] = "EditBlockTemplate"
		},
	},
	["UTL"] = { -- utility
		{
			["name"] = "#show",
			["payload"] = "#show\n",
			["func"] = "NEW_LINE",
		},{
			["name"] = "#showtooltip",
			["payload"] = "#showtooltip\n",
			["func"] = "NEW_LINE",
		},{
			["name"] = "⮐",
			["payload"] = "\n",
			["symbol"] = true,
			["func"] = "NEW_LINE",
		},{
			["name"] = ";",
			["payload"] = ";",
		},
	},
	["LOG"] = { -- logic
		{
			["name"] = "no",
			["payload"] = "$!>",
			["neighbors"] = 1,
		},{
			["name"] = "and",
			["payload"] = "<$&>",
			["neighbors"] = 2,
		},{
			["name"] = "true",
			["payload"] = "[]"
		},{
			["name"] = "else",
			["payload"] = ";"
		},
	},
}

mb.AdvancedBlocks = {
    
}