local addon, mb = ...
mb.SlashCommandList = {
	["BATTLEPET"] = {
		["/randomfavoritepet"] = {
			"/rfp",
			"/randomfavoritepet",
		},
		["/summonpet"] = {
			"/sp",
			"/summonpet",
		},
		["/dismisspet"] = {
			"/dismisspet",
		},
	},
	["INTERFACE"] = {
		["/achievements"] = {
			"/ach",
			"/achieve",
			"/achievement",
			"/achievements",				
		},
		["/calendar"] = {
			["payload"] = "/calendar",
		},
		["/dungeonfinder"] = {
			"/dungeonfinder",
			"/lfd",
			"/df",
		},
		["/guildfinder"] = {
			"/guildfinder",
			"/gf",
		},
		["/loot"] = {
			"/lootrolls",
			"/loot",
		},
		["/macrohelp"] = {
			"/macrohelp",
		},
		["/macro"] = {
			"/macro",
			"/m",
		},
		["/raidfinder"] = {
			"/raidfinder",
			"/rf",
			"/lfr",
		},
		["/share"] = {
			"/share",
		},
		["/stopwatch"] = {
			"/stopwatch",
			"/timer",
			"/sw",
		},
		["/who"] = {
			"/who",
		},
	},
	["CHAT"] = {
		["/afk"] = {
			"/afk",
			"/away",
		},
		["/announce"] = {
			"/announce",
			"/ann",
		},
		["/ban"] = {
			"/ban",
		},
		["/chat"] = {
			"/chat",
			"/chathelp",
		},
	--[[["/c"] = {
			"/c",
			"/csay",
		},]]
		["/chatlist"] = {
			"/chatlist",
			"/chatwho",
			"/chatinfo",
		},
		["/chatlog"] = {
			"/chatlog",
		},
		["/cinvite"] = {
			"/cinvite",
			"/chatinvite",
		},
		["/ckick"] = {
			"/ckick",
		},
		["/dnd"] = {
			"/dnd",
			"/busy",
		},
		["/emote"] = {
			"/emote",
			"/me",
			"/em",
			"/e",
		},
		["/guild"] = {
			"/gc",
			"/g",
			"/guild",
			"/gu",
		},
		["/instance"] = {
			"/instance",
			"/battleground",
			"/i",
			"/bg",
			"/instance_chat",
		},
		["/join"] = {
			"/join",
			"/channel",
			"/chan",
		},
		["/leave"] = {
			"/leave",
			"/chatleave",
			"/chatexit",
		},
		["/moderator"] = {
			"/moderator",
			"/mod",
		},
		["/mute"] = {
			"/unvoice",
			"/squelch",
			"/mute",
		},
		["/officer"] = {
			"/osay",
			"/o",
			"/officer",
		},
		["/owner"] = {
			"/owner",
		},
		["/party"] = {
			"/party",
			"/p",
		},
		["/password"] = {
			"/password",
			"/pass",
		},
		["/raid"] = {
			"/rsay",
			"/raid",
			"/ra",
		},
		["/random"] = {
			"/rand",
			"/roll",
			"/rnd",
			"/random",
		},
		["/reply"] = {
			"/r",
			"/reply",
		},
		["/resetchat"] = {
			"/resetchat",
		},
		["/rw"] = {
			"/rw",
		},
		["/say"] = {
			"/s",
			"/say",
		},
		["/unban"] = {
			"/unban",
		},
		["/unmoderator"] = {
			"/unmoderator",
			"/unmod",
		},
		["/unmute"] = {
			"/voice",
			"/unsquelch",
			"/unmute",
		},
		["/whisper"] = {
			"/w",
			"/t",
			"/whisper",
			"/tell",
			"/send",
		},
		["/yell"] = {
			"/shout",
			"/y",
			"/yell",
			"/sh",
		},
	},
	["CHARACTER"] = {
		["/dismount"] = {
			"/dismount",
		},
		["/equip"] = {
			"/eq",
			"/equip",
		},
		["/equipset"] = {
			"/equipset",
		},
		["/equipslot"] = {
			"/equipslot",
		},
		["/friends"] = {
			"/friends",
			"/friend",
		},
		["/follow"] = {
			"/fol",
			"/f",
			"/follow",
		},
		["/ignore"] = {
			"/ignore",
		},
		["/inspect"] = {
			"/inspect",
			"/ins",
		},
		["/leavevehicle"] = {
			"/leavevehicle",
		},
		["/randompet"] = {
			"/randompet",
		},
		["/removefriend"] = {
			"/removefriend",
			"/remfriend",
		},
		["/settitle"] = {
			"/settitle",
		},
		["/trade"] = {
			"/tr",
			"/trade",
		},
		["/unignore"] = {
			"/unignore",
		},
		["/usetalents"] = {
			"/usetalents",
		},
	},
	["DEV"] = {
		["/api"] = {
			"/api",
		},
		["/dump"] = {
			"/dump",
		},
		["/eventtrace"] = {
			"/eventtrace",
			"/etrace",
		},
		["/framestack"] = {
			"/fstack",
			"/framestack",
		},
		["/tableinspect"] = {
			"/tinspect",
			"/tableinspect",
		},
	},
	["EMOTE"] = {
		"/absent", "/agree", "/amaze", "/angry", "/apologize", "/applaud", "/arm", "/attackmytarget", "/awe", "/backpack", "/badfeeling", "/bark", "/bashful", "/beckon", "/beg", "/bite", "/blame", "/blank", "/bleed", "/blink", "/blush", "/boggle", "/bonk", "/boop", "/bored", "/bounce", "/bow", "/brandish", "/brb", "/breath", "/burp", "/bye", "/cackle", "/calm", "/challenge", "/charge", "/charm", "/cheer", "/chicken", "/chuckle", "/chug", "/clap", "/cold", "/comfort", "/commend", "/confused", "/congratulate", "/cough", "/coverears", "/cower", "/crack", "/cringe", "/crossarms", "/cry", "/cuddle", "/curious", "/curtsey", "/dance", "/ding", "/disagree", "/doubt", "/drink", "/drool", "/duck", "/eat", "/embarrass", "/encourage", "/enemy", "/eye", "/eyebrow", "/facepalm", "/faint", "/fart", "/fidget", "/flee", "/flee", "/flex", "/flirt", "/flop", "/follow", "/forthealliance", "/forthehorde", "/frown", "/gasp", "/gaze", "/giggle", "/glare", "/gloat", "/glower", "/go", "/going", "/golfclap", "/greet", "/grin", "/groan", "/grovel", "/growl", "/guffaw", "/hail", "/happy", "/headache", "/healme", "/hello", "/helpme", "/hiccup", "/highfive", "/hiss", "/holdhand", "/hug", "/hungry", "/hurry", "/idea", "/incoming", "/incoming", "/insult", "/introduce", "/jealous", "/jk", "/joke", "/kiss", "/kneel", "/laugh", "/laydown", "/lick", "/listen", "/look", "/lost", "/love", "/luck", "/map", "/massage", "/meow", "/mercy", "/moan", "/mock", "/moo", "/moon", "/mountspecial", "/mourn", "/mutter", "/nervous", "/no", "/nod", "/nosepick", "/object", "/offer", "/oom", "/oops", "/openfire", "/panic", "/pat", "/peer", "/pet", "/pinch", "/pity", "/plead", "/point", "/poke", "/ponder", "/pounce", "/pout", "/praise", "/pray", "/promise", "/proud", "/pulse", "/punch", "/purr", "/puzzle", "/raise", "/rasp", "/read", "/ready", "/regret", "/revenge", "/roar", "/rofl", "/rolleyes", "/rude", "/ruffle", "/sad", "/salute", "/scared", "/scoff", "/scold", "/scowl", "/scratch", "/search", "/sexy", "/shake", "/shakefist", "/shifty", "/shimmy", "/shiver", "/shoo", "/shout", "/shrug", "/shudder", "/shy", "/sigh", "/signal", "/silence", "/sing", "/sit", "/slap", "/sleep", "/smack", "/smile", "/smirk", "/snap", "/snarl", "/sneak", "/sneeze", "/snicker", "/sniff", "/snort", "/snub", "/soothe", "/spit", "/squeal", "/stand", "/stare", "/stink", "/surprised", "/surrender", "/suspicious", "/sweat", "/talk", "/talkex", "/talkq", "/tap", "/taunt", "/tease", "/thank", "/think", "/thirsty", "/threaten", "/tickle", "/tired", "/train", "/truce", "/twiddle", "/unused", "/veto", "/victory", "/violin", "/wait", "/warn", "/wave", "/welcome", "/whine", "/whistle", "/whoa", "/wink", "/work", "/yawn", "/yw",
	},
	["COMBAT"] = {
		["/cancelaura"] = {
			"/cancelaura",
		},
		["/cancelqueuedspell"] = {
			"/cancelqueuedspell",
			"/cqs",
		},
		["/cancelform"] = {
			"/cancelform",
		},
		["/cast"] = {
			"/cast",
			"/spell",
		},
		["/castrandom"] = {
			"/castrandom",
		},
		["/castsequence"] = {
			"/castsequence",
		},
		["/changeactionbar"] = {
			"/changeactionbar",
		},
		["/startattack"] = {
			"/startattack",
		},
		["/stopattack"] = {
			"/stopattack",
		},
		["/stopcasting"] = {
			"/stopcasting",
		},
		["/stopspelltarget"] = {
			"/stopspelltarget",
		},
		["/swapactionbar"] = {
			"/swapactionbar",
		},
		["/use"] = {
			"/use",
		},
		["/usetoy"] = {
			"/usetoy",
		},
		["/userandom"] = {
			"/userandom",
		},
	},
	["GUILD"] = {
		["/guilddisband"] = {
			"/guilddisband",
			"/gdisband",
		},
		["/guilddemote"] = {
			"/guilddemote",
			"/gdemote",
		},
		["/guildinfo"] = {
			"/guildinfo",
			"/ginfo",
		},
		["/guildinvite"] = {
			"/ginvite",
			"/guildinvite",
		},
		["/guildleader"] = {
			"/gleader",
			"/guildleader",
		},
		["/glist"] = {
			"/whoguild",
			"/gwho",
			"/glist",
		},
		["/guildmotd"] = {
			"/gmotd",
			"/guildmotd",
		},
		["/guildpromote"] = {
			"/gpromote",
			"/guildpromote",
		},
		["/guildquit"] = {
			"/gquit",
			"/guildquit",
		},
		["/guildremove"] = {
			"/gremove",
			"/guildremove",
		},
		["/guildroster"] = {
			"/groster",
			"/guildroster",
		},
	},
	["PARTY_RAID"] = {
		["/clearworldmarker"] = {
			"/clearworldmarker",
			"/cwm",
		},
		["/clearmaintank"] = {
			"/clearmt",
			"/clearmaintank",
		},
		["/ffa"] = {
			"/ffa",
		},
		["/group"] = {
			"/group",
		},
		["/invite"] = {
			"/inv",
			"/invite",
		},
		["/maintankoff"] = {
			"/mtoff",
			"/maintankoff",
		},
		["/clearmainassist"] = {
			"/clearma",
			"/clearmainassist",
		},
		["/mainassistoff"] = {
			"/maoff",
			"/mainassistoff",
		},
		["/mainassist"] = {
			"/ma",
			"/mainassist",
		},
		["/master"] = {
			"/master",
		},
		["/maintank"] = {
			"/mt",
			"/maintank",
		},
		["/promote"] = {
			"/promote",
			"/pr",
		},
		["/raidinfo"] = {
			"/raidinfo",
		},
		["/readycheck"] = {
			"/readycheck",
		},
		["/requestinvite"] = {
			"/requestinvite",
		},
		["/targetmarker"] = {
			"/tm",
			"/targetmarker",
		},
		["/threshold"] = {
			"/threshold",
		},
		["/uninvite"] = {
			"/votekick",
			"/u",
			"/uninvite",
			"/kick",
			"/un",
		},
		["/worldmarker"] = {
			"/wm",
			"/worldmarker",
		},
	},
	["PET"] = {
		["/petaggressive"] = {
			"/petaggressive",
		},
		["/petassist"] = {
			"/petassist",
		},
		["/petattack"] = {
			"/petattack",
		},
		["/petautocastoff"] = {
			"/petautocastoff",
		},
		["/petautocaston"] = {
			"/petautocaston",
		},
		["/petautocasttoggle"] = {
			"/petautocasttoggle",
		},
		["/petdefensive"] = {
			"/petdefensive",
		},
		["/petdismiss"] = {
			"/petdismiss",
		},
		["/petfollow"] = {
			"/petfollow",
		},
		["/petmoveto"] = {
			"/petmoveto",
		},
		["/petpassive"] = {
			"/petpassive",
		},
		["/petstay"] = {
			"/petstay",
		},
	},
	["PVP"] = {
		["/duel"] = {
			"/duel",
		},
		["/pvp"] = {
			"/pvp",
		},
		["/wargame"] = {
			"/wg",
			"/wargame",
		},
		["/yield"] = {
			"/yield",
			"/forfeit",
			"/concede",
		},
	},
	["SYSTEM"] = {
		["/click"] = {
			"/click",
		},
		["/combatlog"] = {
			"/combatlog",
		},
		["/console"] = {
			"/console",
		},
		["/countdown"] = {
			"/countdown",
		},
		["/disableaddons"] = {
			"/disableaddons",
		},
		["/enableaddons"] = {
			"/enableaddons",
		},
		["/help"] = {
			"/help",
			"/h",
			"/?",
		},
		["/logout"] = {
			"/logout",
			"/camp",
		},
		["/played"] = {
			"/played",
		},
		["/quit"] = {
			"/quit",
			"/exit",
		},
		["/reload"] = {
			"/reload",
		},
		["/script"] = {
			"/script",
			"/run",
		},
		["/stopmacro"] = {
			"/stopmacro",
		},
		["/time"] = {
			"/time",
		},
		["/timetest"] = {
			"/timetest",
		},
		["/tts"] = {
			"/tts",
		},
		["/voice"] = {
			"/voice",
		},
	},
	["TARGETING"] = {
		["/assist"] = {
			"/a",
			"/assist",
		},
		["/focus"] = {
			"/focus",
		},
		["/clearfocus"] = {
			"/clearfocus",
		},
		["/target"] = {
			"/target",
			"/tar",
		},
		["/cleartarget"] = {
			"/cleartarget",
		},
		["/targetenemy"] = {
			"/targetenemy",
		},
		["/targetenemyplayer"] = {
			"/targetenemyplayer",
		},
		["/targetexact"] = {
			"/targetexact",
		},
		["/targetfriend"] = {
			"/targetfriend",
		},
		["/targetfriendplayer"] = {
			"/targetfriendplayer",
		},
		["/targetlastenemy"] = {
			"/targetlastenemy",
		},
		["/targetlastfriend"] = {
			"/targetlastfriend",
		},
		["/targetlasttarget"] = {
			"/targetlasttarget",
		},
		["/targetparty"] = {
			"/targetparty",
		},
		["/targetraid"] = {
			"/targetraid",
		},
	},
	["UNKNOWN"] = {
		["/resetcommentatorsettings"] = {
			"/resetcommentatorsettings",
		},
		["/assignplayer"] = {
			"/ap",
			"/assignplayer",
		},
		["/invitespectatormatch"] = {
			"/invitespectatormatch",
		},
		["/community"] = {
			"/community",
		},
		["/cw"] = {
			"/cw",
			"/charwhisper",
		},
		["/vt"] = {
			"/vt",
		},
		["/overridename"] = {
			"/overridename",
			"/on",
		},
	}
}

