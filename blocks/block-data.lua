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
			["label"] = "MOD",
			["template"] = "ChoiceBlockTemplate",
			["config"] = {
				["sum"] = 0,
				["mods"] = { "shift", "ctrl", "alt", },
				["buttons"] = {
					[1] = false,
					[2] = false,
					[3] = false,
				},
				["modCombos"] = {
					[0] = "[mod]",
					[1] = "[mod:shift]",
					[2] = "[mod:ctrl]",
					[3] = "[mod:shiftctrl]",
					[4] = "[mod:alt]",
					[5] = "[mod:shiftalt]",
					[6] = "[mod:ctrlalt]",
					[7] = "[mod:shiftctrlalt]",
				},
				["textColor"] = {
					[true] = { 0, 1, 0.4 },
					[false] = { 0.55, 0.55, 0.55 },
				},
			},
		},{
			["name"] = "spec",
			["label"] = "SPEC",
			["template"] = "ChoiceBlockTemplate",
			["config"] = {
				["enabledSpec"] = 0,
				["buttons"] = {
					false, -- [1] = false,
					false, -- [2] = false,
					false, -- [3] = false,
					false, -- [4] = false,
				},
				["textColor"] = {
					[true] = { 0, 1, 0.4 },
					[false] = { 0.55, 0.55, 0.55 },
				},
			},
		},{
			["name"] = "talent",
			["label"] = "TALENT",
			["template"] = "TalentBlockTemplate",
			["config"] = {
				["enabledSpec"] = 0,
				["buttons"] = {
					{ false, false, false, }, -- [1] =
					{ false, false, false, }, -- [2] =
					{ false, false, false, }, -- [3] =
					{ false, false, false, }, -- [4] =
					{ false, false, false, }, -- [5] =
					{ false, false, false, }, -- [6] =
					{ false, false, false, }, -- [7] =
				},
				["iconAlpha"] = {
					[true] = 1,
					[false] = 0.8,
				},
				["textColor"] = {
					[true] = { 1, 1, 1 },
					[false] = { 1, 0.8, 0.3 },
				},
			},
		},
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
	},
	["USR"] = { -- user input
		{
			["name"] = "socket",
			["label"] = "SOCKET",
			["template"] = "SocketBlockTemplate",
			["config"] = {
			--[[ template table structure for saved blocks
				["abilityInfo] = {
					["name"] = string,
					["type"] = string,
					["ID"] = number,
					["icon"] = number,
					["macroReference"] = string or number
				}
			]]
			},
			["abilityInfo"] = false,

		},{
			["name"] = "custom input",
			["label"] = "EDIT",
			["template"] = "EditBlockTemplate",
			["config"] = {
				["text"] = false,
			},
		},
	},
	["UTL"] = { -- utility
		{
			["name"] = "#show",
			["label"] = "RETURN",
			["payload"] = "#show\n",
			["template"] = "MacroBlockTemplate",
		},{
			["name"] = "#showtooltip",
			["label"] = "RETURN",
			["payload"] = "#showtooltip\n",
			["template"] = "MacroBlockTemplate",
		},{
			["name"] = "⮐",
			["label"] = "RETURN",
			["payload"] = "\n",
			["template"] = "MacroBlockTemplate",
			["symbol"] = true,
		},{
			["name"] = ";",
			["label"] = "SEMICLN",
			["payload"] = ";",
		},
	},
	["LOG"] = { -- logic
		{
			["name"] = "no",
			["label"] = "STR_MOD",
			["payload"] = "$!>",
			["template"] = "MacroBlockTemplate",
		},{
			["name"] = "and",
			["label"] = "STR_MOD",
			["payload"] = "<$&>",
			["template"] = "MacroBlockTemplate",
		},{
			["name"] = "true",
			["payload"] = "[]",
		},
	},
}

