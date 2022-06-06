ServerConfig = {}

ServerConfig.BypassAcePerm = "icarus.bypass"

-- Ban data and game screenshot are send to this webhook
ServerConfig.DiscordWebhook = ""

-- Add your own ban logic here
function issueBan(source, reason)
	local _source = tonumber(source)
	TriggerEvent("EasyAdmin:banPlayer", _source, "Cheating (" .. reason .. ")", 1044463300) -- EasyAdmin for the sake of simplicity
end

-- Server to client heartbeat settings
-- Do not touch if you have no clue what you are doing!
ServerConfig.LatencyThreshold = 1000 -- ms

ServerConfig.HeartbeatInterval = 30000 -- Time it takes to request a heartbeat from the client (actual time is 2x of this value)

ServerConfig.UntilForcedHearbeat = (10 * 60000) -- Ten minutes

ServerConfig.SecurityHashLength = 16 -- The char length of the security hash which is used to verify heartbeats

-- Configure any module to your liking
ServerConfig.Modules = {

	ClearTasks = {
		enabled = true
	},

	GiveWeapon = {
		enabled = true
	},

	RemoveWeapon = {
		enabled = true
	},

	Injection = {
		enabled = true
	},

	Particles = {
		enabled = true,
		maxScale = 10.0, -- Abnormal large particles
	},

	EntityCreate = {
		enabled = true,
		scriptOwnership = true, -- Is entity owned by not existing script?
	},
}

-- Objects that get instantly deleted (including vehicles)
ServerConfig.IllegalModels = {
	"tug",
	"jet",
	"pyro",
	"tula",
	"rhino",
	"titan",
	"dune3",
	"dune2",
	"dune5",
	"issi4",
	"issi5",
	"issi6",
	"blimp",
	"mogul",
	"rogue",
	"zr380",
	"mule4",
	"blimp",
	"police",
	"tampa3",
	"ardent",
	"jb7002",
	"dukes2",
	"nokota",
	"blimp2",
	"blimp3",
	"raptor",
	"zr3802",
	"zr3803",
	"comet4",
	"brutus",
	"blimp2",
	"blimp3",
	"buzzard",
	"skylift",
	"shotaro",
	"ruiner3",
	"ruiner2",
	"bruiser",
	"menacer",
	"impala2",
	"impala3",
	"impala4",
	"avenger",
	"molotok",
	"volatol",
	"kuruma2",
	"voltic2",
	"freight",
	"tractor",
	"brutus2",
	"brutus3",
	"khanjali",
	"phantom2",
	"minitank",
	"thruster",
	"slamvan4",
	"slamvan5",
	"slamvan6",
	"faction3",
	"bruiser2",
	"bruiser3",
	"monster4",
	"monster5",
	"monster3",
	"avenger2",
	"paragon2",
	"revolter",
	"starling",
	"scramjet",
	"pounder2",
	"marshall",
	"vigilante",
	"oppressor",
	"boxville5",
	"halftrack",
	"imperator",
	"technical",
	"bombushka",
	"deathbike",
	"tankercar",
	"slamtruck",
	"boxville5",
	"oppressor2",
	"seasparrow",
	"deathbike2",
	"deathbike3",
	"dominator6",
	"cargoplane",
	"dominator4",
	"dominator5",
	"dominator6",
	"imperator2",
	"imperator3",
	"nightshark",
	"technical2",
	"technical3",
	"freightcar",
	"seasparrow2",
	"seasparrow3",
	"wastelander",
	"p_cablecar_s",
	"p_ferris_car_01",
	"prop_carcreeper",
	"prop_cj_big_boat",
	"prop_rock_4_big2",
	"prop_cattlecrush",
	"prop_gold_cont_01",
	"prop_steps_big_01",
	"p_spinning_anus_s",
	"apa_mp_h_bed_wide_05",
	"prop_cs_documents_01",
	"stt_prop_stunt_tube_l",
	"v_ilev_lest_bigscreen",
	"stt_prop_stunt_jump15",
	"stt_prop_stunt_jump30",
	"stt_prop_stunt_jump45",
	"apa_mp_h_bed_double_09",
	"stt_prop_hoop_tyre_01a",
	"hei_prop_carrier_ord_03",
	"stt_prop_stunt_bblock_qp",
	"stt_prop_stunt_jump_loop",
	"stt_prop_stunt_bblock_qp2",
	"stt_prop_stunt_bblock_qp3",
	"stt_prop_stunt_track_fork",
	"stt_prop_stunt_track_hill",
	"stt_prop_stunt_track_jump",
	"hei_prop_carrier_cargo_02a",
	"stt_prop_stunt_soccer_goal",
	"stt_prop_stunt_track_bumps",
	"stt_prop_stunt_track_hill2",
	"stt_prop_stunt_track_otake",
	"stt_prop_stunt_track_start",
	"stt_prop_stunt_track_cutout",
	"stt_prop_stunt_track_dwlink",
	"stt_prop_stunt_track_dwsh15",
	"stt_prop_stunt_track_dwturn",
	"stt_prop_stunt_track_funlng",
	"stt_prop_stunt_track_funnel",
	"stt_prop_stunt_track_dwuturn",
	"stt_prop_stunt_track_dwshort",
	"stt_prop_stunt_track_exshort",
	"stt_prop_stunt_track_slope15",
	"stt_prop_stunt_track_slope30",
	"stt_prop_stunt_track_slope45",
	"stt_prop_stunt_bblock_hump_01",
	"stt_prop_stunt_bblock_hump_02",
	"stt_prop_stunt_track_dwlink_02",
	"stt_prop_stunt_track_dwslope15",
	"stt_prop_stunt_track_dwslope30",
	"stt_prop_stunt_track_dwslope45",
}
