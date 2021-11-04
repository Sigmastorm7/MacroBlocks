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
				"Alias: /use",
				"Command",
				"Uses an item or spell (prefers items)",
			},
		},{
			["name"] = "/cast",
			["payload"] = "/cast",
			["tooltip"] = {
				"Cast",
				"Alias: /cast",
				"Command",
				"Uses a spell or item (prefers spells)",
			},
		},{
			["name"] = "/target",
			["payload"] = "/tar",
			["tooltip"] = {
				"Target",
				"Alias: /target, /tar",
				"Command",
				"Set target to unit or @ modifier",
			},
		},{
			["name"] = "/focus",
			["payload"] = "/focus",
			["tooltip"] = {
				"Focus",
				"Alias: /focus",
				"Command",
				"Set focus target",
			},
		},{
			["name"] = "/cleartarget",
			["payload"] = "/cleartarget",
			["tooltip"] = {
				"Clear Target",
				"Alias: /cleartarget",
				"Command",
				"Clears current target",
			},
		},{
			["name"] = "/clearfocus",
			["payload"] = "/clearfocus",
			["tooltip"] = {
				"Clear Focus",
				"Alias: /clearfocus",
				"Command",
				"Clears focus target",
			},
		},{
			["name"] = "/equip",
			["payload"] = "/eq",
			["tooltip"] = {
				"Equip",
				"Alias: /equip, /eq)",
				"Command",
				"Equip an item to its default slot",
			},
		},{
			["name"] = "/equipset",
			["payload"] = "/equipset",
			["tooltip"] = {
				"Equip Set",
				"Alias: /equipset",
				"Command",
				"Change equipped items to a set from the Equipment Manager",
			},
		},{
			["name"] = "/equipslot",
			["payload"] = "/equipslot",
			["tooltip"] = {
				"Equip Slot",
				"Alias: /equipslot",
				"Command",
				"Equip an item to a specific slot",
			},
		},{
			["name"] = "/targetfriend",
			["payload"] = "/targetfriend",
			["tooltip"] = {
				"Target Friend",
				"Alias: /targetfriend",
				"Command",
				"Cycle through friendly units in line of sight",
			},
		},{
			["name"] = "/targetenemy",
			["payload"] = "/targetenemy",
			["tooltip"] = {
				"Target Enemy",
				"Alias: /targetenemy",
				"Command",
				"Cycle through enemy units in line of sight",
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
				"Alias: [combat]",
				"Condition",
				"Returns true if player is in combat",
			},
		},{
			["name"] = "exists",
			["payload"] = "[exists]",
			["tooltip"] = {
				"Exists",
				"Alias: [exists]",
				"Condition",
				"Returns true if specified unit exists",
			},
		},{
			["name"] = "help",
			["payload"] = "[help]",
			["tooltip"] = {
				"Help",
				"Alias: [help]",
				"Condition",
				"Returns true if specified unit is friendly",
			},
		},{
			["name"] = "harm",
			["payload"] = "[harm]",
			["tooltip"] = {
				"Harm",
				"Alias: [harm]",
				"Condition",
				"Returns true if specified unit is an enemy",
			},
		},{
			["name"] = "dead",
			["payload"] = "[dead]",
			["tooltip"] = {
				"Dead",
				"Alias: [dead]",
				"Condition",
				"Returns true if specified unit is dead",
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
				"Alias: [modifier], [modifier:key], [mod], [mod:key]",
				"Condition",
				"Returns true if one or more modifier keys are pressed",
			},
			["template"] = "ChoiceBlockTemplate",
			["func"] = "USR_CHOICE",
			["label"] = "MOD",
		},{
			["name"] = "spec",
			["tooltip"] = {
				"Specialization",
				"Alias: [spec:num]",
				"Condition",
				"Returns true if player's active spec matches the spec number",
			},
			["template"] = "ChoiceBlockTemplate",
			["func"] = "USR_CHOICE",
			["label"] = "SPEC"
		},{
			["name"] = "talent",
			["payload"] = "[talent]",
			["tooltip"] = {
				"Talen",
				"Alias: [talent:row/column]",
				"Condition",
				"Returns true if the specified talent is active",
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
				"Alias: [@player]",
				"Target Modifier",
				"Use macro action on yourself",
			},
		},{
			["name"] = "@target",
			["payload"] = "[@target]",
			["tooltip"] = {
				"Use on Target",
				"Alias: [@target]",
				"Target Modifier",
				"Use macro action on current target",
			},
		},{
			["name"] = "@focus",
			["payload"] = "[@focus]",
			["tooltip"] = {
				"Use on Focus",
				"Alias: [@focus]",
				"Target Modifier",
				"Use macro action on focus target",
			},
		},{
			["name"] = "@pet",
			["payload"] = "[@pet]",
			["tooltip"] = {
				"Use on Pet",
				"Alias: [@pet]",
				"Target Modifier",
				"Use macro action on your pet",
			},
		},{
			["name"] = "@mouseover",
			["payload"] = "[@mouseover]",
			["tooltip"] = {
				"Use on Mouseover",
				"Alias: [@mouseover]",
				"Target Modifier",
				"Use macro action on unit or nameplate under cursor",
			},
		},{
			["name"] = "@cursor",
			["payload"] = "[@cursor]",
			["tooltip"] = {
				"Use at Cursor",
				"Alias: [@cursor]",
				"Target Modifier",
				"Use macro action on the ground at the cursor location",
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
				"Alias: #show",
				"Utility",
				"Dynamically changes macro icon based on condtions",
			},
			["func"] = "NEW_LINE",
		},{
			["name"] = "#showtooltip",
			["payload"] = "#showtooltip\n",
			["tooltip"] = {
				"Show Tooltip",
				"Alias: #showtooltip",
				"Utility",
				"Dynamically changes macro icon and action tooltip based on condtions",
			},
			["func"] = "NEW_LINE",
		},{
			["name"] = "⮐",
			["payload"] = "\n",
			["tooltip"] = {
				"New Line",
				"Alias: \\n",
				"Utility",
				"Creates a new line",
			},
			["symbol"] = true,
			["func"] = "NEW_LINE",
		},{
			["name"] = ";",
			["payload"] = ";",
			["tooltip"] = {
				"Else",
				"Alias: ';'",
				"Utility",
				"Separates condition statements, the first true statement will be used",
			},
		},
	},
	["LOG"] = { -- logic
		{
			["name"] = "no",
			["payload"] = "$!>",
			["tooltip"] = {
				"No",
				"Alias: 'no'",
				"Logic / Condition Modifier",
				"Modified condition returns true if NOT true",
			},
			["neighbors"] = 1,
		},{
			["name"] = "and",
			["payload"] = "<$&>",
			["tooltip"] = {
				"And",
				"Alias: ', '",
				"Logic / Condition Modifier",
				"Modified conditions return true if BOTH are true",
			},
			["neighbors"] = 2,
		},{
			["name"] = "true",
			["payload"] = "[]",
			["tooltip"] = {
				"True",
				"Alias: '[]'",
				"Logic / Condition Modifier",
				"Always returns true",
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