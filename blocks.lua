local addon, mb = ...

mb.ClassColors = {
	["HUNTER"] = { -- HUNTER
		["hex"] = "ffa9d271",
		["rgb"] = { 0.6666651964187622, 0.8274491429328918, 0.447057843208313 },
	},
	["WARRIOR"] = { -- WARRIOR
		["hex"] = "ffc59a6c",
		["rgb"] = { 0.7764688730239868, 0.6078417897224426, 0.427450031042099 },
	},
	["Social"] = { -- SHAMAN
		["hex"] = "ff006fdc",
		["rgb"] = { 0,  0.4392147064208984, 0.8666647672653198 },
	},
	["MAGE"] = { -- MAGE
		["hex"] = "ff3ec6ea",
		["rgb"] = { 0.2470582872629166,  0.7803904414176941, 0.9215666055679321 },
	},
	["PRIEST"] = { -- PRIEST
		["hex"] = "fffefefe",
		["rgb"] = { 0.9999977946281433,  0.9999977946281433, 0.9999977946281433 },
	},
	["PALADIN"] = { -- PALADIN
		["hex"] = "fff38bb9",
		["rgb"] = { 0.9568606615066528,  0.549018383026123, 0.7294101715087891 },
	},
	["Command"] = { -- WARLOCK
		["hex"] = "ff8687ed",
		["rgb"] = { 0.5294106006622314, 0.5333321690559387, 0.933331310749054 },
	},
	["Smart"] = { -- DEMONHUNTER
		["hex"] = "ffa22fc8",
		["rgb"] = { 0.639214277267456,  0.188234880566597, 0.7882335782051086 },
	},
	["DEATHKNIGHT"] = { -- DEATHKNIGHT
		["hex"] = "ffc31d39",
		["rgb"] = { 0.7686257362365723,  0.117646798491478, 0.2274504750967026 },
	},
	["User"] = { -- DRUID
		["hex"] = "fffe7b09",
		["rgb"] = { 0.9999977946281433, 0.4862734377384186, 0.03921560198068619 },
	},
	["Condition"] = { -- MONK
		["hex"] = "ff00fe97",
		["rgb"] = { 0, 0.9999977946281433, 0.5960771441459656 },
	},
	["Utility"] = { -- ROGUE
		["hex"] = "fffef367",
		["rgb"] = { 0.9999977946281433, 0.9568606615066528, 0.4078422486782074 },
	},
}

mb.BasicBlocks = {
	["Utility"] = {
		{	["name"] = "#showtooltip",
			["payload"] = "#showtooltip\n",
			["func"] = "NEW_LINE",
		},
		{	["name"] = "#show",
			["payload"] = "#show\n",
			["func"] = "NEW_LINE",
		},
		{	["name"] = "⮐",
			["payload"] = "\n",
			["symbol"] = true,
			["func"] = "NEW_LINE",
		},
		{	["name"] = ";",
			["payload"] = ";",
		},
	},
	["Command"] = {
		{	["name"] = "/use",
			["payload"] = "/use",
		},
		{	["name"] = "/cast",
			["payload"] = "/cast",
		},
		{	["name"] = "/target",
			["payload"] = "/tar",
		},
		{	["name"] = "/cleartarget",
			["payload"] = "/cleartarget",
		},
		{	["name"] = "/targetlasttarget",
			["payload"] = "/targetlasttarget",
		},
		{	["name"] = "/focus",
			["payload"] = "/focus",
		},
		{	["name"] = "/clearfocus",
			["payload"] = "/clearfocus",
		},
		{	["name"] = "/assist",
			["payload"] = "/a",
		},
		{	["name"] = "/equip",
			["payload"] = "/eq",
		},
		{	["name"] = "/equipset",
			["payload"] = "/equipset",
		},
		{	["name"] = "/equipslot",
			["payload"] = "/equipslot",
		},
		{	["name"] = "/click",
			["payload"] = "/click",
		},
		{	["name"] = "/golfclap",
			["payload"] = "/golfclap",
		},
		{	["name"] = "/summonpet",
			["payload"] = "/sp"
		},
	},
	["Condition"] = {
		{	["name"] = "mod",
			["payload"] = "[mod]",
			["func"] = "MOD_CONDITION",
			["template"] = "ModBlockTemplate"
		},
		{	["name"] = "combat",
			["payload"] = "[combat]",
		},
		{	["name"] = "exists",
			["payload"] = "[exists]",
		},
		{	["name"] = "help",
			["payload"] = "[help]",
		},
		{	["name"] = "harm",
			["payload"] = "[harm]",
		},
		{	["name"] = "dead",
			["payload"] = "[dead]",
		},
		{	["name"] = "@mouseover",
			["payload"] = "[@mouseover]",
		},
		{	["name"] = "@cursor",
			["payload"] = "[@cursor]",
		},
		{	["name"] = "@focus",
			["payload"] = "[@focus]",
		},
	},
	["Social"] = {
		{	["name"] = "AaBbCc",
			["payload"] = "AaBbCc",
		},
	},
	["User"] = {
		{	["name"] = "socket",
			["payload"] = "",
			["func"] = "USER_SOCKET",
			["template"] = "SocketBlockTemplate"
		},
		{	["name"] = "custom input",
			["payload"] = "",
			["func"] = "USER_EDIT",
			["template"] = "EditBlockTemplate"
		},
	},
	["Smart"] = {
		{	["name"] = "no",
			-- ["payload"] = "no",
			["func"] = "NO_CONDITION",
			["smart"] = {
				["palette"] = true,
				["group"] = "Condition",
				["hookPayload"] = { 2, "no" },
				["orphan"] = false,
			}
		}
	}
}

mb.AdvancedBlocks = {
    
}