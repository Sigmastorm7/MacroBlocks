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
			["tooltip"] = {
				"Use",
				"Usage: /use",
				"Type: Command",
				"Function: Uses an item or spell (prefers items)",
			},
		},{
			["name"] = "/cast",
			["payload"] = "/cast",
			["tooltip"] = {
				"Cast",
				"Usage: /cast",
				"Type: Command",
				"Function: Uses a spell or item (prefers spells)",
			},
		},{
			["name"] = "/target",
			["payload"] = "/tar",
			["tooltip"] = {
				"Target",
				"Usage: /target, /tar",
				"Type: Command",
				"Function: Set target to unit or @ modifier",
			},
		},{
			["name"] = "/focus",
			["payload"] = "/focus",
			["tooltip"] = {
				"Focus",
				"Usage: /focus",
				"Type: Command",
				"Function: Set focus target",
			},
		},{
			["name"] = "/cleartarget",
			["payload"] = "/cleartarget",
			["tooltip"] = {
				"Clear Target",
				"Usage: /cleartarget",
				"Type: Command",
				"Function: Clears current target",
			},
		},{
			["name"] = "/clearfocus",
			["payload"] = "/clearfocus",
			["tooltip"] = {
				"Clear Focus",
				"Usage: /clearfocus",
				"Type: Command",
				"Function: Clears focus target",
			},
		},{
			["name"] = "/equip",
			["payload"] = "/eq",
			["tooltip"] = {
				"Equip",
				"Usage: /equip, /eq",
				"Type: Command",
				"Function: Equip an item to its default slot",
			},
		},{
			["name"] = "/equipset",
			["payload"] = "/equipset",
			["tooltip"] = {
				"Equip Set",
				"Usage: /equipset",
				"Type: Command",
				"Function: Change equipped items to a set from the Equipment Manager",
			},
		},{
			["name"] = "/equipslot",
			["payload"] = "/equipslot",
			["tooltip"] = {
				"Equip Slot",
				"Usage: /equipslot",
				"Type: Command",
				"Function: Equip an item to a specific slot",
			},
		},{
			["name"] = "/targetfriend",
			["payload"] = "/targetfriend",
			["tooltip"] = {
				"Target Friend",
				"Usage: /targetfriend",
				"Type: Command",
				"Function: Cycle through friendly units in line of sight",
			},
		},{
			["name"] = "/targetenemy",
			["payload"] = "/targetenemy",
			["tooltip"] = {
				"Target Enemy",
				"Usage: /targetenemy",
				"Type: Command",
				"Function: Cycle through enemy units in line of sight",
			},
		},--[[{
			["name"] = "/click",
			["payload"] = "/click",
			["tooltip"] = {
				"___", "___",
				"Commad"},
				"Set focus target",
			},
		},{
			["name"] = "/assist",
			["payload"] = "/a",
			["tooltip"] = {
				"___", "___",
				"Commad"},
				"Set focus target",
			},
		},{
			["name"] = "/golfclap",
			["payload"] = "/golfclap",
			["tooltip"] = {
				"___", "___",
				"Commad"},
				"Set focus target",
			},
		},{
			["name"] = "/summonpet",
			["payload"] = "/sp"
			["tooltip"] = {
				"___", "___",
				"Commad"},
				"Set focus target",
			},
		},]]
	},
	["CON"] = { -- conditionals
		{
			["name"] = "combat",
			["payload"] = "[combat]",
			["tooltip"] = {
				"Combat",
				"Usage: [combat]",
				"Type: Condition",
				"Function: Returns true if player is in combat",
			},
		},{
			["name"] = "exists",
			["payload"] = "[exists]",
			["tooltip"] = {
				"Exists",
				"Usage: [exists]",
				"Type: Condition",
				"Function: Returns true if specified unit exists",
			},
		},{
			["name"] = "help",
			["payload"] = "[help]",
			["tooltip"] = {
				"Help",
				"Usage: [help]",
				"Type: Condition",
				"Function: Returns true if specified unit is friendly",
			},
		},{
			["name"] = "harm",
			["payload"] = "[harm]",
			["tooltip"] = {
				"Harm",
				"Usage: [harm]",
				"Type: Condition",
				"Function: Returns true if specified unit is an enemy",
			},
		},{
			["name"] = "dead",
			["payload"] = "[dead]",
			["tooltip"] = {
				"Dead",
				"Usage: [dead]",
				"Type: Condition",
				"Function: Returns true if specified unit is dead",
			},
		},--[[{
			["name"] = "ghost",
			["payload"] = "[ghost]",
			["tooltip"] = {
				"Ghost",
				"[ghost]",
				"Condition",
				"Specified player is dead",
			},
		},{
			["name"] = "stealth",
			["payload"] = "[stealth]",
			["tooltip"] = {
				"___", "___",
				"Condiion"},
				"Set focus target",
			},
		},]]
		{
			["name"] = "mod",
			["payload"] = "[mod]",
			["tooltip"] = {
				"Modifier",
				"Usage: [modifier], [modifier:key], [mod], [mod:key]",
				"Type: Condition",
				"Function: Returns true if one or more modifier keys are pressed",
			},
			["template"] = "ChoiceBlockTemplate",
			["func"] = "USR_CHOICE",
			["label"] = "MOD",
		},{
			["name"] = "spec",
			["tooltip"] = {
				"Specialization",
				"Usage: [spec:num]",
				"Type: Condition",
				"Function: Returns true if player's active spec matches the spec number",
			},
			["template"] = "ChoiceBlockTemplate",
			["func"] = "USR_CHOICE",
			["label"] = "SPEC"
		},{
			["name"] = "talent",
			["payload"] = "[talent]",
			["tooltip"] = {
				"Talent",
				"Usage: [talent:row/column]",
				"Type: Condition",
				"Function: Returns true if the specified talent is active",
			},
			["template"] = "TalentBlockTemplate",
			["func"] = "USR_CHOICE",
			["label"] = "TALENT"
		},--[[{
			["name"] = "button",
			["payload"] = "[btn]",
			["tooltip"] = {
				"___", "___",
				"Condiion"},
				"Set focus target",
			},
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
			["tooltip"] = {
				"Use on Player",
				"Usage: [@player]",
				"Type: Target Modifier",
				"Function: Use macro action on yourself",
			},
		},{
			["name"] = "@target",
			["payload"] = "[@target]",
			["tooltip"] = {
				"Use on Target",
				"Usage: [@target]",
				"Type: Target Modifier",
				"Function: Use macro action on current target",
			},
		},{
			["name"] = "@focus",
			["payload"] = "[@focus]",
			["tooltip"] = {
				"Use on Focus",
				"Usage: [@focus]",
				"Type: Target Modifier",
				"Function: Use macro action on focus target",
			},
		},{
			["name"] = "@pet",
			["payload"] = "[@pet]",
			["tooltip"] = {
				"Use on Pet",
				"Usage: [@pet]",
				"Type: Target Modifier",
				"Function: Use macro action on your pet",
			},
		},{
			["name"] = "@mouseover",
			["payload"] = "[@mouseover]",
			["tooltip"] = {
				"Use on Mouseover",
				"Usage: [@mouseover]",
				"Type: Target Modifier",
				"Function: Use macro action on unit or nameplate under cursor",
			},
		},{
			["name"] = "@cursor",
			["payload"] = "[@cursor]",
			["tooltip"] = {
				"Use at Cursor",
				"Usage: [@cursor]",
				"Type: Target Modifier",
				"Function: Use macro action on the ground at the cursor location",
			},
		},--[[{
			["name"] = "@party1",
			["payload"] = "[@party1]",
			["tooltip"] = {
				"___", "___",
				"Target Modifier"},
				"Set focus target",
			},
		},{
			["name"] = "@arena1",
			["payload"] = "[@arena1]",
			["tooltip"] = {
				"___", "___",
				"Target Modifier"},
				"Set focus target",
			},
		},{
			["name"] = "@boss1",
			["payload"] = "[@boss1]",
			["tooltip"] = {
				"___", "___",
				"Target Modifier"},
				"Set focus target",
			},
		},{
			["name"] = "@targettarget",
			["payload"] = "[@targettarget]",
			["tooltip"] = {
				"___", "___",
				"Target Modifier"},
				"Set focus target",
			},
		},]]
	},--[[
	["Social"] = {
		["@#"] = {
			["name"] = "AaBbCc",
			["payload"] = "AaBbCc",
			["tooltip"] = {
				"___", "___",
				"Target Modifier"},
				"Set focus target",
			},
		},
	},]]
	["USR"] = { -- user input
		{
			["name"] = "socket",
			["payload"] = "",
			["tooltip"] = {
				"Action Icon",
				"Action Name",
				"Custom Argument",
				"Place a spell, item, mount, or pet icon into the socket",
			},
			["func"] = "USR_SOCKET",
			["template"] = "SocketBlockTemplate"
		},{
			["name"] = "custom input",
			["payload"] = "",
			["tooltip"] = {
				"Text Box",
				"Custom Text",
				"Custom Argument",
				"Enter custom macro arguments",
			},
			["func"] = "USR_EDIT",
			["template"] = "EditBlockTemplate",
		},
	},
	["UTL"] = { -- utility
		{
			["name"] = "#show",
			["payload"] = "#show\n",
			["tooltip"] = {
				"Show",
				"Usage: #show",
				"Type: Utility",
				"Function: Dynamically changes macro icon based on condtions",
			},
			["func"] = "NEW_LINE",
		},{
			["name"] = "#showtooltip",
			["payload"] = "#showtooltip\n",
			["tooltip"] = {
				"Show Tooltip",
				"Usage: #showtooltip",
				"Type: Utility",
				"Function: Dynamically changes macro icon and action tooltip based on condtions",
			},
			["func"] = "NEW_LINE",
		},{
			["name"] = "⮐",
			["payload"] = "\n",
			["tooltip"] = {
				"New Line",
				"Usage: '\\n'",
				"Type: Utility",
				"Function: Creates a new line",
			},
			["symbol"] = true,
			["func"] = "NEW_LINE",
		},{
			["name"] = ";",
			["payload"] = ";",
			["tooltip"] = {
				"Else",
				"Usage: ';'",
				"Type: Utility",
				"Function: Separates condition statements, the first true statement will be used",
			},
		},
	},
	["LOG"] = { -- logic
		{
			["name"] = "no",
			["payload"] = "$!>",
			["tooltip"] = {
				"No",
				"Usage: 'no'",
				"Type: Logic / Condition Modifier",
				"Function: Modified condition returns true if NOT true",
			},
			["neighbors"] = 1,
		},{
			["name"] = "and",
			["payload"] = "<$&>",
			["tooltip"] = {
				"And",
				"Usage: ', '",
				"Type: Logic / Condition Modifier",
				"Function: Joins adjacent condition blocks. Modified conditions return true if BOTH are true",
			},
			["neighbors"] = 2,
		},{
			["name"] = "true",
			["payload"] = "[]",
			["tooltip"] = {
				"True",
				"Usage: '[]'",
				"Type: Logic / Condition Modifier",
				"Function: Always returns true",
			},
		},--[[{
			["name"] = "else",
			["payload"] = ";",
			["tooltip"] = {
				"___", "___",
				"Logic",
				"Set focus target",
			},
		},]]
	},
}

mb.AdvancedBlocks = {
    
}