-- obselete ( or classic ) commands = {
--[[["/saveguildroster"] = {
		"/saveguildroster",
	},
	"/guildhelp"] = {
		"/ghelp",
		"/guildhelp",
	},
	["/token"] = {
		"/tk",
		"/token",
	},
	["/greplace"] = {
		"/greplace",
	},
	["/needbeforegreed"] = {
		"/needbeforegreed",
	},
	["/teaminvite"] = {
		"/teaminvite",
		"/tinvite",
	},
	["/castglyph"] = {
		"/castglyph",
	},
	["/gv"] = {
		"/gv",
	},
	["/teamremove"] = {
		"/teamremove",
		"/tremove",
	},
	["/teamcaptain"] = {
		"/teamcaptain",
		"/tcaptain",
	},
	["/clear"] = {
		"/clear",
	},
	["/moderate"] = {
		"/moderate",
	},
	["/teamquit"] = {
		"/teamquit",
		"/tquit",
	},
	["/roundrobin"] = {
		"/roundrobin",
	},
	["/pv"] = {
		"/pv",
	},
	["/cv"] = {
		"/cv",
	},
	["/teamdisband"] = {
		"/teamdisband",
		"/tdisband",
	},
	["/v"] = {
		"/v",
	},
	["/raidbrowser"] = {
		"/rb",
		"/or",
		"/raidbrowser",
		"/otherraids",
	},
	["/nameteam"] = {
		"/nt",
		"/nameteam",
	},]]
--}