local addon, mb = ...
mb.SlashCommandList = {
	["BATTLEPET"] = {
		"/dismisspet",
		{ "/randomfavoritepet", "/rfp", },
		{ "/summonpet", "/sp", },
	},
	["INTERFACE"] = {
		["/achievements"] = "/ach",
		"/calendar",
		["/dungeonfinder"] = "/df",
		["/guildfinder"] = "/gf",
		["/lootrolls"] = "/loot",
		["/macrohelp"] = "/macrohelp",
		["/macro"] = "/m",
		["/raidfinder"] = "/rf",
		"/share",
		["/stopwatch"] = "/sw",
		"/who",
	},
	["CHAT"] = {
		["/away"] = "/afk",
		["/announce"] = "/ann",
		"/ban",
		["/chathelp"] = "/chat",
		["/chatlist"] = "/chatwho",
		"/chatlog",
		["/chatinvite"] = "/cinvite",
		"/ckick",
		["/busy"] = "/dnd",
		["/emote"] = "/e",
		["/guild"] = "/g",
		["/instance_chat"] = "/i",
		["/channel"] = "/join",
		["/chatleave"] = "/leave",
		["/moderator"] = "/mod",
		"/mute",
		["/officer"] = "/o",
		"/owner",
		["/party"] = "/p",
		["/password"] = "/pass",
		["/raid"] = "/ra",
		["/random"] = "/rnd",
		["/reply"] = "/r",
		"/resetchat",
		"/rw",
		["/say"] = "/s",
		"/unban",
		["/unmoderator"] = "/unmod",
		["/unmute"] = "/voice",
		["/whisper"] = "/w",
		["/yell"] = "/y",
	},
	["CHARACTER"] = {
		"/dismount",
		["/equip"] = "/eq",
		"/equipset",
		"/equipslot",
		["/friends"] = "/friend",
		["/follow"] = "/f",
		"/ignore",
		["/inspect"] = "/ins",
		"/leavevehicle",
		"/randompet",
		["/removefriend"] = "/remfriend",
		"/settitle",
		["/trade"] = "/tr",
		"/unignore",
		"/usetalents",
	},
	["DEV"] = {
		"/api",
		"/dump",
		["/eventtrace"] = "/etrace",
		["/framestack"] = "/fstack",
		["/tableinspect"] = "/tinspect",
	},
	["EMOTE"] = {
		"/absent", "/agree", "/amaze", "/angry", "/apologize", "/applaud", "/arm", "/attackmytarget", "/awe", "/backpack", "/badfeeling", "/bark", "/bashful", "/beckon", "/beg", "/bite", "/blame", "/blank", "/bleed", "/blink", "/blush", "/boggle", "/bonk", "/boop", "/bored", "/bounce", "/bow", "/brandish", "/brb", "/breath", "/burp", "/bye", "/cackle", "/calm", "/challenge", "/charge", "/charm", "/cheer", "/chicken", "/chuckle", "/chug", "/clap", "/cold", "/comfort", "/commend", "/confused", "/congratulate", "/cough", "/coverears", "/cower", "/crack", "/cringe", "/crossarms", "/cry", "/cuddle", "/curious", "/curtsey", "/dance", "/ding", "/disagree", "/doubt", "/drink", "/drool", "/duck", "/eat", "/embarrass", "/encourage", "/enemy", "/eye", "/eyebrow", "/facepalm", "/faint", "/fart", "/fidget", "/flee", "/flee", "/flex", "/flirt", "/flop", "/follow", "/forthealliance", "/forthehorde", "/frown", "/gasp", "/gaze", "/giggle", "/glare", "/gloat", "/glower", "/go", "/going", "/golfclap", "/greet", "/grin", "/groan", "/grovel", "/growl", "/guffaw", "/hail", "/happy", "/headache", "/healme", "/hello", "/helpme", "/hiccup", "/highfive", "/hiss", "/holdhand", "/hug", "/hungry", "/hurry", "/huzzah", "/idea", "/impressed", "/incoming", "/incoming", "/insult", "/introduce", "/jealous", "/jk", "/joke", "/kiss", "/kneel", "/laugh", "/laydown", "/lick", "/listen", "/look", "/lost", "/love", "/luck", "/magnificent", "/map", "/massage", "/meow", "/mercy", "/mock", "/moo", "/moon", "/mountspecial", "/mourn", "/mutter", "/nervous", "/no", "/nod", "/nosepick", "/object", "/offer", "/oom", "/oops", "/openfire", "/panic", "/pat", "/peer", "/pet", "/pinch", "/pity", "/plead", "/point", "/poke", "/ponder", "/pounce", "/pout", "/praise", "/pray", "/promise", "/proud", "/pulse", "/punch", "/purr", "/puzzle", "/raise", "/rasp", "/read", "/ready", "/regret", "/revenge", "/roar", "/rofl", "/rolleyes", "/rude", "/ruffle", "/sad", "/salute", "/scared", "/scoff", "/scold", "/scowl", "/scratch", "/search", "/sexy", "/shakefist", "/shifty", "/shimmy", "/shiver", "/shoo", "/shout", "/shrug", "/shudder", "/shy", "/sigh", "/signal", "/silence", "/sing", "/sit", "/slap", "/sleep", "/smack", "/smile", "/smirk", "/snap", "/snarl", "/sneak", "/sneeze", "/snicker", "/sniff", "/snort", "/snub", "/soothe", "/spit", "/squeal", "/stand", "/stare", "/surprised", "/surrender", "/suspicious", "/sweat", "/talk", "/talkex", "/talkq", "/tap", "/taunt", "/tease", "/thank", "/think", "/thirsty", "/threaten", "/tickle", "/tired", "/train", "/truce", "/twiddle", "/unused", "/veto", "/victory", "/violin", "/wait", "/warn", "/wave", "/welcome", "/whine", "/whistle", "/whoa", "/wince", "/wink", "/work", "/yawn", "/yw",
	},
	["COMBAT"] = {
		"/cancelaura",
		{ "/cancelqueuedspell", "/cqs", },
		"/cancelform",
		"/cast",
		"/castrandom",
		"/castsequence",
		"/changeactionbar",
		"/startattack",
		"/stopattack",
		"/stopcasting",
		"/stopspelltarget",
		"/swapactionbar",
		"/use",
		"/usetoy",
		"/userandom",
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
		"/ffa",
		"/group",
		["/invite"] = "/inv",
		["/maintankoff"] = "/mtoff",
		["/clearmainassist"] = "/clearma",
		["/mainassistoff"] = "/maoff",
		["/mainassist"] = "/ma",
		"/master",
		["/maintank"] = "/mt",
		["/promote"] = "/pr",
		"/raidinfo",
		"/readycheck",
		"/requestinvite",
		["/targetmarker"] = "/tm",
		"/threshold",
		["/uninvite"] = "/u",
		["/worldmarker"] = "/wm",
	},
	["PET"] = {
		"/petaggressive",
		"/petassist",
		"/petattack",
		"/petautocastoff",
		"/petautocaston",
		"/petautocasttoggle",
		"/petdefensive",
		"/petdismiss",
		"/petfollow",
		"/petmoveto",
		"/petpassive",
		"/petstay",
	},
	["PVP"] = {
		"/duel",
		"/pvp",
		["/wargame"] = "/wg",
		"/yield",
	},
	["SYSTEM"] = {
		"/click",
		"/combatlog",
		"/console",
		"/countdown",
		"/disableaddons",
		"/enableaddons",
		["/help"] = "/h",
		["/logout"] = "/camp",
		"/played",
		"/quit",
		"/reload",
		["/script"] = "/run",
		"/stopmacro",
		"/time",
		"/timetest",
		"/tts",
		"/voice",
	},
	["TARGETING"] = {
		["/assist"] = "/a",
		"/focus",
		"/clearfocus",
		["/target"] = "/tar",
		"/cleartarget",
		"/targetenemy",
		"/targetenemyplayer",
		"/targetexact",
		"/targetfriend",
		"/targetfriendplayer",
		"/targetlastenemy",
		"/targetlastfriend",
		"/targetlasttarget",
		"/targetparty",
		"/targetraid",
	},
	["UNKNOWN"] = {
		"/resetcommentatorsettings",
		["/assignplayer"] = "/ap",
		"/invitespectatormatch",
		"/community",
		["/charwhisper"] = "/cw",
		"/vt",
		["/overridename"] = "/on",
	}
}

