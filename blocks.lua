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
	["SHAMAN"] = { -- SHAMAN
		["hex"] = "ff006fdc",
		["rgb"] = { 0,  0.4392147064208984, 0.8666647672653198 },
	},
	["Command"] = { -- MAGE
		["hex"] = "ff3ec6ea",
		["rgb"] = { 0.2470582872629166,  0.7803904414176941, 0.9215666055679321 },
	},
	["PRIEST"] = { -- PRIEST
		["hex"] = "fffefefe",
		["rgb"] = { 0.9999977946281433,  0.9999977946281433, 0.9999977946281433 },
	},
	["Smart"] = { -- PALADIN
		["hex"] = "fff38bb9",
		["rgb"] = { 0.9568606615066528,  0.549018383026123, 0.7294101715087891 },
	},
	["WARLOCK"] = { -- WARLOCK
		["hex"] = "ff8687ed",
		["rgb"] = { 0.5294106006622314, 0.5333321690559387, 0.933331310749054 },
	},
	["DEMONHUNTER"] = { -- DEMONHUNTER
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
		["UTL1"] = {
			["name"] = "#showtooltip",
			["payload"] = "#showtooltip\n",
			["func"] = "NEW_LINE",
		},
		["UTL2"] = {
			["name"] = "#show",
			["payload"] = "#show\n",
			["func"] = "NEW_LINE",
		},
		["UTL3"] = {
			["name"] = "⮐",
			["payload"] = "\n",
			["symbol"] = true,
			["func"] = "NEW_LINE",
		},
		["UTL4"] = {
			["name"] = ";",
			["payload"] = ";",
		},
	},
	["Command"] = {
		["CMD1"] = {
			["name"] = "/use",
			["payload"] = "/use",
		},
		["CMD2"] = {
			["name"] = "/cast",
			["payload"] = "/cast",
		},
		["CMD3"] = {
			["name"] = "/target",
			["payload"] = "/tar",
		},
		["CMD4"] = {
			["name"] = "/cleartarget",
			["payload"] = "/cleartarget",
		},--[[
		["CMD#"] = {
			["name"] = "/targetlasttarget",
			["payload"] = "/targetlasttarget",
		},]]
		["CMD5"] = {
			["name"] = "/focus",
			["payload"] = "/focus",
		},
		["CMD6"] = {
			["name"] = "/clearfocus",
			["payload"] = "/clearfocus",
		},
		["CMD7"] = {
			["name"] = "/assist",
			["payload"] = "/a",
		},
		["CMD8"] = {
			["name"] = "/equip",
			["payload"] = "/eq",
		},--[[
		["CMD#"] = {
			["name"] = "/equipset",
			["payload"] = "/equipset",
		},
		["CMD#"] = {
			["name"] = "/equipslot",
			["payload"] = "/equipslot",
		},
		["CMD#"] = {
			["name"] = "/click",
			["payload"] = "/click",
		},
		["CMD#"] = {
			["name"] = "/golfclap",
			["payload"] = "/golfclap",
		},]]
		["CMD9"] = {
			["name"] = "/summonpet",
			["payload"] = "/sp"
		},
	},
	["Condition"] = {
		["CON1"] = {
			["name"] = "mod",
			["payload"] = "[mod]",
			["template"] = "ChoiceBlockTemplate",
			["func"] = "USER_CHOICE",
			["choices"] = {
				{ ["name"] = "shift", ["value"] = 1, },
				{ ["name"] = "ctrl", ["value"] = 2, },
				{ ["name"] = "alt", ["value"] = 4, },
			}
		},--[[
		["CON#"] = {
			["name"] = "combat",
			["payload"] = "[combat]",
		},
		["CON#"] = {
			["name"] = "exists",
			["payload"] = "[exists]",
		},]]
		["CON2"] = {
			["name"] = "help",
			["payload"] = "[help]",
		},
		["CON3"] = {
			["name"] = "harm",
			["payload"] = "[harm]",
		},--[[
		["CON#"] = {
			["name"] = "dead",
			["payload"] = "[dead]",
		},]]
		["CON4"] = {
			["name"] = "@mouseover",
			["payload"] = "[@mouseover]",
		},
		["CON5"] = {
			["name"] = "@cursor",
			["payload"] = "[@cursor]",
		},
		["CON6"] = {
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
	["User"] = {
		["USR1"] = {
			["name"] = "socket",
			["payload"] = "",
			["func"] = "USER_SOCKET",
			["template"] = "SocketBlockTemplate"
		},
		["USR2"] = {
			["name"] = "custom input",
			["payload"] = "",
			["func"] = "USER_EDIT",
			["template"] = "EditBlockTemplate"
		},
	},
	["Smart"] = {
		["SMT1"] = {
			["name"] = "no",
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