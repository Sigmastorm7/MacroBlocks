local addon, mb = ...
mb.SlashCommandList = {
	["BATTLEPET"] = {
		["/randomfavoritepet"] = {
			["/rfp"] = true,
			["/randomfavoritepet"] = true,
		},
		["/summonpet"] = {
			["/sp"] = true,
			["/summonpet"] = true,
		},
		["/dismisspet"] = {
			["/dismisspet"] = true,
		},
	},
	["INTERFACE"] = {
		["/achievements"] = {
			["/ach"] = true,
			["/achieve"] = true,
			["/achievement"] = true,
			["/achievements"] = true,				
		},
		["/calendar"] = {
			["payload"] = "/calendar",
		},
		["/dungeonfinder"] = {
			["/dungeonfinder"] = true,
			["/lfd"] = true,
			["/df"] = true,
		},
		["/guildfinder"] = {
			["/guildfinder"] = true,
			["/gf"] = true,
		},
		["/loot"] = {
			["/lootrolls"] = true,
			["/loot"] = true,
		},
		["/macrohelp"] = {
			["/macrohelp"] = true,
		},
		["/macro"] = {
			["/macro"] = true,
			["/m"] = true,
		},
		["/raidfinder"] = {
			["/raidfinder"] = true,
			["/rf"] = true,
			["/lfr"] = true,
		},
		["/share"] = {
			["/share"] = true,
		},
		["/stopwatch"] = {
			["/stopwatch"] = true,
			["/timer"] = true,
			["/sw"] = true,
		},
		["/who"] = {
			["/who"] = true,
		},
	},
	["CHAT"] = {
		["/afk"] = {
			["/afk"] = true,
			["/away"] = true,
		},
		["/announce"] = {
			["/announce"] = true,
			["/ann"] = true,
		},
		["/ban"] = {
			["/ban"] = true,
		},
		["/chat"] = {
			["/chat"] = true,
			["/chathelp"] = true,
		},
	--[[["/c"] = {
			["/c"] = true,
			["/csay"] = true,
		},]]
		["/chatlist"] = {
			["/chatlist"] = true,
			["/chatwho"] = true,
			["/chatinfo"] = true,
		},
		["/chatlog"] = {
			["/chatlog"] = true,
		},
		["/cinvite"] = {
			["/cinvite"] = true,
			["/chatinvite"] = true,
		},
		["/ckick"] = {
			["/ckick"] = true,
		},
		["/dnd"] = {
			["/dnd"] = true,
			["/busy"] = true,
		},
		["/emote"] = {
			["/emote"] = true,
			["/me"] = true,
			["/em"] = true,
			["/e"] = true,
		},
		["/guild"] = {
			["/gc"] = true,
			["/g"] = true,
			["/guild"] = true,
			["/gu"] = true,
		},
		["/instance"] = {
			["/instance"] = true,
			["/battleground"] = true,
			["/i"] = true,
			["/bg"] = true,
			["/instance_chat"] = true,
		},
		["/join"] = {
			["/join"] = true,
			["/channel"] = true,
			["/chan"] = true,
		},
		["/leave"] = {
			["/leave"] = true,
			["/chatleave"] = true,
			["/chatexit"] = true,
		},
		["/moderator"] = {
			["/moderator"] = true,
			["/mod"] = true,
		},
		["/mute"] = {
			["/unvoice"] = true,
			["/squelch"] = true,
			["/mute"] = true,
		},
		["/officer"] = {
			["/osay"] = true,
			["/o"] = true,
			["/officer"] = true,
		},
		["/owner"] = {
			["/owner"] = true,
		},
		["/party"] = {
			["/party"] = true,
			["/p"] = true,
		},
		["/password"] = {
			["/password"] = true,
			["/pass"] = true,
		},
		["/raid"] = {
			["/rsay"] = true,
			["/raid"] = true,
			["/ra"] = true,
		},
		["/random"] = {
			["/rand"] = true,
			["/roll"] = true,
			["/rnd"] = true,
			["/random"] = true,
		},
		["/reply"] = {
			["/r"] = true,
			["/reply"] = true,
		},
		["/resetchat"] = {
			["/resetchat"] = true,
		},
		["/rw"] = {
			["/rw"] = true,
		},
		["/say"] = {
			["/s"] = true,
			["/say"] = true,
		},
		["/unban"] = {
			["/unban"] = true,
		},
		["/unmoderator"] = {
			["/unmoderator"] = true,
			["/unmod"] = true,
		},
		["/unmute"] = {
			["/voice"] = true,
			["/unsquelch"] = true,
			["/unmute"] = true,
		},
		["/whisper"] = {
			["/w"] = true,
			["/t"] = true,
			["/whisper"] = true,
			["/tell"] = true,
			["/send"] = true,
		},
		["/yell"] = {
			["/shout"] = true,
			["/y"] = true,
			["/yell"] = true,
			["/sh"] = true,
		},
	},
	["CHARACTER"] = {
		["/dismount"] = {
			["/dismount"] = true,
		},
		["/equip"] = {
			["/eq"] = true,
			["/equip"] = true,
		},
		["/equipset"] = {
			["/equipset"] = true,
		},
		["/equipslot"] = {
			["/equipslot"] = true,
		},
		["/friends"] = {
			["/friends"] = true,
			["/friend"] = true,
		},
		["/follow"] = {
			["/fol"] = true,
			["/f"] = true,
			["/follow"] = true,
		},
		["/ignore"] = {
			["/ignore"] = true,
		},
		["/inspect"] = {
			["/inspect"] = true,
			["/ins"] = true,
		},
		["/leavevehicle"] = {
			["/leavevehicle"] = true,
		},
		["/randompet"] = {
			["/randompet"] = true,
		},
		["/removefriend"] = {
			["/removefriend"] = true,
			["/remfriend"] = true,
		},
		["/settitle"] = {
			["/settitle"] = true,
		},
		["/trade"] = {
			["/tr"] = true,
			["/trade"] = true,
		},
		["/unignore"] = {
			["/unignore"] = true,
		},
		["/usetalents"] = {
			["/usetalents"] = true,
		},
	},
	["DEV"] = {
		["/api"] = {
			["/api"] = true,
		},
		["/dump"] = {
			["/dump"] = true,
		},
		["/eventtrace"] = {
			["/eventtrace"] = true,
			["/etrace"] = true,
		},
		["/framestack"] = {
			["/fstack"] = true,
			["/framestack"] = true,
		},
		["/tableinspect"] = {
			["/tinspect"] = true,
			["/tableinspect"] = true,
		},
	},
	["EMOTE"] = {
		"/absent", "/agree", "/amaze", "/angry", "/apologize", "/applaud", "/arm", "/attackmytarget", "/awe", "/backpack", "/badfeeling", "/bark", "/bashful", "/beckon", "/beg", "/bite", "/blame", "/blank", "/bleed", "/blink", "/blush", "/boggle", "/bonk", "/boop", "/bored", "/bounce", "/bow", "/brandish", "/brb", "/breath", "/burp", "/bye", "/cackle", "/calm", "/challenge", "/charge", "/charm", "/cheer", "/chicken", "/chuckle", "/chug", "/clap", "/cold", "/comfort", "/commend", "/confused", "/congratulate", "/cough", "/coverears", "/cower", "/crack", "/cringe", "/crossarms", "/cry", "/cuddle", "/curious", "/curtsey", "/dance", "/ding", "/disagree", "/doubt", "/drink", "/drool", "/duck", "/eat", "/embarrass", "/encourage", "/enemy", "/eye", "/eyebrow", "/facepalm", "/faint", "/fart", "/fidget", "/flee", "/flee", "/flex", "/flirt", "/flop", "/follow", "/forthealliance", "/forthehorde", "/frown", "/gasp", "/gaze", "/giggle", "/glare", "/gloat", "/glower", "/go", "/going", "/golfclap", "/greet", "/grin", "/groan", "/grovel", "/growl", "/guffaw", "/hail", "/happy", "/headache", "/healme", "/hello", "/helpme", "/hiccup", "/highfive", "/hiss", "/holdhand", "/hug", "/hungry", "/hurry", "/idea", "/incoming", "/incoming", "/insult", "/introduce", "/jealous", "/jk", "/joke", "/kiss", "/kneel", "/laugh", "/laydown", "/lick", "/listen", "/look", "/lost", "/love", "/luck", "/map", "/massage", "/meow", "/mercy", "/moan", "/mock", "/moo", "/moon", "/mountspecial", "/mourn", "/mutter", "/nervous", "/no", "/nod", "/nosepick", "/object", "/offer", "/oom", "/oops", "/openfire", "/panic", "/pat", "/peer", "/pet", "/pinch", "/pity", "/plead", "/point", "/poke", "/ponder", "/pounce", "/pout", "/praise", "/pray", "/promise", "/proud", "/pulse", "/punch", "/purr", "/puzzle", "/raise", "/rasp", "/read", "/ready", "/regret", "/revenge", "/roar", "/rofl", "/rolleyes", "/rude", "/ruffle", "/sad", "/salute", "/scared", "/scoff", "/scold", "/scowl", "/scratch", "/search", "/sexy", "/shake", "/shakefist", "/shifty", "/shimmy", "/shiver", "/shoo", "/shout", "/shrug", "/shudder", "/shy", "/sigh", "/signal", "/silence", "/sing", "/sit", "/slap", "/sleep", "/smack", "/smile", "/smirk", "/snap", "/snarl", "/sneak", "/sneeze", "/snicker", "/sniff", "/snort", "/snub", "/soothe", "/spit", "/squeal", "/stand", "/stare", "/stink", "/surprised", "/surrender", "/suspicious", "/sweat", "/talk", "/talkex", "/talkq", "/tap", "/taunt", "/tease", "/thank", "/think", "/thirsty", "/threaten", "/tickle", "/tired", "/train", "/truce", "/twiddle", "/unused", "/veto", "/victory", "/violin", "/wait", "/warn", "/wave", "/welcome", "/whine", "/whistle", "/whoa", "/wink", "/work", "/yawn", "/yw",
	},
	["COMBAT"] = {
		["/cancelaura"] = {
			["/cancelaura"] = true,
		},
		["/cancelqueuedspell"] = {
			["/cancelqueuedspell"] = true,
			["/cqs"] = true,
		},
		["/cancelform"] = {
			["/cancelform"] = true,
		},
		["/cast"] = {
			["/cast"] = true,
			["/spell"] = true,
		},
		["/castrandom"] = {
			["/castrandom"] = true,
		},
		["/castsequence"] = {
			["/castsequence"] = true,
		},
		["/changeactionbar"] = {
			["/changeactionbar"] = true,
		},
		["/startattack"] = {
			["/startattack"] = true,
		},
		["/stopattack"] = {
			["/stopattack"] = true,
		},
		["/stopcasting"] = {
			["/stopcasting"] = true,
		},
		["/stopspelltarget"] = {
			["/stopspelltarget"] = true,
		},
		["/swapactionbar"] = {
			["/swapactionbar"] = true,
		},
		["/use"] = {
			["/use"] = true,
		},
		["/usetoy"] = {
			["/usetoy"] = true,
		},
		["/userandom"] = {
			["/userandom"] = true,
		},
	},
	["GUILD"] = {
		["/guilddisband"] = {
			["/guilddisband"] = true,
			["/gdisband"] = true,
		},
		["/guilddemote"] = {
			["/guilddemote"] = true,
			["/gdemote"] = true,
		},
		["/guildinfo"] = {
			["/guildinfo"] = true,
			["/ginfo"] = true,
		},
		["/guildinvite"] = {
			["/ginvite"] = true,
			["/guildinvite"] = true,
		},
		["/guildleader"] = {
			["/gleader"] = true,
			["/guildleader"] = true,
		},
		["/glist"] = {
			["/whoguild"] = true,
			["/gwho"] = true,
			["/glist"] = true,
		},
		["/guildmotd"] = {
			["/gmotd"] = true,
			["/guildmotd"] = true,
		},
		["/guildpromote"] = {
			["/gpromote"] = true,
			["/guildpromote"] = true,
		},
		["/guildquit"] = {
			["/gquit"] = true,
			["/guildquit"] = true,
		},
		["/guildremove"] = {
			["/gremove"] = true,
			["/guildremove"] = true,
		},
		["/guildroster"] = {
			["/groster"] = true,
			["/guildroster"] = true,
		},
	},
	["PARTY_RAID"] = {
		["/clearworldmarker"] = {
			["/clearworldmarker"] = true,
			["/cwm"] = true,
		},
		["/clearmaintank"] = {
			["/clearmt"] = true,
			["/clearmaintank"] = true,
		},
		["/ffa"] = {
			["/ffa"] = true,
		},
		["/group"] = {
			["/group"] = true,
		},
		["/invite"] = {
			["/inv"] = true,
			["/invite"] = true,
		},
		["/maintankoff"] = {
			["/mtoff"] = true,
			["/maintankoff"] = true,
		},
		["/clearmainassist"] = {
			["/clearma"] = true,
			["/clearmainassist"] = true,
		},
		["/mainassistoff"] = {
			["/maoff"] = true,
			["/mainassistoff"] = true,
		},
		["/mainassist"] = {
			["/ma"] = true,
			["/mainassist"] = true,
		},
		["/master"] = {
			["/master"] = true,
		},
		["/maintank"] = {
			["/mt"] = true,
			["/maintank"] = true,
		},
		["/promote"] = {
			["/promote"] = true,
			["/pr"] = true,
		},
		["/raidinfo"] = {
			["/raidinfo"] = true,
		},
		["/readycheck"] = {
			["/readycheck"] = true,
		},
		["/requestinvite"] = {
			["/requestinvite"] = true,
		},
		["/targetmarker"] = {
			["/tm"] = true,
			["/targetmarker"] = true,
		},
		["/threshold"] = {
			["/threshold"] = true,
		},
		["/uninvite"] = {
			["/votekick"] = true,
			["/u"] = true,
			["/uninvite"] = true,
			["/kick"] = true,
			["/un"] = true,
		},
		["/worldmarker"] = {
			["/wm"] = true,
			["/worldmarker"] = true,
		},
	},
	["PET"] = {
		["/petaggressive"] = {
			["/petaggressive"] = true,
		},
		["/petassist"] = {
			["/petassist"] = true,
		},
		["/petattack"] = {
			["/petattack"] = true,
		},
		["/petautocastoff"] = {
			["/petautocastoff"] = true,
		},
		["/petautocaston"] = {
			["/petautocaston"] = true,
		},
		["/petautocasttoggle"] = {
			["/petautocasttoggle"] = true,
		},
		["/petdefensive"] = {
			["/petdefensive"] = true,
		},
		["/petdismiss"] = {
			["/petdismiss"] = true,
		},
		["/petfollow"] = {
			["/petfollow"] = true,
		},
		["/petmoveto"] = {
			["/petmoveto"] = true,
		},
		["/petpassive"] = {
			["/petpassive"] = true,
		},
		["/petstay"] = {
			["/petstay"] = true,
		},
	},
	["PVP"] = {
		["/duel"] = {
			["/duel"] = true,
		},
		["/pvp"] = {
			["/pvp"] = true,
		},
		["/wargame"] = {
			["/wg"] = true,
			["/wargame"] = true,
		},
		["/yield"] = {
			["/yield"] = true,
			["/forfeit"] = true,
			["/concede"] = true,
		},
	},
	["SYSTEM"] = {
		["/click"] = {
			["/click"] = true,
		},
		["/combatlog"] = {
			["/combatlog"] = true,
		},
		["/console"] = {
			["/console"] = true,
		},
		["/countdown"] = {
			["/countdown"] = true,
		},
		["/disableaddons"] = {
			["/disableaddons"] = true,
		},
		["/enableaddons"] = {
			["/enableaddons"] = true,
		},
		["/help"] = {
			["/help"] = true,
			["/h"] = true,
			["/?"] = true,
		},
		["/logout"] = {
			["/logout"] = true,
			["/camp"] = true,
		},
		["/played"] = {
			["/played"] = true,
		},
		["/quit"] = {
			["/quit"] = true,
			["/exit"] = true,
		},
		["/reload"] = {
			["/reload"] = true,
		},
		["/script"] = {
			["/script"] = true,
			["/run"] = true,
		},
		["/stopmacro"] = {
			["/stopmacro"] = true,
		},
		["/time"] = {
			["/time"] = true,
		},
		["/timetest"] = {
			["/timetest"] = true,
		},
		["/tts"] = {
			["/tts"] = true,
		},
		["/voice"] = {
			["/voice"] = true,
		},
	},
	["TARGETING"] = {
		["/assist"] = {
			["/a"] = true,
			["/assist"] = true,
		},
		["/focus"] = {
			["/focus"] = true,
		},
		["/clearfocus"] = {
			["/clearfocus"] = true,
		},
		["/target"] = {
			["/target"] = true,
			["/tar"] = true,
		},
		["/cleartarget"] = {
			["/cleartarget"] = true,
		},
		["/targetenemy"] = {
			["/targetenemy"] = true,
		},
		["/targetenemyplayer"] = {
			["/targetenemyplayer"] = true,
		},
		["/targetexact"] = {
			["/targetexact"] = true,
		},
		["/targetfriend"] = {
			["/targetfriend"] = true,
		},
		["/targetfriendplayer"] = {
			["/targetfriendplayer"] = true,
		},
		["/targetlastenemy"] = {
			["/targetlastenemy"] = true,
		},
		["/targetlastfriend"] = {
			["/targetlastfriend"] = true,
		},
		["/targetlasttarget"] = {
			["/targetlasttarget"] = true,
		},
		["/targetparty"] = {
			["/targetparty"] = true,
		},
		["/targetraid"] = {
			["/targetraid"] = true,
		},
	},
	["UNKNOWN"] = {
		["/resetcommentatorsettings"] = {
			["/resetcommentatorsettings"] = true,
		},
		["/assignplayer"] = {
			["/ap"] = true,
			["/assignplayer"] = true,
		},
		["/invitespectatormatch"] = {
			["/invitespectatormatch"] = true,
		},
		["/community"] = {
			["/community"] = true,
		},
		["/cw"] = {
			["/cw"] = true,
			["/charwhisper"] = true,
		},
		["/vt"] = {
			["/vt"] = true,
		},
		["/overridename"] = {
			["/overridename"] = true,
			["/on"] = true,
		},
	}
}

