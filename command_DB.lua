local addon, mb = ...
mb.SlashCommandList = {
	["NormalizedCommands"] = {
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
			["/c"] = {
				["/c"] = true,
				["/csay"] = true,
			},
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
			"/AGREE", "/AMAZE", "/ANGRY", "/APOLOGIZE", "/APPLAUD", "/BASHFUL", "/BECKON", "/BEG", "/BITE", "/BLEED", "/BLINK", "/BLUSH", "/BONK", "/BORED", "/BOUNCE", "/BRB", "/BOW", "/BURP", "/BYE", "/CACKLE", "/CHEER", "/CHICKEN", "/CHUCKLE", "/CLAP", "/CONFUSED", "/CONGRATULATE", "/UNUSED", "/COUGH", "/COWER", "/CRACK", "/CRINGE", "/CRY", "/CURIOUS", "/CURTSEY", "/DANCE", "/DRINK", "/DROOL", "/EAT", "/EYE", "/FART", "/FIDGET", "/FLEX", "/FROWN", "/GASP", "/GAZE", "/GIGGLE", "/GLARE", "/GLOAT", "/GREET", "/GRIN", "/GROAN", "/GROVEL", "/GUFFAW", "/HAIL", "/HAPPY", "/HELLO", "/HUG", "/HUNGRY", "/KISS", "/KNEEL", "/LAUGH", "/LAYDOWN", "/MASSAGE", "/MOAN", "/MOON", "/MOURN", "/NO", "/NOD", "/NOSEPICK", "/PANIC", "/PEER", "/PLEAD", "/POINT", "/POKE", "/PRAY", "/ROAR", "/ROFL", "/RUDE", "/SALUTE", "/SCRATCH", "/SEXY", "/SHAKE", "/SHOUT", "/SHRUG", "/SHY", "/SIGH", "/SIT", "/SLEEP", "/SNARL", "/SPIT", "/STARE", "/SURPRISED", "/SURRENDER", "/TALK", "/TALKEX", "/TALKQ", "/TAP", "/THANK", "/THREATEN", "/TIRED", "/VICTORY", "/WAVE", "/WELCOME", "/WHINE", "/WHISTLE", "/WORK", "/YAWN", "/BOGGLE", "/CALM", "/COLD", "/COMFORT", "/CUDDLE", "/DUCK", "/INSULT", "/INTRODUCE", "/JK", "/LICK", "/LISTEN", "/LOST", "/MOCK", "/PONDER", "/POUNCE", "/PRAISE", "/PURR", "/PUZZLE", "/RAISE", "/READY", "/SHIMMY", "/SHIVER", "/SHOO", "/SLAP", "/SMIRK", "/SNIFF", "/SNUB", "/SOOTHE", "/STINK", "/TAUNT", "/TEASE", "/THIRSTY", "/VETO", "/SNICKER", "/TICKLE", "/STAND", "/VIOLIN", "/SMILE", "/RASP", "/GROWL", "/BARK", "/PITY", "/SCARED", "/FLOP", "/LOVE", "/MOO", "/COMMEND", "/TRAIN", "/HELPME", "/INCOMING", "/OPENFIRE", "/CHARGE", "/FLEE", "/ATTACKMYTARGET", "/OOM", "/FOLLOW", "/WAIT", "/FLIRT", "/HEALME", "/JOKE", "/WINK", "/PAT", "/GOLFCLAP", "/MOUNTSPECIAL", "/INCOMING", "/FLEE", "/BLAME", "/BLANK", "/BRANDISH", "/BREATH", "/DISAGREE", "/DOUBT", "/EMBARRASS", "/ENCOURAGE", "/ENEMY", "/EYEBROW", "/HIGHFIVE", "/ABSENT", "/ARM", "/AWE", "/BACKPACK", "/BADFEELING", "/CHALLENGE", "/CHUG", "/DING", "/FACEPALM", "/FAINT", "/GO", "/GOING", "/GLOWER", "/HEADACHE", "/HICCUP", "/HISS", "/HOLDHAND", "/HURRY", "/IDEA", "/JEALOUS", "/LUCK", "/MAP", "/MERCY", "/MUTTER", "/NERVOUS", "/OFFER", "/PET", "/PINCH", "/PROUD", "/PROMISE", "/PULSE", "/PUNCH", "/POUT", "/REGRET", "/REVENGE", "/ROLLEYES", "/RUFFLE", "/SAD", "/SCOFF", "/SCOLD", "/SCOWL", "/SEARCH", "/SHAKEFIST", "/SHIFTY", "/SHUDDER", "/SIGNAL", "/SILENCE", "/SING", "/SMACK", "/SNEAK", "/SNEEZE", "/SNORT", "/SQUEAL", "/SUSPICIOUS", "/THINK", "/TRUCE", "/TWIDDLE", "/WARN", "/SNAP", "/CHARM", "/COVEREARS", "/CROSSARMS", "/LOOK", "/OBJECT", "/SWEAT", "/YW", "/READ", "/FORTHEALLIANCE", "/FORTHEHORDE", "/WHOA", "/OOPS", "/MEOW", "/BOOP",
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
			--[["/guildhelp"] = {
				["/ghelp"] = true,
				["/guildhelp"] = true,
			},]]
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
			--[["/saveguildroster"] = {
				["/saveguildroster"] = true,
			},]]
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
		["SOCIAL"] = {
			["/who"] = {
				["/who"] = true,
			},
		},
		["SYSTEM"] = {
			["/console"] = {
				["/console"] = true,
			},
			["/enableaddons"] = {
				["/enableaddons"] = true,
			},
			["/disableaddons"] = {
				["/disableaddons"] = true,
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
		},
		["TARGETING"] = {
			["/assist"] = {
				["/a"] = true,
				["/assist"] = true,
			},
			["/clearfocus"] = {
				["/clearfocus"] = true,
			},
			["/cleartarget"] = {
				["/cleartarget"] = true,
			},
			["/focus"] = {
				["/focus"] = true,
			},
			["/target"] = {
				["/target"] = true,
				["/tar"] = true,
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
		["META"] = {
			["#show"] = {
				"#show",
			},
			["#showtooltip"] = {
				"#showtooltip",
			},
		},
	}
}

local fuck = {
		["/resetcommentatorsettings"] = {
			["/resetcommentatorsettings"] = true,
		},
		["/cv"] = {
			["/cv"] = true,
		},
		["/teamdisband"] = {
			["/teamdisband"] = true,
			["/tdisband"] = true,
		},
		["/assignplayer"] = {
			["/ap"] = true,
			["/assignplayer"] = true,
		},
		["/token"] = {
			["/tk"] = true,
			["/token"] = true,
		},
		["/castsequence"] = {
			["/castsequence"] = true,
		},
		["/greplace"] = {
			["/greplace"] = true,
		},
		["/invitespectatormatch"] = {
			["/invitespectatormatch"] = true,
		},
		["/click"] = {
			["/click"] = true,
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
		["/countdown"] = {
			["/countdown"] = true,
		},
		["/teamremove"] = {
			["/teamremove"] = true,
			["/tremove"] = true,
		},
		["/combatlog"] = {
			["/combatlog"] = true,
		},
		["/teamcaptain"] = {
			["/teamcaptain"] = true,
			["/tcaptain"] = true,
		},
		["/community"] = {
			["/community"] = true,
		},
		["/clear"] = {
			["/clear"] = true,
		},
		["/h"] = {
			["/help"] = true,
			["/h"] = true,
			["/?"] = true,
		},
		["/moderate"] = {
			["/moderate"] = true,
		},
		["/cw"] = {
			["/cw"] = true,
			["/charwhisper"] = true,
		},
		["/teamquit"] = {
			["/teamquit"] = true,
			["/tquit"] = true,
		},
		["/chat"] = {
			["/chat"] = true,
			["/chathelp"] = true,
		},
		["/usetalents"] = {
			["/usetalents"] = true,
		},
		["/roundrobin"] = {
			["/roundrobin"] = true,
		},
		["/vt"] = {
			["/vt"] = true,
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
		},
		["/voice"] = {
			["/voice"] = true,
		},
		["/tts"] = {
			["/tts"] = true,
		},
		["/v"] = {
			["/v"] = true,
		},
		["/random"] = {
			["/rand"] = true,
			["/roll"] = true,
			["/rnd"] = true,
			["/random"] = true,
		},
		["/overridename"] = {
			["/overridename"] = true,
			["/on"] = true,
		},
		["/pv"] = {
			["/pv"] = true,
		},
	}