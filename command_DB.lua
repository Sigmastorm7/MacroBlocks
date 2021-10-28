local addon, mb = ...
mb.SlashCommandList = {
	["BATTLEPET"] = {
		["/randomfavoritepet"] = "/rfp",
		["/summonpet"] = "/sp",
		["/dismisspet"] = "/dismisspet",
	},
	["INTERFACE"] = {
		["/achievements"] = "/ach",
		["/calendar"] = "/calendar",
		["/dungeonfinder"] = "/df",
		["/guildfinder"] = "/gf",
		["/lootrolls"] = "/loot",
		["/macrohelp"] = "/macrohelp",
		["/macro"] = "/m",
		["/raidfinder"] = "/rf",
		["/share"] = "/share",
		["/stopwatch"] = "/sw",
		["/who"] = "/who",
	},
	["CHAT"] = {
		["/away"] = "/afk",
		["/announce"] = "/ann",
		["/ban"] = "/ban",
		["/chathelp"] = "/chat",
	--[[["/c"] = { -- is this some kind of escape sequence for chat commands?
			"/c",
			"/csay",
		},]]
		["/chatlist"] = "/chatwho",
		["/chatlog"] = "/chatlog",
		["/chatinvite"] = "/cinvite",
		["/ckick"] = "/ckick",
		["/busy"] = "/dnd",
		["/emote"] = "/e",
		["/guild"] = "/g",
		["/instance_chat"] = "/i",
		["/channel"] = "/join",
		["/chatleave"] = "/leave",
		["/moderator"] = "/mod",
		["/mute"] = "/mute",
		["/officer"] = "/o",
		["/owner"] = "/owner",
		["/party"] = "/p",
		["/password"] = "/pass",
		["/raid"] = "/ra",
		["/random"] = "/rnd",
		["/reply"] = "/r",
		["/resetchat"] = "/resetchat",
		["/rw"] = "/rw",
		["/say"] = "/s",
		["/unban"] = "/unban",
		["/unmoderator"] = "/unmod",
		["/unmute"] = "/voice",
		["/whisper"] = "/w",
		["/yell"] = "/y",
	},
	["CHARACTER"] = {
		["/dismount"] = "/dismount",
		["/equip"] = "/eq",
		["/equipset"] = "/equipset",
		["/equipslot"] = "/equipslot",
		["/friends"] = "/friend",
		["/follow"] = "/f",
		["/ignore"] = "/ignore",
		["/inspect"] = "/ins",
		["/leavevehicle"] = "/leavevehicle",
		["/randompet"] = "/randompet",
		["/removefriend"] = "/remfriend",
		["/settitle"] = "/settitle",
		["/trade"] = "/tr",
		["/unignore"] = "/unignore",
		["/usetalents"] = "/usetalents",
	},
	["DEV"] = {
		["/api"] = "/api",
		["/dump"] = "/dump",
		["/eventtrace"] = "/etrace",
		["/framestack"] = "/fstack",
		["/tableinspect"] = "/tinspect",
	},
	["EMOTE"] = {
		"/absent", "/agree", "/amaze", "/angry", "/apologize", "/applaud", "/arm", "/attackmytarget", "/awe", "/backpack", "/badfeeling", "/bark", "/bashful", "/beckon", "/beg", "/bite", "/blame", "/blank", "/bleed", "/blink", "/blush", "/boggle", "/bonk", "/boop", "/bored", "/bounce", "/bow", "/brandish", "/brb", "/breath", "/burp", "/bye", "/cackle", "/calm", "/challenge", "/charge", "/charm", "/cheer", "/chicken", "/chuckle", "/chug", "/clap", "/cold", "/comfort", "/commend", "/confused", "/congratulate", "/cough", "/coverears", "/cower", "/crack", "/cringe", "/crossarms", "/cry", "/cuddle", "/curious", "/curtsey", "/dance", "/ding", "/disagree", "/doubt", "/drink", "/drool", "/duck", "/eat", "/embarrass", "/encourage", "/enemy", "/eye", "/eyebrow", "/facepalm", "/faint", "/fart", "/fidget", "/flee", "/flee", "/flex", "/flirt", "/flop", "/follow", "/forthealliance", "/forthehorde", "/frown", "/gasp", "/gaze", "/giggle", "/glare", "/gloat", "/glower", "/go", "/going", "/golfclap", "/greet", "/grin", "/groan", "/grovel", "/growl", "/guffaw", "/hail", "/happy", "/headache", "/healme", "/hello", "/helpme", "/hiccup", "/highfive", "/hiss", "/holdhand", "/hug", "/hungry", "/hurry", "/idea", "/incoming", "/incoming", "/insult", "/introduce", "/jealous", "/jk", "/joke", "/kiss", "/kneel", "/laugh", "/laydown", "/lick", "/listen", "/look", "/lost", "/love", "/luck", "/map", "/massage", "/meow", "/mercy", "/moan", "/mock", "/moo", "/moon", "/mountspecial", "/mourn", "/mutter", "/nervous", "/no", "/nod", "/nosepick", "/object", "/offer", "/oom", "/oops", "/openfire", "/panic", "/pat", "/peer", "/pet", "/pinch", "/pity", "/plead", "/point", "/poke", "/ponder", "/pounce", "/pout", "/praise", "/pray", "/promise", "/proud", "/pulse", "/punch", "/purr", "/puzzle", "/raise", "/rasp", "/read", "/ready", "/regret", "/revenge", "/roar", "/rofl", "/rolleyes", "/rude", "/ruffle", "/sad", "/salute", "/scared", "/scoff", "/scold", "/scowl", "/scratch", "/search", "/sexy", "/shake", "/shakefist", "/shifty", "/shimmy", "/shiver", "/shoo", "/shout", "/shrug", "/shudder", "/shy", "/sigh", "/signal", "/silence", "/sing", "/sit", "/slap", "/sleep", "/smack", "/smile", "/smirk", "/snap", "/snarl", "/sneak", "/sneeze", "/snicker", "/sniff", "/snort", "/snub", "/soothe", "/spit", "/squeal", "/stand", "/stare", "/stink", "/surprised", "/surrender", "/suspicious", "/sweat", "/talk", "/talkex", "/talkq", "/tap", "/taunt", "/tease", "/thank", "/think", "/thirsty", "/threaten", "/tickle", "/tired", "/train", "/truce", "/twiddle", "/unused", "/veto", "/victory", "/violin", "/wait", "/warn", "/wave", "/welcome", "/whine", "/whistle", "/whoa", "/wink", "/work", "/yawn", "/yw",
	},
	["COMBAT"] = {
		["/cancelaura"] = "/cancelaura",
		["/cancelqueuedspell"] = "/cqs",
		["/cancelform"] = "/cancelform",
		["/cast"] = "/cast",
		["/castrandom"] = "/castrandom",
		["/castsequence"] = "/castsequence",
		["/changeactionbar"] = "/changeactionbar",
		["/startattack"] = "/startattack",
		["/stopattack"] = "/stopattack",
		["/stopcasting"] = "/stopcasting",
		["/stopspelltarget"] = "/stopspelltarget",
		["/swapactionbar"] = "/swapactionbar",
		["/use"] = "/use",
		["/usetoy"] = "/usetoy",
		["/userandom"] = "/userandom",
	},
	["GUILD"] = {
		["/guilddisband"] = "/gdisband",
		["/guilddemote"] = "/gdemote",
		["/guildinfo"] = "/ginfo",
		["/guildinvite"] = "/ginvite",
		["/guildleader"] = "/gleader",
		["/glist"] = "/gwho",
		["/guildmotd"] = "/gmotd",
		["/guildpromote"] = "/gpromote",
		["/guildquit"] = "/gquit",
		["/guildremove"] = "/gremove",
		["/guildroster"] = "/groster",
	},
	["PARTY_RAID"] = {
		["/clearworldmarker"] = "/cwm",
		["/clearmaintank"] = "/clearmt",
		["/ffa"] = "/ffa",
		["/group"] = "/group",
		["/invite"] = "/inv",
		["/maintankoff"] = "/mtoff",
		["/clearmainassist"] = "/clearma",
		["/mainassistoff"] = "/maoff",
		["/mainassist"] = "/ma",
		["/master"] = "/master",
		["/maintank"] = "/mt",
		["/promote"] = "/pr",
		["/raidinfo"] = "/raidinfo",
		["/readycheck"] = "/readycheck",
		["/requestinvite"] = "/requestinvite",
		["/targetmarker"] = "/tm",
		["/threshold"] = "/threshold",
		["/uninvite"] = "/u",
		["/worldmarker"] = "/wm",
	},
	["PET"] = {
		["/petaggressive"] = "/petaggressive",
		["/petassist"] = "/petassist",
		["/petattack"] = "/petattack",
		["/petautocastoff"] = "/petautocastoff",
		["/petautocaston"] = "/petautocaston",
		["/petautocasttoggle"] = "/petautocasttoggle",
		["/petdefensive"] = "/petdefensive",
		["/petdismiss"] = "/petdismiss",
		["/petfollow"] = "/petfollow",
		["/petmoveto"] = "/petmoveto",
		["/petpassive"] = "/petpassive",
		["/petstay"] = "/petstay",
	},
	["PVP"] = {
		["/duel"] = "/duel",
		["/pvp"] = "/pvp",
		["/wargame"] = "/wg",
		["/yield"] = "/yield",
	},
	["SYSTEM"] = {
		["/click"] = "/click",
		["/combatlog"] = "/combatlog",
		["/console"] = "/console",
		["/countdown"] = "/countdown",
		["/disableaddons"] = "/disableaddons",
		["/enableaddons"] = "/enableaddons",
		["/help"] = "/h",
		["/logout"] = "/camp",
		["/played"] = "/played",
		["/quit"] = "/quit",
		["/reload"] = "/reload",
		["/script"] = "/run",
		["/stopmacro"] = "/stopmacro",
		["/time"] = "/time",
		["/timetest"] = "/timetest",
		["/tts"] = "/tts",
		["/voice"] = "/voice",
	},
	["TARGETING"] = {
		["/assist"] = "/a",
		["/focus"] = "/focus",
		["/clearfocus"] = "/clearfocus",
		["/target"] = "/tar",
		["/cleartarget"] = "/cleartarget",
		["/targetenemy"] = "/targetenemy",
		["/targetenemyplayer"] = "/targetenemyplayer",
		["/targetexact"] = "/targetexact",
		["/targetfriend"] = "/targetfriend",
		["/targetfriendplayer"] = "/targetfriendplayer",
		["/targetlastenemy"] = "/targetlastenemy",
		["/targetlastfriend"] = "/targetlastfriend",
		["/targetlasttarget"] = "/targetlasttarget",
		["/targetparty"] = "/targetparty",
		["/targetraid"] = "/targetraid",
	},
	["UNKNOWN"] = {
		["/resetcommentatorsettings"] = "/resetcommentatorsettings",
		["/assignplayer"] = "/ap",
		["/invitespectatormatch"] = "/invitespectatormatch",
		["/community"] = "/community",
		["/charwhisper"] = "/cw",
		["/vt"] = "/vt",
		["/overridename"] = "/on",
	}
}

--[[commands = { -- obselete or for classic
	["/saveguildroster"] = "/saveguildroster",
	["/guildhelp"] = "/ghelp",
	["/token"] = "/tk",
	["/greplace"] = "/greplace",
	["/needbeforegreed"] = "/needbeforegreed",
	["/teaminvite"] = "/tinvite",
	["/castglyph"] = "/castglyph",
	["/gv"] = "/gv",
	["/teamremove"] = "/tremove",
	["/teamcaptain"] = "/tcaptain",
	["/clear"] = "/clear",
	["/moderate"] = "/moderate",
	["/teamquit"] = "/tquit",
	["/roundrobin"] = "/roundrobin",
	["/pv"] = "/pv",
	["/cv"] = "/cv",
	["/teamdisband"] = "/tdisband",
	["/v"] = "/v",
	["/raidbrowser"] = "/rb",
	["/nameteam"] = "/nt",
}]]