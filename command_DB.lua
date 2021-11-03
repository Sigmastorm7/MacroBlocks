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

mb.ModKeys = {
    "[mod:shift]", -- [1]
    "[mod:ctrl]", -- [2]
    "[mod:shiftctrl]", -- [3]
    "[mod:alt]", -- [4]
    "[mod:shiftalt]", -- [5]
    "[mod:ctrlalt]", -- [6]
    "[mod:shiftctrlalt]", -- [7]
}

mb.Specializations = {
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