mb.BasicTooltips = {
	{	"Use",
		"Usage: /use",
		"Type: Command",
		"Function: Uses an item or spell (prefers items)",
	},{
		"Cast",
		"Usage: /cast",
		"Type: Command",
		"Function: Uses a spell or item (prefers spells)",
	},{
		"Target",
		"Usage: /target, /tar",
		"Type: Command",
		"Function: Set target to unit or @ modifier",
	},{
		"Focus",
		"Usage: /focus",
		"Type: Command",
		"Function: Set focus target",
	},{
		"Clear Target",
		"Usage: /cleartarget",
		"Type: Command",
		"Function: Clears current target",
	},{
		"Clear Focus",
		"Usage: /clearfocus",
		"Type: Command",
		"Function: Clears focus target",
	},{
		"Equip",
		"Usage: /equip, /eq",
		"Type: Command",
		"Function: Equip an item to its default slot",
	},{
		"Equip Set",
		"Usage: /equipset",
		"Type: Command",
		"Function: Change equipped items to a set from the Equipment Manager",
	},{
		"Equip Slot",
		"Usage: /equipslot",
		"Type: Command",
		"Function: Equip an item to a specific slot",
	},{
		"Target Friend",
		"Usage: /targetfriend",
		"Type: Command",
		"Function: Cycle through friendly units in line of sight",
	},{
		"Target Enemy",
		"Usage: /targetenemy",
		"Type: Command",
		"Function: Cycle through enemy units in line of sight",
	},{
		"Combat",
		"Usage: [combat]",
		"Type: Condition",
		"Function: Returns true if player is in combat",
	},{
		"Exists",
		"Usage: [exists]",
		"Type: Condition",
		"Function: Returns true if specified unit exists",
	},{
		"Help",
		"Usage: [help]",
		"Type: Condition",
		"Function: Returns true if specified unit is friendly",
	},{
		"Harm",
		"Usage: [harm]",
		"Type: Condition",
		"Function: Returns true if specified unit is an enemy",
	},{
		"Dead",
		"Usage: [dead]",
		"Type: Condition",
		"Function: Returns true if specified unit is dead",
	},{
		"Modifier",
		"Usage: [modifier], [modifier:key], [mod], [mod:key]",
		"Type: Condition",
		"Function: Returns true if one or more modifier keys are pressed",
	},{
		"Specialization",
		"Usage: [spec:num]",
		"Type: Condition",
		"Function: Returns true if player's active spec matches the spec number",
	},{
		"Talent",
		"Usage: [talent:row/column]",
		"Type: Condition",
		"Function: Returns true if the specified talent is active",
	},{
		"Use on Player",
		"Usage: [@player]",
		"Type: Target Modifier",
		"Function: Use macro action on yourself",
	},{
		"Use on Target",
		"Usage: [@target]",
		"Type: Target Modifier",
		"Function: Use macro action on current target",
	},{
		"Use on Focus",
		"Usage: [@focus]",
		"Type: Target Modifier",
		"Function: Use macro action on focus target",
	},{
		"Use on Pet",
		"Usage: [@pet]",
		"Type: Target Modifier",
		"Function: Use macro action on your pet",
	},{
		"Use on Mouseover",
		"Usage: [@mouseover]",
		"Type: Target Modifier",
		"Function: Use macro action on unit or nameplate under cursor",
	},{
		"Use at Cursor",
		"Usage: [@cursor]",
		"Type: Target Modifier",
		"Function: Use macro action on the ground at the cursor location",
	},{
		"Action Icon",
		"Action Name",
		"Custom Argument",
		"Place a spell, item, mount, or pet icon into the socket",
	},{
		"Text Box",
		"Custom Text",
		"Custom Argument",
		"Enter custom macro arguments",
	},{
		"Show",
		"Usage: #show",
		"Type: Utility",
		"Function: Dynamically changes macro icon based on condtions",
	},{
		"Show Tooltip",
		"Usage: #showtooltip",
		"Type: Utility",
		"Function: Dynamically changes macro icon and action tooltip based on condtions",
	},{
		"New Line",
		"Usage: '\\n'",
		"Type: Utility",
		"Function: Creates a new line",
	},{
		"Else",
		"Usage: ';'",
		"Type: Utility",
		"Function: Separates condition statements, the first true statement will be used",
	},{
		"No",
		"Usage: 'no'",
		"Type: Logic / Condition Modifier",
		"Function: Modified condition returns true if NOT true",
	},{
		"And",
		"Usage: ', '",
		"Type: Logic / Condition Modifier",
		"Function: Joins adjacent condition blocks. Modified conditions return true if BOTH are true",
	},{
		"True",
		"Usage: '[]'",
		"Type: Logic / Condition Modifier",
		"Function: Always returns true",
	},
}

mb.AdvancedBlocks = {

}