-- obselete ( or classic ) commands = {
--[[["/saveguildroster"] = {
		["/saveguildroster"] = true,
	},
	"/guildhelp"] = {
		["/ghelp"] = true,
		["/guildhelp"] = true,
	},
	["/token"] = {
		["/tk"] = true,
		["/token"] = true,
	},
	["/greplace"] = {
		["/greplace"] = true,
	},
	["/needbeforegreed"] = {
		["/needbeforegreed"] = true,
	},
	["/teaminvite"] = {
		["/teaminvite"] = true,
		["/tinvite"] = true,
	},
	["/castglyph"] = {
		["/castglyph"] = true,
	},
	["/gv"] = {
		["/gv"] = true,
	},
	["/teamremove"] = {
		["/teamremove"] = true,
		["/tremove"] = true,
	},
	["/teamcaptain"] = {
		["/teamcaptain"] = true,
		["/tcaptain"] = true,
	},
	["/clear"] = {
		["/clear"] = true,
	},
	["/moderate"] = {
		["/moderate"] = true,
	},
	["/teamquit"] = {
		["/teamquit"] = true,
		["/tquit"] = true,
	},
	["/roundrobin"] = {
		["/roundrobin"] = true,
	},
	["/pv"] = {
		["/pv"] = true,
	},
	["/cv"] = {
		["/cv"] = true,
	},
	["/teamdisband"] = {
		["/teamdisband"] = true,
		["/tdisband"] = true,
	},
	["/v"] = {
		["/v"] = true,
	},
	["/raidbrowser"] = {
		["/rb"] = true,
		["/or"] = true,
		["/raidbrowser"] = true,
		["/otherraids"] = true,
	},
	["/nameteam"] = {
		["/nt"] = true,
		["/nameteam"] = true,
	},]]
--}