mb.Slash = {
	["SLASH_TARGET_NEAREST_RAID"] = {
		["/targetraid"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TEAM_DISBAND"] = {
		["/tdisband"] = "$PRIMARY_ALIAS",
		["/teamdisband"] = true,
	},
	["SLASH_CHAT_ANNOUNCE"] = {
		["/ann"] = "$PRIMARY_ALIAS",
		["/announce"] = true,
	},
	["SLASH_UNIGNORE"] = {
		["/unignore"] = "$PRIMARY_ALIAS",
	},
	["SLASH_FOLLOW"] = {
		["/f"] = "$PRIMARY_ALIAS",
		["/fol"] = true,
		["/follow"] = true,
	},
	["SLASH_GUILD_LEADER"] = {
		["/gleader"] = true,
		["/guildleader"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RANDOM"] = {
		["/roll"] = true,
		["/random"] = true,
		["/rnd"] = true,
		["/rand"] = "$PRIMARY_ALIAS",
	},
	["SLASH_MAINASSISTOFF"] = {
		["/mainassistoff"] = "$PRIMARY_ALIAS",
		["/maoff"] = true,
	},
	["SLASH_CHAT_MODERATOR"] = {
		["/moderator"] = "$PRIMARY_ALIAS",
		["/mod"] = true,
	},
	["SLASH_RAIDBROWSER"] = {
		["/rb"] = true,
		["/or"] = true,
		["/raidbrowser"] = "$PRIMARY_ALIAS",
		["/otherraids"] = true,
	},
	["SLASH_OPEN_LOOT_HISTORY"] = {
		["/lootrolls"] = true,
		["/loot"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_MODERATE"] = {
		["/moderate"] = "$PRIMARY_ALIAS",
	},
	["SLASH_SET_TITLE"] = {
		["/settitle"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_PROMOTE"] = {
		["/guildpromote"] = true,
		["/gpromote"] = "$PRIMARY_ALIAS",
	},
	["SLASH_DUMP"] = {
		["/dump"] = "$PRIMARY_ALIAS",
	},
	["SLASH_COMMENTATOR_OVERRIDE"] = {
		["/on"] = true,
		["/overridename"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CLEAR_WORLD_MARKER"] = {
		["/clearworldmarker"] = "$PRIMARY_ALIAS",
		["/cwm"] = true,
	},
	["SLASH_MAINTANKOFF"] = {
		["/mtoff"] = "$PRIMARY_ALIAS",
		["/maintankoff"] = true,
	},
	["SLASH_EMOTE"] = {
		["/me"] = true,
		["/emote"] = true,
		["/em"] = true,
		["/e"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_KICK"] = {
		["/ckick"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TEAM_INVITE"] = {
		["/tinvite"] = "$PRIMARY_ALIAS",
		["/teaminvite"] = true,
	},
	["SLASH_VOICE"] = {
		["/voice"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TARGET_NEAREST_PARTY"] = {
		["/targetparty"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHANNEL"] = {
		["/c"] = true,
		["/csay"] = "$PRIMARY_ALIAS",
	},
	["SLASH_INSPECT"] = {
		["/inspect"] = true,
		["/ins"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_AUTOCASTON"] = {
		["/petautocaston"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RAF"] = {
		["/raf"] = "$PRIMARY_ALIAS",
	},
	["SLASH_WHO"] = {
		["/who"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RELOAD"] = {
		["/reload"] = "$PRIMARY_ALIAS",
	},
	["SLASH_MACROHELP"] = {
		["/macrohelp"] = "$PRIMARY_ALIAS",
	},
	["SLASH_JOIN"] = {
		["/join"] = true,
		["/channel"] = true,
		["/chan"] = "$PRIMARY_ALIAS",
	},
	["SLASH_SUMMON_BATTLE_PET"] = {
		["/sp"] = "$PRIMARY_ALIAS",
		["/summonpet"] = true,
	},
	["SLASH_GUILD_DISBAND"] = {
		["/guilddisband"] = "$PRIMARY_ALIAS",
		["/gdisband"] = true,
	},
	["SLASH_TARGET_NEAREST_FRIEND_PLAYER"] = {
		["/targetfriendplayer"] = "$PRIMARY_ALIAS",
	},
	["SLASH_COMMENTATOR_NAMETEAM"] = {
		["/nt"] = "$PRIMARY_ALIAS",
		["/nameteam"] = true,
	},
	["SLASH_COUNTDOWN"] = {
		["/cd"] = true,
		["/countdown"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RAID"] = {
		["/rsay"] = true,
		["/ra"] = "$PRIMARY_ALIAS",
		["/raid"] = true,
	},
	["SLASH_LOOT_NEEDBEFOREGREED"] = {
		["/needbeforegreed"] = "$PRIMARY_ALIAS",
	},
	["SLASH_DISMOUNT"] = {
		["/dismount"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_LEAVE"] = {
		["/guildquit"] = "$PRIMARY_ALIAS",
		["/gquit"] = true,
	},
	["SLASH_CASTGLYPH"] = {
		["/castglyph"] = "$PRIMARY_ALIAS",
	},
	["SLASH_STOPCASTING"] = {
		["/stopcasting"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CASTRANDOM"] = {
		["/castrandom"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TIME"] = {
		["/time"] = "$PRIMARY_ALIAS",
	},
	["SLASH_ENABLE_ADDONS"] = {
		["/enableaddons"] = "$PRIMARY_ALIAS",
	},
	["SLASH_COMMUNITIES_VOICE"] = {
		["/cv"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_UNMUTE"] = {
		["/unsquelch"] = "$PRIMARY_ALIAS",
		["/voice"] = true,
		["/unmute"] = true,
	},
	["SLASH_USERANDOM"] = {
		["/userandom"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_PASSWORD"] = {
		["/password"] = "$PRIMARY_ALIAS",
		["/pass"] = true,
	},
	["SLASH_LOOT_MASTER"] = {
		["/master"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHATLOG"] = {
		["/chatlog"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RANDOMPET"] = {
		["/randompet"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CANCELFORM"] = {
		["/cancelform"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_DISMISS"] = {
		["/petdismiss"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_AUTOCASTOFF"] = {
		["/petautocastoff"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TARGET_EXACT"] = {
		["/targetexact"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_INFO"] = {
		["/guildinfo"] = true,
		["/ginfo"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PARTY_VOICE"] = {
		["/pv"] = "$PRIMARY_ALIAS",
	},
	["SLASH_BENCHMARK"] = {
		["/timetest"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_VOICE"] = {
		["/gv"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_BAN"] = {
		["/ban"] = "$PRIMARY_ALIAS",
	},
	["SLASH_LEAVE"] = {
		["/chatexit"] = "$PRIMARY_ALIAS",
		["/chatleave"] = true,
		["/leave"] = true,
	},
	["SLASH_RAID_INFO"] = {
		["/raidinfo"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_AUTOCASTTOGGLE"] = {
		["/petautocasttoggle"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RAID_WARNING"] = {
		["/rw"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TARGET_LAST_ENEMY"] = {
		["/targetlastenemy"] = "$PRIMARY_ALIAS",
	},
	["SLASH_LOGOUT"] = {
		["/logout"] = true,
		["/camp"] = "$PRIMARY_ALIAS",
	},
	["SLASH_HELP"] = {
		["/help"] = true,
		["/?"] = true,
		["/h"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_AGGRESSIVE"] = {
		["/petaggressive"] = "$PRIMARY_ALIAS",
	},
	["SLASH_USE_TOY"] = {
		["/usetoy"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TARGET_NEAREST_ENEMY_PLAYER"] = {
		["/targetenemyplayer"] = "$PRIMARY_ALIAS",
	},
	["SLASH_WARGAME"] = {
		["/wg"] = true,
		["/wargame"] = "$PRIMARY_ALIAS",
	},
	["SLASH_YELL"] = {
		["/sh"] = "$PRIMARY_ALIAS",
		["/shout"] = true,
		["/yell"] = true,
		["/y"] = true,
	},
	["SLASH_FRAMESTACK"] = {
		["/fstack"] = true,
		["/framestack"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_HELP"] = {
		["/ghelp"] = "$PRIMARY_ALIAS",
		["/guildhelp"] = true,
	},
	["SLASH_STARTATTACK"] = {
		["/startattack"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RANDOMFAVORITEPET"] = {
		["/rfp"] = true,
		["/randomfavoritepet"] = "$PRIMARY_ALIAS",
	},
	["SLASH_VOICE_TEXT"] = {
		["/vt"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CLEAR"] = {
		["/clear"] = "$PRIMARY_ALIAS",
	},
	["SLASH_FOCUS"] = {
		["/focus"] = "$PRIMARY_ALIAS",
	},
	["SLASH_LOOT_ROUNDROBIN"] = {
		["/roundrobin"] = "$PRIMARY_ALIAS",
	},
	["SLASH_SCRIPT"] = {
		["/script"] = true,
		["/run"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TEAM_UNINVITE"] = {
		["/teamremove"] = true,
		["/tremove"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CALENDAR"] = {
		["/calendar"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TARGET_NEAREST_ENEMY"] = {
		["/targetenemy"] = "$PRIMARY_ALIAS",
	},
	["SLASH_REMOVEFRIEND"] = {
		["/removefriend"] = "$PRIMARY_ALIAS",
		["/remfriend"] = true,
	},
	["SLASH_CHAT_UNBAN"] = {
		["/unban"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_PASSIVE"] = {
		["/petpassive"] = "$PRIMARY_ALIAS",
	},
	["SLASH_EQUIP_SET"] = {
		["/equipset"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TRADE"] = {
		["/tr"] = true,
		["/trade"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILDFINDER"] = {
		["/guildfinder"] = "$PRIMARY_ALIAS",
		["/gf"] = true,
	},
	["SLASH_CHAT_UNMODERATOR"] = {
		["/unmoderator"] = "$PRIMARY_ALIAS",
		["/unmod"] = true,
	},
	["SLASH_REQUEST_INVITE"] = {
		["/requestinvite"] = "$PRIMARY_ALIAS",
	},
	["SLASH_FRIENDS"] = {
		["/friend"] = true,
		["/friends"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PVP"] = {
		["/pvp"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TARGET_LAST_FRIEND"] = {
		["/targetlastfriend"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RESETCHAT"] = {
		["/resetchat"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_AFK"] = {
		["/afk"] = true,
		["/away"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PLAYED"] = {
		["/played"] = "$PRIMARY_ALIAS",
	},
	["SLASH_READYCHECK"] = {
		["/rc"] = "$PRIMARY_ALIAS",
		["/readycheck"] = true,
	},
	["SLASH_CANCELAURA"] = {
		["/cancelaura"] = "$PRIMARY_ALIAS",
	},
	["SLASH_STOPATTACK"] = {
		["/stopattack"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_STAY"] = {
		["/petstay"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CLEARFOCUS"] = {
		["/clearfocus"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_CINVITE"] = {
		["/chatinvite"] = true,
		["/cinvite"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_LEADER_REPLACE"] = {
		["/greplace"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_HELP"] = {
		["/chat"] = "$PRIMARY_ALIAS",
		["/chathelp"] = true,
	},
	["SLASH_SWAPACTIONBAR"] = {
		["/swapactionbar"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CANCELQUEUEDSPELL"] = {
		["/cancelqueuedspell"] = true,
		["/cqs"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TARGET_MARKER"] = {
		["/tm"] = "$PRIMARY_ALIAS",
		["/targetmarker"] = true,
	},
	["SLASH_EQUIP"] = {
		["/eq"] = "$PRIMARY_ALIAS",
		["/equip"] = true,
	},
	["SLASH_QUIT"] = {
		["/quit"] = "$PRIMARY_ALIAS",
		["/exit"] = true,
	},
	["SLASH_VOICEMACRO"] = {
		["/v"] = "$PRIMARY_ALIAS",
	},
	["SLASH_COMMUNITY"] = {
		["/community"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_ASSIST"] = {
		["/petassist"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CLICK"] = {
		["/click"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_MOTD"] = {
		["/gmotd"] = true,
		["/guildmotd"] = "$PRIMARY_ALIAS",
	},
	["SLASH_DUEL"] = {
		["/duel"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CLEARMAINTANK"] = {
		["/clearmaintank"] = true,
		["/clearmt"] = "$PRIMARY_ALIAS",
	},
	["SLASH_WHISPER"] = {
		["/cw"] = true,
		["/charwhisper"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RAIDFINDER"] = {
		["/raidfinder"] = true,
		["/rf"] = true,
		["/lfr"] = "$PRIMARY_ALIAS",
	},
	["SLASH_LOOT_GROUP"] = {
		["/group"] = "$PRIMARY_ALIAS",
	},
	["SLASH_USE_TALENT_SPEC"] = {
		["/usetalents"] = "$PRIMARY_ALIAS",
	},
	["SLASH_VOICECHAT"] = {
		["/voice"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TEAM_QUIT"] = {
		["/tquit"] = true,
		["/teamquit"] = "$PRIMARY_ALIAS",
	},
	["SLASH_LEAVEVEHICLE"] = {
		["/leavevehicle"] = "$PRIMARY_ALIAS",
	},
	["SLASH_USE"] = {
		["/use"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CASTSEQUENCE"] = {
		["/castsequence"] = "$PRIMARY_ALIAS",
	},
	["SLASH_DUEL_CANCEL"] = {
		["/concede"] = true,
		["/forfeit"] = "$PRIMARY_ALIAS",
		["/yield"] = true,
	},
	["SLASH_PET_ATTACK"] = {
		["/petattack"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CLEARMAINASSIST"] = {
		["/clearma"] = "$PRIMARY_ALIAS",
		["/clearmainassist"] = true,
	},
	["SLASH_EVENTTRACE"] = {
		["/eventtrace"] = true,
		["/etrace"] = "$PRIMARY_ALIAS",
	},
	["SLASH_DISMISSBATTLEPET"] = {
		["/dismisspet"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_WHO"] = {
		["/gwho"] = true,
		["/whoguild"] = true,
		["/glist"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TRANSMOG_OUTFIT"] = {
		["/outfit"] = "$PRIMARY_ALIAS",
	},
	["SLASH_API"] = {
		["/api"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_ROSTER"] = {
		["/groster"] = true,
		["/guildroster"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_MUTE"] = {
		["/unvoice"] = true,
		["/squelch"] = "$PRIMARY_ALIAS",
		["/mute"] = true,
	},
	["SLASH_CONSOLE"] = {
		["/console"] = "$PRIMARY_ALIAS",
	},
	["SLASH_SAY"] = {
		["/s"] = "$PRIMARY_ALIAS",
		["/say"] = true,
	},
	["SLASH_COMMENTATOR_ASSIGNPLAYER"] = {
		["/ap"] = true,
		["/assignplayer"] = "$PRIMARY_ALIAS",
	},
	["SLASH_LOOT_SETTHRESHOLD"] = {
		["/threshold"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD"] = {
		["/gu"] = true,
		["/g"] = true,
		["/guild"] = "$PRIMARY_ALIAS",
		["/gc"] = true,
	},
	["SLASH_ACHIEVEMENTUI"] = {
		["/achieve"] = true,
		["/achievements"] = "$PRIMARY_ALIAS",
		["/ach"] = true,
		["/achievement"] = true,
	},
	["SLASH_STOPSPELLTARGET"] = {
		["/stopspelltarget"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHANGEACTIONBAR"] = {
		["/changeactionbar"] = "$PRIMARY_ALIAS",
	},
	["SLASH_IGNORE"] = {
		["/ignore"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_MOVE_TO"] = {
		["/petmoveto"] = "$PRIMARY_ALIAS",
	},
	["SLASH_STOPMACRO"] = {
		["/stopmacro"] = "$PRIMARY_ALIAS",
	},
	["SLASH_OFFICER"] = {
		["/osay"] = true,
		["/officer"] = true,
		["/o"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_DEFENSIVE"] = {
		["/petdefensive"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PARTY"] = {
		["/party"] = true,
		["/p"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PET_FOLLOW"] = {
		["/petfollow"] = "$PRIMARY_ALIAS",
	},
	["SLASH_SMART_WHISPER"] = {
		["/w"] = true,
		["/t"] = true,
		["/whisper"] = true,
		["/tell"] = true,
		["/send"] = "$PRIMARY_ALIAS",
	},
	["SLASH_SPECTATOR_WARGAME"] = {
		["/invitespectatormatch"] = "$PRIMARY_ALIAS",
	},
	["SLASH_INSTANCE_CHAT"] = {
		["/instance"] = true,
		["/battleground"] = true,
		["/i"] = true,
		["/bg"] = "$PRIMARY_ALIAS",
		["/instance_chat"] = true,
	},
	["SLASH_TEXTTOSPEECH"] = {
		["/tts"] = "$PRIMARY_ALIAS",
	},
	["SLASH_SAVEGUILDROSTER"] = {
		["/saveguildroster"] = "$PRIMARY_ALIAS",
	},
	["SLASH_STOPWATCH"] = {
		["/stopwatch"] = "$PRIMARY_ALIAS",
		["/timer"] = true,
		["/sw"] = true,
	},
	["SLASH_DUNGEONS"] = {
		["/df"] = true,
		["/lfd"] = "$PRIMARY_ALIAS",
		["/dungeonfinder"] = true,
	},
	["SLASH_MAINTANKON"] = {
		["/maintank"] = true,
		["/mt"] = "$PRIMARY_ALIAS",
	},
	["SLASH_ASSIST"] = {
		["/a"] = true,
		["/assist"] = "$PRIMARY_ALIAS",
	},
	["SLASH_LOOT_FFA"] = {
		["/ffa"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_OWNER"] = {
		["/owner"] = "$PRIMARY_ALIAS",
	},
	["SLASH_DISABLE_ADDONS"] = {
		["/disableaddons"] = "$PRIMARY_ALIAS",
	},
	["SLASH_PROMOTE"] = {
		["/promote"] = "$PRIMARY_ALIAS",
		["/pr"] = true,
	},
	["SLASH_EQUIP_TO_SLOT"] = {
		["/equipslot"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TARGET_LAST_TARGET"] = {
		["/targetlasttarget"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CHAT_DND"] = {
		["/busy"] = "$PRIMARY_ALIAS",
		["/dnd"] = true,
	},
	["SLASH_TABLEINSPECT"] = {
		["/tinspect"] = true,
		["/tableinspect"] = "$PRIMARY_ALIAS",
	},
	["SLASH_RESET_COMMENTATOR_SETTINGS"] = {
		["/resetcommentatorsettings"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_DEMOTE"] = {
		["/guilddemote"] = "$PRIMARY_ALIAS",
		["/gdemote"] = true,
	},
	["SLASH_COMBATLOG"] = {
		["/combatlog"] = "$PRIMARY_ALIAS",
	},
	["SLASH_MAINASSISTON"] = {
		["/mainassist"] = true,
		["/ma"] = "$PRIMARY_ALIAS",
	},
	["SLASH_UNINVITE"] = {
		["/votekick"] = true,
		["/u"] = true,
		["/uninvite"] = true,
		["/kick"] = true,
		["/un"] = "$PRIMARY_ALIAS",
	},
	["SLASH_GUILD_INVITE"] = {
		["/ginvite"] = "$PRIMARY_ALIAS",
		["/guildinvite"] = true,
	},
	["SLASH_TARGET"] = {
		["/target"] = true,
		["/tar"] = "$PRIMARY_ALIAS",
	},
	["SLASH_INVITE"] = {
		["/inv"] = true,
		["/invite"] = "$PRIMARY_ALIAS",
	},
	["SLASH_REPLY"] = {
		["/reply"] = "$PRIMARY_ALIAS",
		["/r"] = true,
	},
	["SLASH_SHARE"] = {
		["/share"] = "$PRIMARY_ALIAS",
	},
	["SLASH_CLEARTARGET"] = {
		["/cleartarget"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TARGET_NEAREST_FRIEND"] = {
		["/targetfriend"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TOKEN"] = {
		["/tk"] = true,
		["/token"] = "$PRIMARY_ALIAS",
	},
	["SLASH_WORLD_MARKER"] = {
		["/wm"] = true,
		["/worldmarker"] = "$PRIMARY_ALIAS",
	},
	["SLASH_MACRO"] = {
		["/m"] = true,
		["/macro"] = "$PRIMARY_ALIAS",
	},
	["SLASH_TEAM_CAPTAIN"] = {
		["/teamcaptain"] = "$PRIMARY_ALIAS",
		["/tcaptain"] = true,
	},
	["SLASH_GUILD_UNINVITE"] = {
		["/gremove"] = "$PRIMARY_ALIAS",
		["/guildremove"] = true,
	},
	["SLASH_LIST_CHANNEL"] = {
		["/chatlist"] = "$PRIMARY_ALIAS",
		["/chatwho"] = true,
		["/chatinfo"] = true,
	},
	["SLASH_CAST"] = {
		["/cast"] = true,
		["/spell"] = "$PRIMARY_ALIAS",
	},
}

mb.ModCombos = {
    "[mod:shift]", -- [1]
    "[mod:ctrl]", -- [2]
    "[mod:shiftctrl]", -- [3]
    "[mod:alt]", -- [4]
    "[mod:shiftalt]", -- [5]
    "[mod:ctrlalt]", -- [6]
    "[mod:shiftctrlalt]", -- [7]
}

mb.Choices = {
	["MOD"] = { "shift", "ctrl", "alt" },
	["SPEC"] = {
		["DEATHKNIGHT"] = 3, -- { 250, 251, 252 }, -- BLOOD FROST UNHOLY
		["DEMONHUNTER"] = 2, -- { 577, 581 }, -- HAVOC VENGEANCE
		["DRUID"] = 4, -- { 102, 103, 104, 105 }, -- BALANCE FERAL GUARDIAN RESTORATION
		["HUNTER"] = 3, -- { 253, 254, 255 }, -- BEASTMASTERY MARKSMANSHIP SURVIVAL
		["MAGE"] = 3, -- { 62, 63, 64 }, -- ARCANE FIRE FROST
		["MONK"] = 3, -- { 268, 270, 269 }, -- BREWMASTER MISTWEAVER WINDWALKER
		["PALADIN"] = 3, -- { 65, 66, 70 }, -- HOLY PROTECTION RETRIBUTION
		["PRIEST"] = 3, -- { 256, 257, 258 }, -- DISCIPLINE HOLY SHADOW
		["ROGUE"] = 3, -- { 259, 260, 261 }, -- ASSASSINATION OUTLAW SUBTLETY
		["SHAMAN"] = 3, -- { 262, 263, 264 }, -- ELEMENTAL ENHANCEMENT RESTORATION
		["WARLOCK"] = 3, -- { 265, 266, 267 }, -- AFFLICTION DEMONOLOGY DESTRUCTION
		["WARRIOR"] = 3, -- { 71, 72, 73 } -- ARMS FURY PROTECTION
	},
}

--@do-not-package@
--[[
/target [target=focustarget, harm, nodead]
/castsequence : casts spells in a determined order
/assist player name : Assist a friendly player .Often used in raids to let everybody attack the same target.
/script UIErrorsFrame:Clear() Used to prevent the on screen error message when an item or ability is not ready.
/petpassive : puts your pet on passive
/petdefensive : puts your pet on defensive
/petattack : Tells your pet to attack
/petfollow : Tells your pet to follow you
/petstay :Tells your pet to stay
/cancelform : Cancels your current shapeshift form
/cancelaura : Turns off an aura you have
/changeactionbar : Changes your current actionbar
/stopcasting : Stops whatever you are casting
/stopwatch : Opens the stopwatch interface
/targetlastenemy : Target the last enemy you had selected
/targetexact : Target the exact name

[combat] : True if you are In combat
[nocombat] : True if you are not In combat
[exists] : True if you have a tartget
[dead] : True if Target is dead
[harm] : True if you can cast harmful spells on the target
[help] : True if your target can receive a beneficial effect
[stealth] : True if you are in stealth
[mounted] : True if you are on a mount
[mod:shift] , [mod:ctrl] , [mod:alt] True if you hold the given key
[channeling] : True if channeling a spell
[nochanneling] : True if you are not channeling a spell
[vehicleui] : True if the player has a vehicle UI
[unithasvehicleui] : True if the target of the macro has a vehicle UI
[party] and [raid]: True if target is in your party / raid
[indoors] and [outdoors]: True if you are indoors / outdoors
[nopet] : True if you don't have any pet active
[pet:name] : True if you have a pet active
[talent:Row/Column] : True if you have selected the talent for that row and column.


local DIRECT_MACRO_CONDITIONAL_NAMES = {
    "SecureCmdOptionParse",
    "GetShapeshiftForm", "IsStealthed",
    "UnitExists", "UnitIsDead", "UnitIsGhost",
    "UnitPlayerOrPetInParty", "UnitPlayerOrPetInRaid",
    "IsRightAltKeyDown", "IsLeftAltKeyDown", "IsAltKeyDown",
    "IsRightControlKeyDown", "IsLeftControlKeyDown", "IsControlKeyDown",
    "IsLeftShiftKeyDown", "IsRightShiftKeyDown", "IsShiftKeyDown",
    "IsModifierKeyDown", "IsModifiedClick",
    "GetMouseButtonClicked", "GetActionBarPage", "GetBonusBarOffset",
    "IsMounted", "IsSwimming", "IsSubmerged", "IsFlying", "IsFlyableArea",
    "IsIndoors", "IsOutdoors",
	"HasVehicleActionBar", "HasOverrideActionBar", "HasTempShapeshiftActionBar",
	"HasBonusActionBar", "GetBonusBarIndex", "GetVehicleBarIndex", "GetOverrideBarIndex",
	"HasExtraActionBar", "GetTempShapeshiftBarIndex", "CanExitVehicle"
};

local OTHER_SAFE_FUNCTION_NAMES = {
    "GetBindingKey", "HasAction",
    "IsHarmfulSpell", "IsHarmfulItem", "IsHelpfulSpell", "IsHelpfulItem",
    "GetMultiCastTotemSpells", "FindSpellBookSlotBySpellID", "UnitTargetsVehicleInRaidUI"
};

-- Inventory slots
INVSLOT_AMMO		= 0;
INVSLOT_HEAD 		= 1; INVSLOT_FIRST_EQUIPPED = INVSLOT_HEAD;
INVSLOT_NECK		= 2;
INVSLOT_SHOULDER	= 3;
INVSLOT_BODY		= 4;
INVSLOT_CHEST		= 5;
INVSLOT_WAIST		= 6;
INVSLOT_LEGS		= 7;
INVSLOT_FEET		= 8;
INVSLOT_WRIST		= 9;
INVSLOT_HAND		= 10;
INVSLOT_FINGER1		= 11;
INVSLOT_FINGER2		= 12;
INVSLOT_TRINKET1	= 13;
INVSLOT_TRINKET2	= 14;
INVSLOT_BACK		= 15;
INVSLOT_MAINHAND	= 16;
INVSLOT_OFFHAND		= 17;
INVSLOT_RANGED		= 18;
INVSLOT_TABARD		= 19;
INVSLOT_LAST_EQUIPPED = INVSLOT_TABARD;
]]


-- is this some kind of escape sequence for chat commands?
-- ["/c"] = { "/c", "/csay", },
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
--@end-do-not-package@