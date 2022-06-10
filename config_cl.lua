ClientConfig = {}

-- Configure any module/detection to your liking
-- Beware that some values are very sensitive and could break everything
ClientConfig.Modules = {

	Aimbot = {
		enabled = true,
		threshold = 5.0, -- raycast dinstance tolerance value
		headshot_rate = 0.8, -- headshot quote that leads to a ban
		rayFlag = 1 -- obstruction flag used for raycast
	},

	Godmode = {
		enabled = true,
		decrement = math.random(1, 3), -- how much health can be subtracted for full health checks
		wait = math.random(10, 50), -- the interval to wait between substractions
		maxHealth = 200, -- default max player health
		maxArmor = 100 -- default max armor a player can have
	},

	Natives = {
		enabled = true
	},

	NoClip = {
		enabled = true,
		vehicleClasses = { 21, 19, 18, 16, 15, 14 }, -- excluded players in these classes
		failedHits = 3, -- how many missed rays lead to a ban (multitude)
		rayFlag = 1 -- obstruction flag used for raycast
	},

	PedBlacklist = {
		enabled = true,
	},

	Spectator = {
		enabled = true
	},

	Speed = {
		enabled = true,
		baseThreshold = 10.0, -- default max speed
		waterThreshold = 13.25, -- max legit speed in water/underwater
		airborneThreshold = 90.0, -- max legit speed in the air
		miscThreshold = 14.0 -- max legit speed for other scenarios such as combat, ragdolling etc.
	},

	Ammunition = {
		enabled = true
	},

	WeaponBlacklist = {
		enabled = true
	},

	WeaponModifier = {
		enabled = true
	},

	ExplosiveBullet = {
		enabled = true
	},

	DevTools = {
		enabled = true
	},

}

-- Weapons that get players banned
ClientConfig.BlacklistedWeapons = {
	"WEAPON_RAILGUN",
	"WEAPON_GARBAGEBAG",
	"WEAPON_MINIGUN",
	"WEAPON_RPG",
	"WEAPON_RAYMINIGUN",
	"WEAPON_STICKYBOMB",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_GRENADE",
	"WEAPON_MG",
	"WEAPON_PIPEBOMB",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_PROXMINE",
	"WEAPON_MOLOTOV",
	"WEAPON_BZGAS",
	"WEAPON_HAZARDCAN",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG_MK2",
	"WEAPON_RAYPISTOL",
	"WEAPON_FIREWORK",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_AUTOSHOTGUN",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MINISMG",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
}

-- Peds that get players banned
ClientConfig.BlacklistedPeds = {
	"CSB_BallasOG",
	"a_c_chop",
	"a_c_husky",
	"a_c_poodle",
	"a_c_pug",
	"a_c_retriever",
	"a_c_rottweiler",
	"a_c_shepherd",
	"a_c_westy",
	"a_c_boar",
	"a_c_cat_01",
	"a_c_chickenhawk",
	"a_c_chimp",
	"a_c_cormorant",
	"a_c_cow",
	"a_c_coyote",
	"a_c_crow",
	"a_c_deer",
	"a_c_dolphin",
	"a_c_fish",
	"a_c_hen",
	"a_c_humpback",
	"a_c_husky",
	"a_c_killerwhale",
	"a_c_mtlion",
	"a_c_panther",
	"a_c_pig",
	"a_c_pigeon",
	"a_c_rabbit_01",
	"a_c_rat",
	"a_c_retriever",
	"a_c_rhesus",
	"a_c_seagull",
	"a_c_sharkhammer",
	"a_c_sharktiger",
	"a_c_stingray",
	"a_m_m_acult_01",
	"a_m_m_beach_01",
	"a_m_m_beach_02",
	"a_m_m_farmer_01",
	"a_m_m_fatlatin_01",
	"a_m_m_genfat_01",
	"a_m_m_genfat_02",
	"a_m_m_golfer_01",
	"a_m_m_hasjew_01",
	"a_m_m_hillbilly_01",
	"a_m_m_hillbilly_02",
	"a_m_m_indian_01",
	"a_m_m_tranvest_01",
	"a_m_m_tranvest_02",
	"a_m_o_acult_01",
	"a_m_y_acult_02",
	"a_m_y_acult_01",
	"a_m_y_beach_03",
	"a_m_y_hasjew_01",
	"a_m_y_hippy_01",
	"a_m_y_motox_01",
	"a_m_y_musclbeac_01",
	"a_m_y_musclbeac_02",
	"a_m_y_salton_01",
	"cs_brad",
	"cs_chrisformage",
	"cs_davenorton",
	"cs_hunter",
	"cs_priest",
	"csb_maude",
	"csb_stripper_01",
	"csb_stripper_02",
	"ig_lestercrest",
	"ig_lestercrest_2",
	"ig_lestercrest_3",
	"ig_orleans",
	"ig_nervousron",
	"ig_old_man1a",
	"ig_old_man2",
	"ig_oneil",
	"ig_tylerdix",
	"mp_f_cocaine_01",
	"s_m_m_movspace_01",
	"s_m_y_baywatch_01",
	"s_m_y_clown_01",
	"s_m_y_mime",
	"u_m_y_imporage",
	"u_m_y_juggernaut_01",
	"u_m_y_mani",
	"u_m_y_pogo_01",
	"u_m_y_zombie_01",
	"u_m_y_rsranger_01",
	"u_m_y_staggrm_01",
}

-- Weapons that will result in aimbot false postives can be disabled here
-- These weapons are primarily explosives or similar
ClientConfig.NoAimbotChecks = {
	3058715602, 
	286056380,
	3357909247,	
	4233768403,	
	798856618,	
	1693512364,	
	1436779599,	
	1768518260,	
	428159217,	
	1114654932,	
	3883417820,		
	2666433428,	
	527211813,	
	352593635,	
	845770333,	
	1762719600,	
	1907543711,	
	1115750597,	
	2598821281,	
	3280748971,	
	2462366525,	
	3779253713,	
	2964119085,	
	2557052034,
	3104722777,
	1195540791,
	1015970717,
	335057065,
	2441087679,
	4143991942,
	3476653675,
	3564062519,
	881270991,
	2211086889,
	2820610173,
	2621769546,
}
