GuiTweakData = GuiTweakData or class()
function GuiTweakData:init()
	local soundtrack = {
		id = "soundtrack",
		name_id = "menu_content_soundtrack",
		desc_id = "menu_content_soundtrack_desc",
		date_id = "menu_content_soundtrack_date",
		store = 254260,
		image = "guis/textures/pd2/content_updates/soundtrack"
	}
	local diamond_store = {
		id = "diamond_store",
		name_id = "menu_content_diamond_store",
		desc_id = "menu_content_diamond_store_desc",
		date_id = "menu_content_diamond_store_date",
		store = 274160,
		image = "guis/textures/pd2/content_updates/diamond_store"
	}
	local birthday = {
		id = "birthday",
		name_id = "menu_content_birthday",
		desc_id = "menu_content_birthday_desc",
		date_id = "menu_content_birthday_date",
		webpage = "http://www.overkillsoftware.com/birthday/",
		image = "guis/textures/pd2/content_updates/birthday"
	}
	local halloween = {
		id = "halloween",
		name_id = "menu_content_halloween",
		desc_id = "menu_content_halloween_desc",
		date_id = "menu_content_halloween_date",
		webpage = "http://www.overkillsoftware.com/helltopay/",
		image = "guis/textures/pd2/content_updates/halloween"
	}
	local armored_transport = {
		id = "armored_transport",
		name_id = "menu_content_armored_transport",
		desc_id = "menu_content_armored_transport_desc",
		date_id = "menu_content_armored_transport_date",
		store = 264610,
		image = "guis/textures/pd2/content_updates/armored_transport"
	}
	local gage_pack = {
		id = "gage_pack",
		name_id = "menu_content_gage_pack",
		desc_id = "menu_content_gage_pack_desc",
		date_id = "menu_content_gage_pack_date",
		store = 267380,
		image = "guis/textures/pd2/content_updates/gage_pack"
	}
	local charliesierra = {
		id = "charliesierra",
		name_id = "menu_content_charliesierra",
		desc_id = "menu_content_charliesierra_desc",
		date_id = "menu_content_charliesierra_date",
		store = 271110,
		image = "guis/textures/pd2/content_updates/charliesierra"
	}
	local christmas = {
		id = "christmas",
		name_id = "menu_content_christmas",
		desc_id = "menu_content_christmas_desc",
		date_id = "menu_content_christmas_date",
		store = 267381,
		image = "guis/textures/pd2/content_updates/christmas"
	}
	local infamy = {
		id = "infamy",
		name_id = "menu_content_infamy",
		desc_id = "menu_content_infamy_desc",
		date_id = "menu_content_infamy_date",
		store = 274161,
		image = "guis/textures/pd2/content_updates/infamy_introduction"
	}
	local gage_pack_lmg = {
		id = "gage_pack_lmg",
		name_id = "menu_content_gage_pack_lmg",
		desc_id = "menu_content_gage_pack_lmg_desc",
		date_id = "menu_content_gage_pack_lmg_date",
		store = 275590,
		image = "guis/textures/pd2/content_updates/gage_pack_lmg"
	}
	local deathwish = {
		id = "deathwish",
		name_id = "menu_content_deathwish",
		desc_id = "menu_content_deathwish_desc",
		date_id = "menu_content_deathwish_date",
		store = 284430,
		image = "guis/textures/pd2/content_updates/deathwish"
	}
	local election_day = {
		id = "election_day",
		name_id = "menu_content_election_day",
		desc_id = "menu_content_election_day_desc",
		date_id = "menu_content_election_day_date",
		store = 288900,
		image = "guis/textures/pd2/content_updates/election_day"
	}
	local gage_pack_jobs = {
		id = "gage_pack_jobs",
		name_id = "menu_content_gage_pack_jobs",
		desc_id = "menu_content_gage_pack_jobs_desc",
		date_id = "menu_content_gage_pack_jobs_date",
		store = 259381,
		image = "guis/textures/pd2/content_updates/gage_pack_jobs"
	}
	local gage_pack_snp = {
		id = "gage_pack_snp",
		name_id = "menu_content_gage_pack_snp",
		desc_id = "menu_content_gage_pack_snp_desc",
		date_id = "menu_content_gage_pack_snp_date",
		store = 259380,
		image = "guis/textures/pd2/content_updates/gage_pack_snp"
	}
	local kosugi = {
		id = "kosugi",
		name_id = "menu_content_kosugi",
		desc_id = "menu_content_kosugi_desc",
		date_id = "menu_content_kosugi_date",
		store = 267382,
		image = "guis/textures/pd2/content_updates/kosugi"
	}
	local big_bank = {
		id = "big_bank",
		name_id = "menu_content_big_bank",
		desc_id = "menu_content_big_bank_desc",
		date_id = "menu_content_big_bank_date",
		store = 306690,
		image = "guis/dlcs/big_bank/textures/pd2/content_updates/big_bank"
	}
	local gage_pack_shotgun = {
		id = "gage_pack_shotgun",
		name_id = "menu_content_gage_pack_shotgun",
		desc_id = "menu_content_gage_pack_shotgun_desc",
		date_id = "menu_content_gage_pack_shotgun_date",
		store = 311050,
		image = "guis/dlcs/gage_pack_shotgun/textures/pd2/content_updates/gage_pack_shotgun"
	}
	local gage_pack_assault = {
		id = "gage_pack_assault",
		name_id = "menu_content_gage_pack_assault",
		desc_id = "menu_content_gage_pack_assault_desc",
		date_id = "menu_content_gage_pack_assault_date",
		store = 320030,
		image = "guis/dlcs/gage_pack_assault/textures/pd2/content_updates/gage_pack_assault"
	}
	local jukebox = {
		id = "jukebox",
		name_id = "menu_content_jukebox",
		desc_id = "menu_content_jukebox_desc",
		date_id = "menu_content_jukebox_date",
		webpage = "http://www.overkillsoftware.com/bigfatmusicupdate/",
		image = "guis/textures/pd2/content_updates/jukebox"
	}
	local hl_miami = {
		id = "hl_miami",
		name_id = "menu_content_hl_miami",
		desc_id = "menu_content_hl_miami_desc",
		date_id = "menu_content_hl_miami_date",
		store = 323500,
		image = "guis/dlcs/hl_miami/textures/pd2/content_updates/hl_miami"
	}
	local crimefest = {
		id = "crimefest",
		name_id = "menu_content_crimefest",
		desc_id = "menu_content_crimefest_desc",
		date_id = "menu_content_crimefest_date",
		webpage = "http://www.overkillsoftware.com/crimefest/mrated.html",
		image = "guis/textures/pd2/content_updates/crimefest"
	}
	local jowi = {
		id = "jowi",
		name_id = "menu_content_jowi",
		desc_id = "menu_content_jowi_desc",
		date_id = "menu_content_jowi_date",
		store = 330010,
		image = "guis/textures/pd2/content_updates/jowi"
	}
	local hoxton_char = {
		id = "hoxton_char",
		name_id = "menu_content_hoxton_char",
		desc_id = "menu_content_hoxton_char_desc",
		date_id = "menu_content_hoxton_char_date",
		store = 330490,
		image = "guis/textures/pd2/content_updates/hoxton_char"
	}
	local hoxton_job = {
		id = "hoxton_job",
		name_id = "menu_content_hoxton_job",
		desc_id = "menu_content_hoxton_job_desc",
		date_id = "menu_content_hoxton_job_date",
		store = 330491,
		image = "guis/textures/pd2/content_updates/hoxton_job"
	}
	local halloween_2014 = {
		id = "halloween_2014",
		name_id = "menu_content_halloween_2014",
		desc_id = "menu_content_halloween_2014_desc",
		date_id = "menu_content_halloween_2014_date",
		webpage = "http://www.overkillsoftware.com/halloween/",
		image = "guis/textures/pd2/content_updates/halloween_2014"
	}
	local gage_pack_historical = {
		id = "gage_pack_historical",
		name_id = "menu_content_gage_pack_historical",
		desc_id = "menu_content_gage_pack_historical_desc",
		date_id = "menu_content_gage_pack_historical_date",
		store = 331900,
		image = "guis/dlcs/gage_pack_historical/textures/pd2/content_updates/gage_pack_historical"
	}
	local christmas_2014 = {
		id = "christmas_2014",
		name_id = "menu_content_christmas_2014",
		desc_id = "menu_content_christmas_2014_desc",
		date_id = "menu_content_christmas_2014_date",
		webpage = "http://www.overkillsoftware.com/whitechristmas/",
		image = "guis/dlcs/pines/textures/pd2/content_updates/christmas_2014"
	}
	local character_pack_clover = {
		id = "character_pack_clover",
		name_id = "menu_content_character_pack_clover",
		desc_id = "menu_content_character_pack_clover_desc",
		date_id = "menu_content_character_pack_clover_date",
		store = 337661,
		image = "guis/dlcs/character_pack_clover/textures/pd2/content_updates/character_pack_clover"
	}
	local hope_diamond = {
		id = "hope_diamond",
		name_id = "menu_content_hope_diamond",
		desc_id = "menu_content_hope_diamond_desc",
		date_id = "menu_content_hope_diamond_date",
		store = 337660,
		image = "guis/dlcs/character_pack_clover/textures/pd2/content_updates/hope_diamond"
	}
	local hw_boxing = {
		id = "hw_boxing",
		name_id = "menu_content_hw_boxing",
		desc_id = "menu_content_hw_boxing_desc",
		date_id = "menu_content_hw_boxing_date",
		webpage = "http://www.overkillsoftware.com/happynewyear/",
		image = "guis/dlcs/pd2_hw_boxing/textures/pd2/content_updates/hw_boxing"
	}
	local character_pack_dragan = {
		id = "character_pack_dragan",
		name_id = "menu_content_character_pack_dragan",
		desc_id = "menu_content_character_pack_dragan_desc",
		date_id = "menu_content_character_pack_dragan_date",
		store = 344140,
		image = "guis/dlcs/character_pack_dragan/textures/pd2/content_updates/dragan"
	}
	local the_bomb = {
		id = "the_bomb",
		name_id = "menu_content_the_bomb",
		desc_id = "menu_content_the_bomb_desc",
		date_id = "menu_content_the_bomb_date",
		store = 339480,
		image = "guis/dlcs/the_bomb/textures/pd2/content_updates/the_bomb"
	}
	local akm4_pack = {
		id = "akm4_pack",
		name_id = "menu_content_akm4_pack",
		desc_id = "menu_content_akm4_pack_desc",
		date_id = "menu_content_akm4_pack_date",
		store = 351890,
		image = "guis/dlcs/dlc_akm4/textures/pd2/content_updates/akm4_pack"
	}
	local infamy_2_0 = {
		id = "infamy_2_0",
		name_id = "menu_content_infamy_2_0",
		desc_id = "menu_content_infamy_2_0_desc",
		date_id = "menu_content_infamy_2_0_date",
		webpage = "http://www.overkillsoftware.com/games/infamy2/",
		image = "guis/dlcs/infamous/textures/pd2/content_updates/infamy_2_0"
	}
	local overkill_pack = {
		id = "overkill_pack",
		name_id = "menu_content_overkill_pack",
		desc_id = "menu_content_overkill_pack_desc",
		date_id = "menu_content_overkill_pack_date",
		store = 348090,
		image = "guis/dlcs/dlc_pack_overkill/textures/pd2/content_updates/overkill_pack"
	}
	local complete_overkill_pack = {
		id = "complete_overkill_pack",
		name_id = "menu_content_complete_overkill_pack",
		desc_id = "menu_content_complete_overkill_pack_desc",
		date_id = "menu_content_complete_overkill_pack_date",
		webpage = "http://www.overkillsoftware.com/thehypetrain/",
		image = "guis/dlcs/dlc_pack_overkill/textures/pd2/content_updates/complete_overkill_pack"
	}
	local hlm2 = {
		id = "hlm2",
		name_id = "menu_content_hlm2",
		desc_id = "menu_content_hlm2_desc",
		date_id = "menu_content_hlm2_date",
		store = 274170,
		image = "guis/dlcs/hlm2/textures/pd2/content_updates/hlm2"
	}
	local hlm2_deluxe = {
		id = "hlm2_deluxe",
		name_id = "menu_content_hlm2_deluxe",
		desc_id = "menu_content_hlm2_deluxe_desc",
		date_id = "menu_content_hlm2_deluxe_date",
		store = 274170,
		image = "guis/dlcs/hlm2/textures/pd2/content_updates/hlm2_deluxe"
	}
	local bbq = {
		id = "bbq",
		name_id = "menu_content_bbq",
		desc_id = "menu_content_bbq_desc",
		date_id = "menu_content_bbq_date",
		store = 337661,
		webpage = "http://www.overkillsoftware.com/bbq/",
		image = "guis/textures/pd2/content_updates/bbq"
	}
	local springbreak = {
		id = "springbreak",
		name_id = "menu_content_springbreak",
		desc_id = "menu_content_springbreak_desc",
		date_id = "menu_content_springbreak_date",
		webpage = "http://www.overkillsoftware.com/springbreak/",
		image = "guis/textures/pd2/content_updates/springbreak"
	}
	local bbq = {
		id = "bbq",
		name_id = "menu_content_bbq",
		desc_id = "menu_content_bbq_desc",
		date_id = "menu_content_bbq_date",
		store = 358150,
		image = "guis/dlcs/bbq/textures/pd2/content_updates/bbq"
	}
	local fpsanimation = {
		id = "fpsanimation",
		name_id = "menu_content_fpsanimation",
		desc_id = "menu_content_fpsanimation_desc",
		date_id = "menu_content_fpsanimation_date",
		webpage = "http://www.overkillsoftware.com/animations-update/",
		image = "guis/textures/pd2/content_updates/fpsanimation"
	}
	local springcleaning = {
		id = "springcleaning",
		name_id = "menu_content_springcleaning",
		desc_id = "menu_content_springcleaning_desc",
		date_id = "menu_content_springcleaning_date",
		webpage = "http://steamcommunity.com/games/218620/announcements/detail/177107167839449807",
		image = "guis/textures/pd2/content_updates/springcleaning"
	}
	local west = {
		id = "west",
		name_id = "menu_content_west",
		desc_id = "menu_content_west_desc",
		date_id = "menu_content_west_date",
		store = 349830,
		image = "guis/dlcs/west/textures/pd2/content_updates/west"
	}
	local bsides = {
		id = "bsides",
		name_id = "menu_content_bsides",
		desc_id = "menu_content_bsides_desc",
		date_id = "menu_content_bsides_date",
		store = 368870,
		image = "guis/textures/pd2/content_updates/bsides"
	}
	local shoutout = {
		id = "shoutout",
		name_id = "menu_content_shoutout",
		desc_id = "menu_content_shoutout_desc",
		date_id = "menu_content_shoutout_date",
		webpage = "http://www.overkillsoftware.com/meltdown/",
		image = "guis/textures/pd2/content_updates/shoutout"
	}
	local arena = {
		id = "arena",
		name_id = "menu_content_arena",
		desc_id = "menu_content_arena_desc",
		date_id = "menu_content_arena_date",
		store = 366660,
		image = "guis/dlcs/dlc_arena/textures/pd2/content_updates/arena"
	}
	local character_pack_sokol = {
		id = "character_pack_sokol",
		name_id = "menu_content_character_pack_sokol",
		desc_id = "menu_content_character_pack_sokol_desc",
		date_id = "menu_content_character_pack_sokol_date",
		store = 374301,
		image = "guis/dlcs/character_pack_sokol/textures/pd2/content_updates/sokol"
	}
	local kenaz = {
		id = "kenaz",
		name_id = "menu_content_kenaz",
		desc_id = "menu_content_kenaz_desc",
		date_id = "menu_content_kenaz_date",
		store = 374300,
		image = "guis/dlcs/kenaz/textures/pd2/content_updates/kenaz"
	}
	local turtles = {
		id = "turtles",
		name_id = "menu_content_turtles",
		desc_id = "menu_content_turtles_desc",
		date_id = "menu_content_turtles_date",
		store = 384021,
		image = "guis/dlcs/turtles/textures/pd2/content_updates/turtles"
	}
	local dragon = {
		id = "dragon",
		name_id = "menu_content_dragon",
		desc_id = "menu_content_dragon_desc",
		date_id = "menu_content_dragon_date",
		store = 384020,
		image = "guis/dlcs/dragon/textures/pd2/content_updates/dragon"
	}
	local steel = {
		id = "steel",
		name_id = "menu_content_steel",
		desc_id = "menu_content_steel_desc",
		date_id = "menu_content_steel_date",
		store = 401650,
		image = "guis/dlcs/steel/textures/pd2/content_updates/steel"
	}
	local gordon = {
		id = "gordon",
		name_id = "menu_content_gordon",
		desc_id = "menu_content_gordon_desc",
		date_id = "menu_content_gordon_date",
		webpage = "http://www.overkillsoftware.com/fbifiles/",
		image = "guis/dlcs/gordon/textures/pd2/content_updates/gordon"
	}
	local rip = {
		id = "rip",
		name_id = "menu_content_rip",
		desc_id = "menu_content_rip_desc",
		date_id = "menu_content_rip_date",
		store = 422430,
		image = "guis/dlcs/rip/textures/pd2/content_updates/rip"
	}
	local berry = {
		id = "berry",
		name_id = "menu_content_berry",
		desc_id = "menu_content_berry_desc",
		date_id = "menu_content_berry_date",
		store = 422400,
		image = "guis/dlcs/berry/textures/pd2/content_updates/berry"
	}
	local cane = {
		id = "cane",
		name_id = "menu_content_cane",
		desc_id = "menu_content_cane_desc",
		date_id = "menu_content_cane_date",
		webpage = "http://www.overkillsoftware.com/games/christmas2015/",
		image = "guis/textures/pd2/content_updates/xmas2015"
	}
	local peta = {
		id = "peta",
		name_id = "menu_content_peta",
		desc_id = "menu_content_peta_desc",
		date_id = "menu_content_peta_date",
		store = 433730,
		image = "guis/dlcs/peta/textures/pd2/content_updates/peta"
	}
	local pal = {
		id = "pal",
		name_id = "menu_content_pal",
		desc_id = "menu_content_pal_desc",
		date_id = "menu_content_pal_date",
		store = 441600,
		image = "guis/dlcs/lupus/textures/pd2/content_updates/lupus"
	}
	self.content_updates = {
		title_id = "menu_content_updates",
		choice_id = "menu_content_updates_previous",
		num_items = 6
	}
	if SystemInfo:platform() == Idstring("WIN32") then
		self.content_updates.item_list = {
			soundtrack,
			diamond_store,
			birthday,
			halloween,
			armored_transport,
			gage_pack,
			charliesierra,
			christmas,
			infamy,
			gage_pack_lmg,
			deathwish,
			election_day,
			gage_pack_jobs,
			gage_pack_snp,
			kosugi,
			big_bank,
			gage_pack_shotgun,
			gage_pack_assault,
			jukebox,
			hl_miami,
			crimefest,
			jowi,
			hoxton_char,
			hoxton_job,
			halloween_2014,
			gage_pack_historical,
			christmas_2014,
			hope_diamond,
			character_pack_clover,
			hw_boxing,
			the_bomb,
			character_pack_dragan,
			akm4_pack,
			infamy_2_0,
			overkill_pack,
			complete_overkill_pack,
			hlm2,
			hlm2_deluxe,
			springbreak,
			bbq,
			west,
			springcleaning,
			bsides,
			shoutout,
			arena,
			kenaz,
			character_pack_sokol,
			turtles,
			dragon,
			steel,
			gordon,
			berry,
			rip,
			cane,
			peta,
			pal
		}
	elseif SystemInfo:platform() == Idstring("PS3") then
		self.content_updates.item_list = {
			armored_transport,
			gage_pack,
			gage_pack_lmg
		}
	elseif SystemInfo:platform() == Idstring("PS4") then
		self.content_updates.item_list = {armored_transport}
	elseif SystemInfo:platform() == Idstring("XB1") then
		self.content_updates.item_list = {armored_transport}
	elseif SystemInfo:platform() == Idstring("X360") then
		self.content_updates.item_list = {}
	end
	self.fav_videos = {
		title_id = "menu_fav_videos",
		choice_id = nil,
		num_items = 3,
		db_url = "http://www.overkillsoftware.com/?page_id=1263",
		button = {
			text_id = "menu_fav_video_homepage",
			url = "http://www.overkillsoftware.com/?page_id=1263"
		},
		item_list = {
			{
				id = "fav3",
				image = "guis/textures/pd2/fav_video3",
				use_db = true
			},
			{
				id = "fav2",
				image = "guis/textures/pd2/fav_video2",
				use_db = true
			},
			{
				id = "fav1",
				image = "guis/textures/pd2/fav_video1",
				use_db = true
			}
		}
	}
	self.masks_sort_order = {
		"aviator",
		"plague",
		"welder",
		"smoker",
		"ghost",
		"skullhard",
		"skullveryhard",
		"skulloverkill",
		"skulloverkillplus"
	}
	self.blackscreen_risk_textures = {
		overkill_290 = "guis/textures/pd2/risklevel_deathwish_blackscreen"
	}
	self.suspicion_to_visibility = {}
	self.suspicion_to_visibility[1] = {}
	self.suspicion_to_visibility[1].name_id = "bm_menu_concealment_low"
	self.suspicion_to_visibility[1].max_index = 9
	self.suspicion_to_visibility[2] = {}
	self.suspicion_to_visibility[2].name_id = "bm_menu_concealment_medium"
	self.suspicion_to_visibility[2].max_index = 20
	self.suspicion_to_visibility[3] = {}
	self.suspicion_to_visibility[3].name_id = "bm_menu_concealment_high"
	self.suspicion_to_visibility[3].max_index = 30
	self.mouse_pointer = {}
	self.mouse_pointer.controller = {}
	self.mouse_pointer.controller.acceleration_speed = 4
	self.mouse_pointer.controller.max_acceleration = 3
	self.mouse_pointer.controller.mouse_pointer_speed = 125
	local min_amount_masks = 160
	self.MASK_ROWS_PER_PAGE = 4
	self.MASK_COLUMNS_PER_PAGE = 4
	self.MAX_MASK_PAGES = math.ceil(min_amount_masks / (self.MASK_ROWS_PER_PAGE * self.MASK_COLUMNS_PER_PAGE))
	self.MAX_MASK_SLOTS = self.MAX_MASK_PAGES * self.MASK_ROWS_PER_PAGE * self.MASK_COLUMNS_PER_PAGE
	local min_amount_weapons = 160
	self.WEAPON_ROWS_PER_PAGE = 4
	self.WEAPON_COLUMNS_PER_PAGE = 4
	self.MAX_WEAPON_PAGES = math.ceil(min_amount_weapons / (self.WEAPON_ROWS_PER_PAGE * self.WEAPON_COLUMNS_PER_PAGE))
	self.MAX_WEAPON_SLOTS = self.MAX_WEAPON_PAGES * self.WEAPON_ROWS_PER_PAGE * self.WEAPON_COLUMNS_PER_PAGE
	self.fbi_files_webpage = "http://fbi.overkillsoftware.com/"
	self.crimefest_challenges_webpage = "http://www.overkillsoftware.com/games/roadtocrimefest/"
	self.crime_net = {}
	self.crime_net.controller = {}
	self.crime_net.controller.snap_distance = 50
	self.crime_net.controller.snap_speed = 5
	self.crime_net.job_vars = {}
	self.crime_net.job_vars.max_active_jobs = 10
	self.crime_net.job_vars.active_job_time = 25
	self.crime_net.job_vars.new_job_min_time = 1.5
	self.crime_net.job_vars.new_job_max_time = 3.5
	self.crime_net.job_vars.refresh_servers_time = 5
	self.crime_net.job_vars.total_active_jobs = 40
	self.crime_net.job_vars.max_active_server_jobs = 100
	self.crime_net.debug_options = {}
	self.crime_net.debug_options.regions = false
	self.crime_net.debug_options.mass_spawn = false
	self.crime_net.debug_options.mass_spawn_limit = 100
	self.crime_net.debug_options.mass_spawn_timer = 0.04
	self.rename_max_letters = 20
	self.rename_skill_set_max_letters = 15
	self.mod_preview_min_fov = -20
	self.mod_preview_max_fov = 3
	self.stats_present_multiplier = 10
	self.armor_damage_shake_base = 1.1
	self.buy_weapon_category_groups = {
		grenade_launcher = "wpn_special",
		saw = "wpn_special",
		minigun = "wpn_special",
		flamethrower = "wpn_special",
		bow = "wpn_special",
		crossbow = "wpn_special"
	}
	self.LONGEST_CHAR_NAME = "JOHN WICK"
	self.crime_net.regions = {
		{
			closed = true,
			text = {
				title_id = "cn_menu_georgetown_title",
				x = 348,
				y = 310
			},
			{
				-10,
				270,
				293,
				252,
				271,
				337,
				341,
				372,
				372,
				475,
				475,
				491,
				491,
				504,
				503,
				524,
				536,
				536,
				542,
				542,
				555,
				555,
				598,
				598,
				638,
				638,
				657,
				688,
				686,
				691,
				701,
				698,
				687,
				650,
				634,
				602,
				609,
				580,
				576,
				576,
				567,
				559,
				558,
				542,
				543,
				512,
				512,
				503,
				381,
				377,
				348,
				315,
				315,
				290,
				290,
				259,
				259,
				237,
				237,
				261,
				261,
				257,
				224,
				221,
				187,
				182,
				163,
				163,
				147,
				147,
				133,
				133,
				102,
				102,
				-10
			},
			{
				-10,
				-10,
				28,
				73,
				122,
				123,
				132,
				141,
				145,
				172,
				216,
				215,
				180,
				179,
				229,
				228,
				244,
				253,
				253,
				248,
				247,
				241,
				241,
				219,
				219,
				209,
				208,
				234,
				241,
				242,
				262,
				270,
				277,
				276,
				279,
				296,
				300,
				362,
				361,
				408,
				416,
				417,
				430,
				430,
				477,
				477,
				514,
				523,
				523,
				514,
				514,
				501,
				493,
				484,
				469,
				469,
				465,
				465,
				439,
				440,
				434,
				430,
				429,
				433,
				433,
				438,
				438,
				423,
				423,
				435,
				435,
				423,
				423,
				412,
				412
			}
		},
		{
			closed = true,
			{
				340,
				350,
				350,
				373,
				373,
				368,
				368,
				358,
				358,
				351,
				351,
				340
			},
			{
				103,
				103,
				106,
				106,
				116,
				116,
				123,
				123,
				116,
				116,
				122,
				121
			}
		},
		{
			closed = true,
			{
				564,
				576,
				576,
				564
			},
			{
				189,
				189,
				208,
				208
			}
		},
		{
			closed = true,
			{
				147,
				168,
				164,
				144
			},
			{
				444,
				451,
				463,
				457
			}
		},
		{
			closed = true,
			{
				168,
				185,
				181,
				166
			},
			{
				463,
				468,
				478,
				473
			}
		},
		{
			closed = true,
			{
				371,
				417,
				417,
				414,
				371
			},
			{
				534,
				534,
				554,
				557,
				538
			}
		},
		{
			closed = true,
			{
				422,
				509,
				509,
				500,
				500,
				477,
				477,
				466,
				457,
				457,
				447,
				422
			},
			{
				534,
				534,
				548,
				559,
				585,
				585,
				575,
				581,
				581,
				573,
				573,
				557
			}
		},
		{
			closed = true,
			text = {
				title_id = "cn_menu_westend_title",
				x = 789,
				y = 418
			},
			{
				519,
				530,
				517,
				528,
				522,
				540,
				538,
				544,
				549,
				561,
				565,
				571,
				566,
				574,
				579,
				609,
				613,
				630,
				628,
				644,
				641,
				662,
				665,
				703,
				696,
				721,
				721,
				756,
				756,
				767,
				767,
				736,
				709,
				701,
				651,
				651,
				640,
				623,
				634,
				608,
				591,
				581,
				599,
				599,
				551,
				541,
				598,
				598,
				640,
				735,
				735,
				751,
				760,
				766,
				771,
				831,
				831,
				882,
				882,
				922,
				922,
				976,
				976,
				1031,
				1036,
				1019,
				1020,
				994,
				1063,
				1063,
				1068,
				1098,
				1104,
				1113,
				1123,
				1132,
				1175,
				1175,
				1184,
				1184,
				1171,
				1171,
				1161,
				1161,
				1169,
				1169,
				1185,
				1185,
				1168,
				1168,
				1175,
				1175,
				1193,
				1193,
				1175,
				1175,
				1170,
				1170,
				1190,
				1190,
				1171,
				1171
			},
			{
				-10,
				13,
				23,
				34,
				42,
				57,
				61,
				68,
				63,
				75,
				69,
				74,
				79,
				87,
				82,
				113,
				110,
				128,
				131,
				144,
				148,
				169,
				165,
				199,
				207,
				226,
				239,
				258,
				276,
				284,
				305,
				341,
				340,
				331,
				331,
				343,
				338,
				364,
				369,
				428,
				428,
				452,
				460,
				514,
				514,
				540,
				540,
				586,
				636,
				636,
				552,
				549,
				545,
				539,
				529,
				529,
				533,
				533,
				530,
				530,
				537,
				537,
				530,
				530,
				521,
				483,
				480,
				416,
				382,
				345,
				340,
				353,
				348,
				346,
				346,
				350,
				328,
				297,
				297,
				269,
				269,
				247,
				247,
				222,
				222,
				182,
				182,
				170,
				170,
				116,
				116,
				111,
				111,
				85,
				85,
				68,
				68,
				60,
				60,
				31,
				31,
				-10
			}
		},
		{
			closed = false,
			text = {
				title_id = "cn_menu_foggy_bottom_title",
				x = 858,
				y = 704
			},
			{
				1031,
				1052,
				1039,
				1039,
				1045,
				1045,
				1039,
				1039,
				1000,
				990,
				972,
				972,
				927,
				908,
				901,
				882,
				882,
				722,
				693,
				693,
				686,
				685,
				676,
				676,
				688,
				693,
				730,
				730,
				679,
				670,
				664,
				664,
				667,
				667,
				673,
				669,
				674,
				652,
				652
			},
			{
				530,
				574,
				575,
				616,
				616,
				667,
				667,
				893,
				893,
				883,
				883,
				855,
				855,
				842,
				853,
				853,
				906,
				906,
				874,
				816,
				816,
				804,
				804,
				785,
				785,
				774,
				774,
				759,
				759,
				754,
				745,
				734,
				726,
				691,
				686,
				683,
				677,
				657,
				636
			}
		},
		{
			closed = true,
			{
				512,
				529,
				516,
				519,
				513,
				495,
				498,
				501,
				504,
				500
			},
			{
				597,
				616,
				627,
				630,
				634,
				609,
				607,
				611,
				609,
				604
			}
		},
		{
			closed = true,
			{
				559,
				569,
				571,
				639,
				631,
				647,
				616,
				616,
				610,
				610,
				601,
				598,
				589,
				580,
				569,
				561,
				557,
				557,
				584,
				584,
				580,
				591,
				589,
				580,
				570,
				564,
				568,
				563,
				558,
				561,
				552,
				546,
				550,
				549
			},
			{
				601,
				611,
				609,
				666,
				679,
				692,
				732,
				792,
				792,
				814,
				814,
				822,
				831,
				833,
				831,
				825,
				815,
				721,
				721,
				710,
				706,
				697,
				688,
				686,
				693,
				683,
				676,
				658,
				650,
				646,
				619,
				614,
				610,
				608
			}
		},
		{
			closed = false,
			text = {
				title_id = "cn_menu_shaw_title",
				x = 1426,
				y = 310
			},
			{
				2047,
				1972,
				1879,
				1879,
				1735,
				1677,
				1677,
				1683,
				1625,
				1619,
				1624,
				1620,
				1641,
				1641,
				1572,
				1571,
				1558,
				1558,
				1547,
				1547,
				1523,
				1523,
				1462,
				1462,
				1450,
				1450,
				1422,
				1402,
				1402,
				1356,
				1356,
				1316,
				1316,
				1308,
				1308,
				1279,
				1279,
				1245,
				1245,
				1200,
				1200,
				1039
			},
			{
				278,
				311,
				311,
				352,
				416,
				416,
				429,
				440,
				468,
				461,
				458,
				451,
				442,
				420,
				420,
				470,
				470,
				467,
				467,
				469,
				469,
				518,
				518,
				532,
				532,
				547,
				560,
				560,
				570,
				569,
				591,
				610,
				604,
				604,
				614,
				628,
				614,
				614,
				644,
				665,
				608,
				608
			}
		},
		{
			closed = false,
			text = {
				title_id = "cn_menu_downtown_title",
				x = 1469,
				y = 720
			},
			{
				1200,
				1206,
				1206,
				1201,
				1201,
				1251,
				1251,
				1201,
				1201,
				1205,
				1254,
				1254,
				1285,
				1285,
				1308,
				1308,
				1372,
				1372,
				1388,
				1388,
				1411,
				1411,
				1462,
				1462,
				1523,
				1523,
				1538,
				1538,
				1528,
				1527,
				1709,
				1709,
				1760,
				1880,
				1880,
				2047
			},
			{
				665,
				669,
				688,
				688,
				741,
				760,
				787,
				787,
				898,
				902,
				902,
				896,
				896,
				902,
				902,
				896,
				896,
				903,
				903,
				896,
				896,
				898,
				898,
				889,
				889,
				901,
				901,
				920,
				920,
				953,
				953,
				902,
				902,
				798,
				609,
				609
			}
		}
	}
	self.crime_net.map_start_positions = {
		{
			max_level = 10,
			x = 1080,
			y = 512,
			zoom = 4
		},
		{
			max_level = 20,
			x = 1080,
			y = 512,
			zoom = 4
		},
		{
			max_level = 30,
			x = 1080,
			y = 512,
			zoom = 4
		},
		{
			max_level = 40,
			x = 1080,
			y = 512,
			zoom = 4
		},
		{
			max_level = 50,
			x = 1080,
			y = 512,
			zoom = 4
		},
		{
			max_level = 60,
			x = 1080,
			y = 512,
			zoom = 4
		},
		{
			max_level = 70,
			x = 1080,
			y = 512,
			zoom = 4
		},
		{
			max_level = 80,
			x = 1080,
			y = 512,
			zoom = 4
		},
		{
			max_level = 90,
			x = 1080,
			y = 512,
			zoom = 4
		},
		{
			max_level = 100,
			x = 1080,
			y = 512,
			zoom = 4
		}
	}
	self.crime_net.special_contracts = {
		{
			id = "gage_assignment",
			name_id = "menu_cn_gage_assignment",
			desc_id = "menu_cn_gage_assignment_desc",
			menu_node = "crimenet_gage_assignment",
			x = 425,
			y = 910,
			icon = "guis/textures/pd2/crimenet_marker_gage",
			dlc = "gage_pack_jobs"
		},
		{
			id = "premium_buy",
			name_id = "menu_cn_premium_buy",
			desc_id = "menu_cn_premium_buy_desc",
			menu_node = "crimenet_contract_special",
			x = 420,
			y = 846,
			icon = "guis/textures/pd2/crimenet_marker_buy"
		},
		{
			id = "contact_info",
			name_id = "menu_cn_contact_info",
			desc_id = "menu_cn_contact_info_desc",
			menu_node = "crimenet_contact_info",
			x = 912,
			y = 905,
			icon = "guis/textures/pd2/crimenet_marker_codex"
		},
		{
			id = "casino",
			name_id = "menu_cn_casino",
			desc_id = "menu_cn_casino_desc",
			menu_node = "crimenet_contract_casino",
			x = 125,
			y = 790,
			icon = "guis/textures/pd2/crimenet_casino",
			unlock = "unlock_level",
			pulse = false,
			pulse_color = Color(204, 255, 209, 32) / 255
		}
	}
	self.crime_net.codex = {
		{
			id = "contacts",
			name_id = "menu_contacts",
			{
				id = "bain",
				name_id = "heist_contact_bain",
				{
					desc_id = "heist_contact_bain_description",
					video = "bain",
					post_event = "pln_contact_bain"
				}
			},
			{
				id = "vlad",
				name_id = "heist_contact_vlad",
				{
					desc_id = "heist_contact_vlad_description",
					videos = {
						"vlad1",
						"vlad2",
						"vlad3"
					},
					post_event = "vld_quote_set_a"
				}
			},
			{
				id = "hector",
				name_id = "heist_contact_hector",
				{
					desc_id = "heist_contact_hector_description",
					videos = {
						"hector1",
						"hector2",
						"hector3"
					},
					post_event = "hct_quote_set_a"
				}
			},
			{
				id = "the_elephant",
				name_id = "heist_contact_the_elephant",
				{
					desc_id = "heist_contact_the_elephant_description",
					videos = {
						"the_elephant1",
						"the_elephant2",
						"the_elephant3"
					},
					post_event = "elp_quote_set_a"
				}
			},
			{
				id = "gage",
				name_id = "heist_contact_gage",
				{
					desc_id = "heist_contact_gage_description",
					videos = {
						"gage1",
						"gage2",
						"gage3"
					},
					post_event = "pln_contact_gage"
				}
			},
			{
				id = "the_dentist",
				name_id = "heist_contact_the_dentist",
				{
					desc_id = "heist_contact_the_dentist_description",
					videos = {
						"the_dentist1",
						"the_dentist2",
						"the_dentist3",
						"the_dentist4",
						"the_dentist5",
						"the_dentist6"
					},
					post_event = "dentist_quote_set_a"
				}
			},
			{
				id = "the_butcher",
				name_id = "heist_contact_the_butcher",
				{
					desc_id = "heist_contact_the_butcher_description",
					videos = {
						"the_butcher1",
						"the_butcher2",
						"the_butcher3"
					},
					post_event = "butcher_quote_set_a"
				}
			},
			{
				id = "locke",
				name_id = "heist_contact_locke",
				{
					desc_id = "heist_contact_locke_description",
					videos = {"locke1"},
					post_event = "loc_quote_set_a"
				}
			}
		},
		{
			id = "playable_characters",
			name_id = "menu_playable_characters",
			{
				id = "dallas",
				name_id = "menu_russian",
				{
					desc_id = "russian_desc_codex",
					videos = {
						"dallas1",
						"dallas2",
						"dallas3"
					},
					post_event = "pln_contact_dallas"
				}
			},
			{
				id = "wolf",
				name_id = "menu_german",
				{
					desc_id = "german_desc_codex",
					videos = {"wolf1", "wolf2"},
					post_event = "pln_contact_wolf"
				}
			},
			{
				id = "chains",
				name_id = "menu_spanish",
				{
					desc_id = "spanish_desc_codex",
					videos = {
						"chains1",
						"chains2",
						"chains3"
					},
					post_event = "pln_contact_chains"
				}
			},
			{
				id = "old_hoxton",
				name_id = "menu_old_hoxton",
				{
					desc_id = "old_hoxton_desc_codex",
					videos = {
						"old_hoxton1",
						"old_hoxton2"
					},
					post_event = "pln_contact_hoxton"
				}
			},
			{
				id = "jowi",
				name_id = "menu_jowi",
				{
					desc_id = "jowi_desc_codex",
					videos = {
						"jowi1",
						"jowi2",
						"jowi3",
						"jowi4"
					},
					post_event = "pln_contact_wick"
				}
			},
			{
				id = "hoxton",
				name_id = "menu_american",
				{
					desc_id = "american_desc_codex",
					videos = {
						"hoxton1",
						"hoxton2",
						"hoxton3"
					},
					post_event = "pln_contact_houston"
				},
				{
					desc_id = "houston_desc_codex",
					videos = {
						"hoxton1",
						"hoxton2",
						"hoxton3"
					},
					post_event = "pln_contact_houston"
				}
			},
			{
				id = "clover",
				name_id = "menu_clover",
				{
					desc_id = "menu_clover_desc_codex",
					videos = {"clover1", "clover2"},
					post_event = "pln_contact_clover"
				}
			},
			{
				id = "dragan",
				name_id = "menu_dragan",
				{
					desc_id = "menu_dragan_desc_codex",
					videos = {
						"dragan1",
						"dragan2",
						"dragan3"
					},
					post_event = "pln_contact_dragan"
				}
			},
			{
				id = "jacket",
				name_id = "menu_jacket",
				{
					desc_id = "menu_jacket_desc_codex",
					videos = {"jacket1", "jacket2"},
					post_event = "pln_contact_jacket"
				}
			},
			{
				id = "bonnie",
				name_id = "menu_bonnie",
				{
					desc_id = "menu_bonnie_desc_codex",
					videos = {"bonnie1"},
					post_event = "pln_contact_bonnie"
				}
			},
			{
				id = "sokol",
				name_id = "menu_sokol",
				{
					desc_id = "menu_sokol_desc_codex",
					videos = {"sokol1"},
					post_event = "pln_contact_sokol"
				}
			},
			{
				id = "dragon",
				name_id = "menu_dragon",
				{
					desc_id = "menu_dragon_desc_codex",
					videos = {"dragon1"},
					post_event = "pln_contact_jiro"
				}
			},
			{
				id = "bodhi",
				name_id = "menu_bodhi",
				{
					desc_id = "menu_bodhi_desc_codex",
					videos = {"bodhi1"},
					post_event = "pln_contact_bodhi"
				}
			}
		}
	}
	self.crime_net.locations = {}
	if not Application:production_build() or SystemInfo:platform() ~= Idstring("WIN32") then
		self.crime_net.locations = {
			{
				{
					dots = {
						{1601, 425},
						{1025, 835},
						{444, 567},
						{1221, 685},
						{1603, 555},
						{1401, 620},
						{1581, 685},
						{1306, 750},
						{1486, 815},
						{1666, 750},
						{1450, 880},
						{1041, 620},
						{730, 880},
						{883, 555},
						{861, 685},
						{766, 815},
						{946, 750},
						{1480, 165},
						{1304, 295},
						{1484, 230},
						{1664, 295},
						{1241, 425},
						{1421, 360},
						{1063, 490},
						{1243, 555},
						{1423, 490},
						{1120, 165},
						{1124, 230},
						{760, 165},
						{764, 230},
						{944, 295},
						{701, 360},
						{681, 620},
						{881, 425},
						{703, 490},
						{400, 165},
						{404, 230},
						{584, 295},
						{343, 490},
						{224, 295},
						{341, 360},
						{521, 425},
						{586, 750}
					},
					weight = 100
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain",
						"the_dentist",
						"the_butcher"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			}
		}
	else
		self.crime_net.locations = {
			{
				{
					weight = 500,
					{
						558,
						558,
						566,
						579,
						591,
						600,
						608,
						607,
						614,
						616
					},
					{
						722,
						812,
						824,
						832,
						827,
						811,
						810,
						788,
						790,
						722
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 500,
					{
						610,
						644,
						555,
						591,
						593,
						582,
						585
					},
					{
						733,
						691,
						620,
						685,
						699,
						705,
						724
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						567,
						570,
						589,
						559,
						563,
						571
					},
					{
						683,
						690,
						684,
						623,
						652,
						678
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						627,
						636,
						568,
						556,
						549
					},
					{
						684,
						665,
						610,
						604,
						614
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						498,
						505,
						505,
						513,
						527,
						517,
						514
					},
					{
						611,
						611,
						602,
						598,
						615,
						624,
						632
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						372,
						416,
						416
					},
					{
						535,
						557,
						533
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						149,
						145,
						164,
						167
					},
					{
						446,
						455,
						462,
						452
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						168,
						167,
						182,
						184
					},
					{
						465,
						472,
						477,
						469
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						424,
						506,
						508,
						467,
						423
					},
					{
						535,
						536,
						549,
						581,
						556
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						479,
						499,
						498,
						471
					},
					{
						583,
						583,
						535,
						534
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 500,
					{
						212,
						558,
						554,
						203
					},
					{
						432,
						430,
						248,
						251
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {"normal"}
				}
			},
			{
				{
					weight = 10,
					{
						240,
						543,
						542,
						241
					},
					{
						440,
						442,
						477,
						464
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {"normal"}
				}
			},
			{
				{
					weight = 500,
					{
						260,
						291,
						289,
						315,
						315,
						346,
						511,
						511
					},
					{
						432,
						472,
						483,
						493,
						500,
						514,
						514,
						407
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						376,
						382,
						502,
						511,
						511,
						542,
						542,
						510
					},
					{
						510,
						522,
						519,
						512,
						473,
						441,
						420,
						421
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						554,
						567,
						577,
						574,
						609,
						556,
						522
					},
					{
						416,
						416,
						407,
						360,
						302,
						247,
						291
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						598,
						630,
						690,
						701,
						679,
						659,
						639,
						639,
						596
					},
					{
						298,
						276,
						275,
						266,
						229,
						210,
						211,
						219,
						219
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						536,
						524,
						505,
						504,
						491,
						491,
						472,
						470
					},
					{
						253,
						232,
						229,
						180,
						180,
						215,
						215,
						261
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 500,
					{
						205,
						202,
						339,
						373,
						474,
						472
					},
					{
						251,
						123,
						125,
						147,
						173,
						267
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						564,
						563,
						576,
						576
					},
					{
						190,
						206,
						207,
						191
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 1,
					{
						341,
						349,
						358,
						372,
						373,
						369,
						367,
						359,
						358,
						349,
						349,
						340
					},
					{
						103,
						105,
						108,
						107,
						115,
						115,
						122,
						121,
						116,
						115,
						121,
						120
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						553,
						628,
						628,
						555
					},
					{
						243,
						245,
						282,
						326
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						148,
						166,
						164,
						185,
						189,
						224,
						225,
						135
					},
					{
						422,
						423,
						436,
						436,
						432,
						432,
						123,
						125
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 500,
					{
						553,
						544,
						774,
						832,
						879,
						925,
						977,
						988,
						1036,
						874,
						735,
						599,
						598
					},
					{
						514,
						538,
						527,
						528,
						533,
						527,
						534,
						527,
						529,
						161,
						342,
						458,
						515
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 50,
					{
						585,
						602,
						598,
						641,
						734,
						732,
						760,
						772,
						609,
						591
					},
					{
						452,
						462,
						584,
						637,
						635,
						552,
						544,
						527,
						429,
						429
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 25,
					{
						740,
						708,
						702,
						652,
						650,
						640,
						625,
						635,
						602,
						743
					},
					{
						343,
						343,
						333,
						333,
						344,
						339,
						363,
						368,
						443,
						437
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 500,
					{
						983,
						1059,
						1059,
						656,
						707,
						755,
						833
					},
					{
						423,
						384,
						162,
						162,
						199,
						258,
						393
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1058,
						1094,
						1112,
						1133,
						1174,
						1172,
						1183,
						1183,
						1170,
						1170,
						1049
					},
					{
						337,
						349,
						345,
						349,
						328,
						296,
						296,
						269,
						268,
						248,
						248
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 500,
					{
						1053,
						1168,
						1149,
						1004,
						872
					},
					{
						162,
						166,
						340,
						341,
						162
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 500,
					{
						997,
						1071,
						1201,
						1886,
						1879,
						1197,
						1206
					},
					{
						418,
						609,
						608,
						253,
						105,
						110,
						325
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 50,
					{
						1045,
						1115,
						1127,
						1110,
						1092,
						1072,
						1066,
						1058,
						1041
					},
					{
						604,
						607,
						354,
						351,
						358,
						347,
						352,
						578,
						576
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1204,
						1239,
						1239,
						1280,
						1280,
						1305,
						1307,
						1200
					},
					{
						658,
						642,
						606,
						612,
						624,
						613,
						536,
						590
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1306,
						1318,
						1352,
						1354,
						1399,
						1401,
						1284
					},
					{
						602,
						606,
						589,
						565,
						568,
						487,
						539
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 25,
					{
						1399,
						1426,
						1446,
						1447,
						1460,
						1460,
						1522,
						1521,
						1376
					},
					{
						559,
						556,
						545,
						529,
						527,
						513,
						516,
						423,
						481
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1521,
						1569,
						1571,
						1510
					},
					{
						466,
						465,
						394,
						411
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						1625,
						1625,
						1678,
						1676,
						1643,
						1642
					},
					{
						455,
						465,
						441,
						416,
						418,
						445
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 50,
					{
						1563,
						1733,
						1877,
						1878
					},
					{
						417,
						414,
						349,
						239
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 25,
					{
						1125,
						1181,
						1177,
						1187,
						1188,
						1238,
						1239
					},
					{
						358,
						328,
						300,
						298,
						266,
						267,
						361
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1162,
						1162,
						1172,
						1170,
						1212,
						1211,
						1170,
						1171
					},
					{
						225,
						246,
						247,
						267,
						269,
						181,
						183,
						223
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1185,
						1186,
						1171,
						1170,
						1178,
						1218,
						1216
					},
					{
						184,
						168,
						168,
						120,
						112,
						111,
						189
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 200,
					{
						772,
						1033,
						1036,
						972,
						736,
						733,
						763
					},
					{
						529,
						537,
						895,
						854,
						814,
						550,
						547
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 50,
					{
						743,
						696,
						675,
						696,
						692,
						723,
						882,
						881,
						917,
						917
					},
					{
						780,
						776,
						792,
						817,
						873,
						906,
						903,
						854,
						835,
						791
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 25,
					{
						653,
						655,
						676,
						668,
						667,
						665,
						678,
						750,
						747
					},
					{
						639,
						659,
						676,
						693,
						735,
						744,
						758,
						760,
						636
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						916,
						928,
						973,
						972,
						990,
						999,
						1036,
						1035,
						904
					},
					{
						846,
						853,
						854,
						882,
						882,
						892,
						892,
						831,
						829
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						1033,
						1044,
						1042,
						1038,
						1039,
						1050,
						1033,
						1000,
						1004
					},
					{
						667,
						667,
						615,
						615,
						574,
						573,
						536,
						539,
						683
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 500,
					{
						1872,
						1879,
						1763,
						1199,
						1250,
						1240
					},
					{
						359,
						790,
						900,
						879,
						788,
						647
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1201,
						1256,
						1277,
						1247,
						1244,
						1201,
						1209,
						1202
					},
					{
						739,
						763,
						613,
						614,
						644,
						665,
						675,
						689
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1259,
						1200,
						1203,
						1253,
						1265
					},
					{
						789,
						788,
						901,
						901,
						825
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1256,
						1283,
						1287,
						1307,
						1308,
						1374,
						1375,
						1391,
						1388,
						1460,
						1457,
						1254
					},
					{
						893,
						894,
						903,
						901,
						894,
						894,
						901,
						902,
						896,
						895,
						854,
						854
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1522,
						1524,
						1542,
						1540,
						1529,
						1528,
						1707,
						1706,
						1520
					},
					{
						891,
						898,
						901,
						920,
						921,
						950,
						951,
						874,
						872
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 10,
					{
						1575,
						1637,
						1638,
						1620,
						1625,
						1525,
						1523,
						1559,
						1575
					},
					{
						422,
						422,
						438,
						449,
						488,
						528,
						468,
						468,
						473
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						1533,
						1462,
						1464,
						1453,
						1450,
						1530
					},
					{
						519,
						519,
						530,
						533,
						557,
						554
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						1357,
						1355,
						1463,
						1463,
						1403,
						1402
					},
					{
						572,
						609,
						609,
						556,
						561,
						574
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			},
			{
				{
					weight = 5,
					{
						1676,
						1680,
						1753,
						1751
					},
					{
						417,
						461,
						464,
						415
					}
				},
				filters = {
					regions = {
						"street",
						"dock",
						"professional"
					},
					contacts = {
						"vlad",
						"the_elephant",
						"hector",
						"bain"
					},
					difficulties = {
						"normal",
						"hard",
						"overkill",
						"overkill_145",
						"overkill_290"
					}
				}
			}
		}
		self:_create_location_bounding_boxes()
		self:_create_location_spawning_dots()
		print("Generating new spawn points for crimenet")
	end
	local wts = {}
	local dlc_1_folder = "units/pd2_dlc1/weapons/wpn_effects_textures/"
	local butch_folder = "units/pd2_dlc_butcher_mods/weapons/wpn_effects_textures/"
	wts.color_indexes = {
		{color = "red"},
		{
			color = "blue",
			dlc = "gage_pack_jobs"
		},
		{
			color = "green",
			dlc = "gage_pack_jobs"
		},
		{
			color = "yellow",
			dlc = "gage_pack_jobs"
		}
	}
	wts.types = {}
	wts.types.sight = {
		suffix = "_il",
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_s_1_il",
			name_id = "menu_reticle_1_s"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_m_1_il",
			name_id = "menu_reticle_1_m"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_l_1_il",
			name_id = "menu_reticle_1_l"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_2_il",
			name_id = "menu_reticle_2"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_3_il",
			name_id = "menu_reticle_3"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_4_il",
			name_id = "menu_reticle_4"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_5_il",
			name_id = "menu_reticle_5",
			dlc = "gage_pack_jobs"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_6_il",
			name_id = "menu_reticle_6",
			dlc = "gage_pack_jobs"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_7_il",
			name_id = "menu_reticle_7",
			dlc = "gage_pack_jobs"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_8_il",
			name_id = "menu_reticle_8",
			dlc = "gage_pack_jobs"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_9_il",
			name_id = "menu_reticle_9",
			dlc = "gage_pack_jobs"
		},
		{
			texture_path = dlc_1_folder .. "wpn_sight_reticle_10_il",
			name_id = "menu_reticle_10",
			dlc = "gage_pack_jobs"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_11_il",
			name_id = "menu_reticle_11"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_12_il",
			name_id = "menu_reticle_12"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_13_il",
			name_id = "menu_reticle_13"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_14_il",
			name_id = "menu_reticle_14"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_15_il",
			name_id = "menu_reticle_15"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_16_il",
			name_id = "menu_reticle_16"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_17_il",
			name_id = "menu_reticle_17"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_18_il",
			name_id = "menu_reticle_18"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_19_il",
			name_id = "menu_reticle_19"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_20_il",
			name_id = "menu_reticle_20"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_21_il",
			name_id = "menu_reticle_21"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_22_il",
			name_id = "menu_reticle_22"
		},
		{
			texture_path = butch_folder .. "wpn_sight_reticle_23_il",
			name_id = "menu_reticle_23"
		}
	}
	self.weapon_texture_switches = wts
	self.tradable_inventory_sort_list = {
		"aquired",
		"alphabetic",
		"quality",
		"rarity",
		"category",
		"bonus"
	}
end
function GuiTweakData:_create_location_bounding_boxes()
	for _, location in ipairs(self.crime_net.locations) do
		local params = location[1]
		if params then
			local min_x, max_x, min_y, max_y
			for _, x in ipairs(params[1]) do
				if not min_x then
				else
					min_x = x or math.min(min_x, x)
				end
				if not max_x then
				else
					max_x = x or math.max(max_x, x)
				end
			end
			for _, y in ipairs(params[2]) do
				if not min_y then
				else
					min_y = y or math.min(min_y, y)
				end
				if not max_y then
				else
					max_y = y or math.max(max_y, y)
				end
			end
			params.bounding_box = {
				min_x,
				max_x,
				min_y,
				max_y
			}
		end
	end
end
function GuiTweakData:_create_location_spawning_dots()
	local map_w = 2048
	local map_h = 1024
	local border_w = 125
	local border_h = 50
	local start_y = 50
	local start_x = -50
	local step_x = 180
	local step_y = 130
	local random_x = 0
	local random_y = 0
	local random_step_x = step_x / 2
	local zig_y = step_y / 2
	local zig = true
	for y = border_h + start_y, map_h - 2 * border_h + start_y, step_y do
		for x = border_w + math.random(-random_step_x, random_step_x) + start_x, map_w - 2 * border_w + start_x, step_x do
			local found_point = false
			local rx = x + math.random(-random_x, random_x)
			local ry = y + math.random(-random_y, random_y) + (zig and zig_y or 0)
			for _, location_data in ipairs(self.crime_net.locations) do
				local location = location_data[1]
				local bounding_box = location.bounding_box
				location.dots = location.dots or {}
				if rx >= bounding_box[1] and rx <= bounding_box[2] and ry >= bounding_box[3] and ry <= bounding_box[4] then
					local vx = location[1]
					local vy = location[2]
					local j, c
					j = #vx
					for i = 1, #vx do
						if ry < vy[i] ~= (ry < vy[j]) and rx < (vx[j] - vx[i]) * (ry - vy[i]) / (vy[j] - vy[i]) + vx[i] then
							found_point = not found_point
						end
						j = i
					end
					if found_point then
						table.insert(location.dots, {rx, ry})
					end
				else
				end
			end
			zig = not zig
		end
		zig = not zig
	end
	local new_locations = {}
	new_locations[1] = {}
	new_locations[1].filters = self.crime_net.locations[1].filters
	new_locations[1][1] = {}
	new_locations[1][1].dots = {}
	new_locations[1][1].weight = 100
	for i = #self.crime_net.locations, 1, -1 do
		if self.crime_net.locations[i][1].dots then
			for _, dot in pairs(self.crime_net.locations[i][1].dots) do
				table.insert(new_locations[1][1].dots, dot)
			end
		end
	end
	self.crime_net.locations = new_locations
end
function GuiTweakData:create_narrative_locations(locations)
end
function GuiTweakData:print_locations()
	if Application:production_build() then
		local save_me = self:serializeTable(self.crime_net.locations, "self.crime_net.locations", true, 0)
		local file = SystemFS:open("crime_net_locations.txt", "w")
		file:print(save_me)
		file:close()
	end
end
function GuiTweakData:serializeTable(val, name, skipnewlines, depth)
	skipnewlines = skipnewlines or false
	depth = depth or 0
	local tmp = ""
	if name and type(name) == "string" then
		tmp = tmp .. name .. "="
	end
	if type(val) == "table" then
		tmp = tmp .. "{ " .. (depth == 0 and "\n" or "")
		local i = 1
		for k, v in pairs(val) do
			tmp = tmp .. self:serializeTable(v, k, skipnewlines, depth + 1)
			if depth > 0 and i < table.size(val) then
				tmp = tmp .. ", "
				i = i + 1
			else
				tmp = tmp .. " "
			end
		end
		tmp = tmp .. "}" .. (depth <= 1 and ", \n" or "")
	elseif type(val) == "number" then
		tmp = tmp .. tostring(val)
	elseif type(val) == "string" then
		tmp = tmp .. string.format("%q", val)
	elseif type(val) == "boolean" then
		tmp = tmp .. (val and "true" or "false")
	else
		tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
	end
	return tmp
end
function GuiTweakData:tradable_inventory_sort_func(index)
	if type(index) == "string" then
		index = self:tradable_inventory_sort_index(index)
	end
	if index == 1 then
		return function(x, y)
			return y < x
		end
	elseif index == 2 then
		do
			local inventory_tradable = managers.blackmarket:get_inventory_tradable()
			local x_item, y_item, x_td, y_td, x_loc, y_loc
			local localization_cache = {}
			return function(x, y)
				x_item = inventory_tradable[x]
				y_item = inventory_tradable[y]
				x_td = tweak_data.economy[x_item.category] or tweak_data.blackmarket[x_item.category][x_item.entry]
				y_td = tweak_data.economy[y_item.category] or tweak_data.blackmarket[y_item.category][y_item.entry]
				if x_td.name_id ~= y_td.name_id then
					localization_cache[x_td.name_id] = localization_cache[x_td.name_id] or managers.localization:to_upper_text(x_td.name_id)
					localization_cache[y_td.name_id] = localization_cache[y_td.name_id] or managers.localization:to_upper_text(y_td.name_id)
					x_loc = localization_cache[x_td.name_id]
					y_loc = localization_cache[y_td.name_id]
					return x_loc < y_loc
				end
				return y < x
			end
		end
	elseif index == 3 then
		do
			local inventory_tradable = managers.blackmarket:get_inventory_tradable()
			local x_item, y_item, x_quality, y_quality
			return function(x, y)
				x_item = inventory_tradable[x]
				y_item = inventory_tradable[y]
				x_quality = tweak_data.economy.qualities[x_item.quality]
				y_quality = tweak_data.economy.qualities[y_item.quality]
				if not x_quality then
					return false
				end
				if not y_quality then
					return not x_quality
				end
				if x_quality.index ~= y_quality.index then
					return x_quality.index > y_quality.index
				end
				if x_item.entry ~= y_item.entry then
					return x_item.entry < y_item.entry
				end
				return y < x
			end
		end
	elseif index == 4 then
		do
			local inventory_tradable = managers.blackmarket:get_inventory_tradable()
			local x_item, y_item, x_td, y_td, x_rarity, y_rarity
			return function(x, y)
				x_item = inventory_tradable[x]
				y_item = inventory_tradable[y]
				x_td = tweak_data.economy[x_item.category] or tweak_data.blackmarket[x_item.category][x_item.entry]
				y_td = tweak_data.economy[y_item.category] or tweak_data.blackmarket[y_item.category][y_item.entry]
				x_rarity = tweak_data.economy.rarities[x_td.rarity or "common"]
				y_rarity = tweak_data.economy.rarities[y_td.rarity or "common"]
				if x_rarity.index ~= y_rarity.index then
					return x_rarity.index > y_rarity.index
				end
				if x_item.entry ~= y_item.entry then
					return x_item.entry < y_item.entry
				end
				return y < x
			end
		end
	elseif index == 5 then
		do
			local inventory_tradable = managers.blackmarket:get_inventory_tradable()
			local x_item, y_item
			return function(x, y)
				x_item = inventory_tradable[x]
				y_item = inventory_tradable[y]
				if x_item.category ~= y_item.category then
					return x_item.category < y_item.category
				end
				if x_item.entry ~= y_item.entry then
					return x_item.entry < y_item.entry
				end
				return y < x
			end
		end
	elseif index == 6 then
		do
			local inventory_tradable = managers.blackmarket:get_inventory_tradable()
			local x_item, y_item
			return function(x, y)
				x_item = inventory_tradable[x]
				y_item = inventory_tradable[y]
				if x_item.bonus ~= y_item.bonus then
					return x_item.bonus
				end
				if x_item.entry ~= y_item.entry then
					return x_item.entry < y_item.entry
				end
				return y < x
			end
		end
	end
	return nil
end
function GuiTweakData:tradable_inventory_sort_name(index)
	return self.tradable_inventory_sort_list[index] or "none"
end
function GuiTweakData:tradable_inventory_sort_index(name)
	for index, n in ipairs(self.tradable_inventory_sort_list) do
		if n == name then
			return index
		end
	end
	return 0
end
function GuiTweakData:get_main_menu_layout_by_name(name, ...)
	if self._cached_layout and self._cached_layout[name] then
		return unpack(self._cached_layout[name])
	end
	local layout = self[name]
	local return_data = {
		{},
		{}
	}
	if layout then
		local layout_type = type(layout)
		if layout_type == "table" then
			return_data = {
				layout,
				{}
			}
		elseif layout_type == "function" then
			return_data = {
				layout(...)
			}
		elseif layout_type == "string" then
		end
	end
	self._cached_layout = self._cached_layout or {}
	self._cached_layout[name] = return_data
	return unpack(return_data)
end
function GuiTweakData.main_menu_layout_new_menu(panel_w, panel_h)
	local mechanic_animation = function(o)
		local parent_panel = o:parent()
		local corner_left = 0 - parent_panel:w() * 0.03
		local corner_right = -o:w() + parent_panel:w() * 1.03
		local corner_top = 0 - parent_panel:w() * 0.03
		local corner_bottom = -o:h() + parent_panel:h() * 1.03
		local start_x = o:x()
		local start_y = o:y()
		local wanted_x = math.random(corner_left, corner_right)
		local wanted_y = math.random(corner_top, corner_bottom)
		local move_on_x_axis = wanted_x < wanted_y
		local diff = move_on_x_axis and wanted_x - start_x or wanted_y - start_y
		local dir = diff == 0 and 0 or diff / math.abs(diff)
		local overshoot = move_on_x_axis and math.rand(parent_panel:w() * 0.02) or math.rand(parent_panel:h() * 0.02) * dir
		local dir_moved = 0
		local function move_one_axis(p)
			if move_on_x_axis then
				o:set_x(math.lerp(start_x, wanted_x, p))
			else
				o:set_y(math.lerp(start_y, wanted_y, p))
			end
		end
		local function overshoot_one_axis(p)
			if move_on_x_axis then
				o:set_x(math.lerp(wanted_x, wanted_x + overshoot, p))
			else
				o:set_y(math.lerp(wanted_y, wanted_y + overshoot, p))
			end
		end
		local function bringback_one_axis(p)
			if move_on_x_axis then
				o:set_x(math.lerp(wanted_x + overshoot, wanted_x, p))
			else
				o:set_y(math.lerp(wanted_y + overshoot, wanted_y, p))
			end
		end
		while true do
			wait(math.rand(0.1))
			over(math.abs(diff / 20), move_one_axis)
			over(math.abs(overshoot / 20), overshoot_one_axis)
			wait(math.rand(0.1))
			over(math.abs(overshoot / 200), bringback_one_axis)
			dir_moved = dir_moved + 1
			if dir_moved == 2 then
				start_x = wanted_x
				start_y = wanted_y
				wanted_x = math.random(corner_left, corner_right)
				wanted_y = math.random(corner_top, corner_bottom)
				dir_moved = 0
			end
			move_on_x_axis = not move_on_x_axis
			diff = move_on_x_axis and wanted_x - start_x or wanted_y - start_y
			dir = diff == 0 and 0 or diff / math.abs(diff)
			overshoot = move_on_x_axis and math.random(parent_panel:w() * 0.008) or math.random(parent_panel:h() * 0.008) * dir
		end
	end
	local function select_anim(o, box, instant)
		if box.image_objects then
			do
				local bg = box.bg_object
				local box_image = box.image_objects[1]
				local corners = box.image_objects[2]
				local innerglow = box.image_objects[3]
				local shadow = box.image_objects[4]
				local vignette = box.image_objects[5]
				local corners_off = box.image_objects[6]
				local select_alpha_blend = box.image_objects[7]
				local video = box.video
				if not box.params.select_shape then
					local select_shape = {
						0.5,
						0.5,
						1,
						1
					}
				end
				local current_width = box_image.gui:w()
				local current_height = box_image.gui:h()
				local end_width = box_image.shape[3] * select_shape[3]
				local end_height = box_image.shape[4] * select_shape[4]
				if not alive(video) then
					box.video = bg.gui:parent():video({
						video = "movies/mm_glitch",
						width = bg.gui:w(),
						height = bg.gui:h(),
						blend_mode = "add",
						loop = true,
						layer = bg.gui:layer() + 2
					})
					video = box.video
					managers.menu_component:set_main_menu_video(video)
				end
				corners.gui:show()
				corners_off.gui:hide()
				shadow.gui:show()
				innerglow.gui:show()
				vignette.gui:hide()
				local sx = box_image.gui:center_x()
				local sy = box_image.gui:center_y()
				local cx = box_image.gui:parent():w() * select_shape[1]
				local cy = box_image.gui:parent():h() * select_shape[2]
				box_image.gui:set_alpha(1)
				select_alpha_blend.gui:set_alpha(1)
				over(0.1, function(p)
					box_image.gui:set_size(math.lerp(current_width, end_width, p), math.lerp(current_height, end_height, p))
					box_image.gui:set_center(math.lerp(sx, cx, p), math.lerp(sy, cy, p))
					select_alpha_blend.gui:set_alpha(math.lerp(1, 0, p))
				end)
				mechanic_animation(box_image.gui)
			end
		end
	end
	local unselect_anim = function(o, box, instant)
		if box.image_objects then
			local box_image = box.image_objects[1]
			local corners = box.image_objects[2]
			local innerglow = box.image_objects[3]
			local shadow = box.image_objects[4]
			local vignette = box.image_objects[5]
			local corners_off = box.image_objects[6]
			local select_alpha_blend = box.image_objects[7]
			local video = box.video
			if not box.params.unselect_shape then
				local unselect_shape = {
					0.5,
					0.5,
					1,
					1
				}
			end
			local current_width = box_image.gui:w()
			local current_height = box_image.gui:h()
			local end_width = box_image.shape[3] * unselect_shape[3]
			local end_height = box_image.shape[4] * unselect_shape[4]
			local sx, sy = box_image.gui:center()
			if alive(video) then
				video:parent():remove(video)
				managers.menu_component:set_main_menu_video()
			end
			corners.gui:hide()
			corners_off.gui:show()
			shadow.gui:hide()
			innerglow.gui:hide()
			vignette.gui:show()
			select_alpha_blend.gui:set_alpha(0)
			local cx = box_image.gui:parent():w() * unselect_shape[1]
			local cy = box_image.gui:parent():h() * unselect_shape[2]
			box_image.gui:set_alpha(1)
			box_image.gui:set_size(end_width, end_height)
			box_image.gui:set_center(cx, cy)
		end
	end
	local boxes = {}
	local template_box_text = {
		x = panel_w + 15,
		y = -5,
		w = 0,
		h = 30,
		use_background = true,
		bg_selected_color = tweak_data.screen_colors.button_stage_3:with_alpha(0.2),
		bg_unselected_color = Color(0, 0, 0, 0),
		bg_blend_mode = "add",
		bg_select_area = true,
		bg_rotation = 360,
		text_selected_color = tweak_data.screen_colors.text,
		text_unselected_color = Color("ff406a80"),
		padding = 5,
		x_padding = 10,
		shrink_text = false,
		adept_width = true,
		keep_box_ratio = false,
		halign = "right",
		clbks = {
			left = nil,
			right = nil,
			up = nil,
			down = nil
		},
		links = {
			left = nil,
			right = nil,
			up = nil,
			down = "steam"
		}
	}
	local x = 0
	do
		local exit_text = deep_clone(template_box_text)
		exit_text.name = "exit"
		exit_text.clbks.left = callback(MenuCallbackHandler, MenuCallbackHandler, "quit_game")
		exit_text.links.left = "credits"
		exit_text.links.down = "news"
		exit_text.text = managers.localization:to_upper_text("menu_quit")
		boxes.exit = exit_text
	end
	do
		local credits_text = deep_clone(template_box_text)
		credits_text.name = "credits"
		function credits_text.clbks.left()
			managers.menu:open_node("credits")
		end
		credits_text.links.left = "settings"
		credits_text.links.right = "exit"
		credits_text.links.down = "news"
		credits_text.text = managers.localization:to_upper_text("menu_credits")
		boxes.credits = credits_text
	end
	do
		local settings_text = deep_clone(template_box_text)
		settings_text.name = "settings"
		function settings_text.clbks.left()
			managers.menu_component:close_main_menu_gui()
			managers.menu:open_node("options")
		end
		settings_text.links.left = "fbi_files"
		settings_text.links.right = "credits"
		settings_text.links.down = "news"
		settings_text.text = managers.localization:to_upper_text("menu_options")
		boxes.settings = settings_text
	end
	do
		local fbi_files_text = deep_clone(template_box_text)
		fbi_files_text.name = "fbi_files"
		fbi_files_text.clbks.left = callback(MenuCallbackHandler, MenuCallbackHandler, "on_visit_fbi_files")
		fbi_files_text.links.left = "gamehub"
		fbi_files_text.links.right = "settings"
		fbi_files_text.text = managers.localization:to_upper_text("menu_visit_fbi_files")
		boxes.fbi_files = fbi_files_text
	end
	do
		local gamehub_text = deep_clone(template_box_text)
		gamehub_text.name = "gamehub"
		gamehub_text.clbks.left = callback(MenuCallbackHandler, MenuCallbackHandler, "on_visit_gamehub")
		gamehub_text.links.right = "fbi_files"
		gamehub_text.links.down = "dlc"
		gamehub_text.text = managers.localization:to_upper_text("menu_visit_gamehub")
		boxes.gamehub = gamehub_text
	end
	if managers.menu:is_pc_controller() then
		local back_button_play_text = {
			x = panel_w,
			y = panel_h,
			w = panel_w * 0.35,
			h = tweak_data.menu.pd2_large_font_size,
			padding = 0,
			name = "back_button_play",
			use_background = true,
			bg_selected_color = tweak_data.screen_colors.button_stage_3:with_alpha(0.2),
			bg_unselected_color = Color(0, 0, 0, 0),
			bg_blend_mode = "add",
			bg_rotation = 360,
			text = managers.localization:to_upper_text("menu_back"),
			text_selected_color = tweak_data.screen_colors.button_stage_2,
			text_unselected_color = tweak_data.screen_colors.button_stage_3,
			font = tweak_data.menu.pd2_large_font,
			font_size = tweak_data.menu.pd2_large_font_size,
			shrink_text = false,
			adept_width = true,
			keep_box_ratio = false,
			halign = "right",
			valign = "bottom",
			text_align = "right",
			text_vertical = "bottom",
			state = "play",
			clbks = {
				left = function()
					managers.menu_component:set_new_main_menu_state("default", "play")
				end,
				right = nil,
				up = nil,
				down = nil
			},
			links = {
				left = "play_online",
				right = nil,
				up = "play_offline",
				down = nil
			},
			layer = 2
		}
		boxes.back_button_play = back_button_play_text
		local back_button_play_text_bg = deep_clone(back_button_play_text)
		back_button_play_text_bg.can_select = false
		back_button_play_text_bg.name = "back_button_play_bg"
		back_button_play_text_bg.font = tweak_data.menu.pd2_massive_font
		back_button_play_text_bg.font_size = tweak_data.menu.pd2_massive_font_size
		back_button_play_text_bg.h = tweak_data.menu.pd2_massive_font_size + 10
		back_button_play_text_bg.alpha = 0.4
		back_button_play_text_bg.text_rotation = 360
		back_button_play_text_bg.text_selected_color = tweak_data.screen_colors.button_stage_3
		back_button_play_text_bg.layer = 1
		back_button_play_text_bg.x = back_button_play_text_bg.x + 13
		back_button_play_text_bg.y = back_button_play_text_bg.y - 7 + tweak_data.menu.pd2_massive_font_size / 4
		boxes.back_button_play_bg = back_button_play_text_bg
	else
	end
	local padding_x = 10
	local padding_y = 10
	local width = 240
	local height = 160
	local size = 256
	local image_x = 8
	local image_y = 48
	local image_w = 256
	local image_h = 256
	local panel_grow_w = image_x * -2
	local panel_grow_h = image_y * -2
	local select_x = image_x
	local select_y = image_y
	local select_w = width
	local select_h = height
	local box_x = panel_w - width * 3 - padding_x * 2 - (size - width)
	local box_y = panel_h - height * 3 - padding_y * 2 - (size - height) - 40
	local template_box_default = {
		w = size,
		h = size,
		use_background = true,
		bg_selected_color = Color(51, 0, 0, 51) / 255,
		bg_unselected_color = Color(64, 0, 0, 0) / 255,
		bg_selected_blend_mode = "normal",
		bg_unselected_blend_mode = "add",
		bg_select_area = true,
		text_x = padding_x,
		text_y = select_y,
		text_vertical = "top",
		text_align = "left",
		text_selected_color = tweak_data.screen_colors.text,
		text_unselected_color = tweak_data.screen_colors.text,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		images = {
			{
				texture = nil,
				image_width = size,
				image_height = size,
				layer = 0,
				panel_grow_w = panel_grow_w,
				panel_grow_h = panel_grow_h,
				blend_mode = "normal",
				keep_aspect_ratio = false
			},
			{
				texture = "guis/dlcs/flashy/textures/pd2/menu_img_corners",
				layer = 2,
				blend_mode = "normal"
			},
			{
				texture = "guis/dlcs/flashy/textures/pd2/menu_img_innerglow",
				layer = 1,
				blend_mode = "add"
			},
			{
				texture = "guis/dlcs/flashy/textures/pd2/menu_img_shadow",
				layer = 1,
				blend_mode = "normal"
			},
			{
				texture = "guis/dlcs/flashy/textures/pd2/menu_img_vignette",
				layer = 2,
				blend_mode = "normal"
			},
			{
				texture = "guis/dlcs/flashy/textures/pd2/menu_img_corners_off",
				layer = 3,
				blend_mode = "normal"
			},
			{
				texture = "guis/textures/test_blur_df",
				layer = 3,
				panel_grow_w = panel_grow_w,
				panel_grow_h = panel_grow_h,
				blend_mode = "add",
				keep_aspect_ratio = false
			}
		},
		select_area = {
			x = select_x,
			y = select_y,
			w = select_w,
			h = select_h
		},
		clbks = {
			left = nil,
			right = nil,
			up = nil,
			down = nil
		},
		links = {
			left = nil,
			right = nil,
			up = nil,
			down = nil
		},
		select_shape = {
			0.5,
			0.5,
			1,
			1
		},
		unselect_shape = {
			0.5,
			0.5,
			1,
			1
		}
	}
	do
		local dlc_box = deep_clone(template_box_default)
		dlc_box.name = "dlc"
		function dlc_box.clbks.left()
			managers.menu:open_node("content_updates_pc")
		end
		dlc_box.links.right = "steam"
		dlc_box.links.down = "play"
		dlc_box.links.up = "gamehub"
		dlc_box.text = managers.localization:to_upper_text("menu_content_updates_new")
		dlc_box.select_shape = {
			0.5,
			0.5,
			0.76,
			0.76
		}
		dlc_box.unselect_shape = {
			0.5,
			0.5,
			0.66,
			0.66
		}
		dlc_box.images[1].image_width = dlc_box.images[1].image_width * 2
		dlc_box.images[1].texture = tweak_data.gui.content_updates.item_list[#tweak_data.gui.content_updates.item_list].image
		dlc_box.images[1].selected_color = Color(1, 1, 1, 1)
		dlc_box.images[1].unselected_color = Color(0.75, 1, 1, 1)
		local fade_out_time = 0.2
		local fade_in_time = 0.3
		local image_swap_time = 2
		local num_dlc_to_show = 5
		local unselected_image_speed_mul = 0.2
		local image_t, fade_out_t, fade_in_t
		local current_dlc = 0
		function dlc_box:update_func(box, t, dt)
			if alive(box.panel) and box.panel:tree_visible() then
				local data = box.image_objects[1]
				local ticker = box.image_objects[8]
				if fade_out_t then
					fade_out_t = fade_out_t - dt
					data.gui:set_alpha(math.max(fade_out_t / fade_out_time, 0))
					if fade_out_t <= 0 then
						fade_out_t = nil
						fade_in_t = 0
						managers.menu_component:unretrieve_texture(box.image_objects.requested_textures[1], box.image_objects.requested_indices[1])
						data.gui:clear()
						current_dlc = (current_dlc + 1) % num_dlc_to_show
						local params = data.params
						local image = tweak_data.gui.content_updates.item_list[#tweak_data.gui.content_updates.item_list - current_dlc].image
						local texture_loaded_clbk = callback(self, self, "texture_loaded_clbk", params)
						box.image_objects.requested_textures[1] = image
						box.image_objects.requested_indices[1] = managers.menu_component:request_texture(image, texture_loaded_clbk)
						box.params.images[1].texture = image
					end
				elseif fade_in_t then
					fade_in_t = math.step(fade_in_t, fade_in_time, dt)
					data.gui:set_alpha(math.min(fade_in_t / fade_in_time, 1))
					if fade_in_t >= fade_in_time then
						data.gui:set_alpha(1)
						fade_in_t = nil
						image_t = image_swap_time
					end
				else
					image_t = image_t or image_swap_time
					image_t = image_t - dt * (not box.selected and unselected_image_speed_mul or 1)
					if image_t <= 0 then
						fade_out_t = fade_out_time
						image_t = nil
					end
				end
			end
		end
		local function ticker_update_anim(o)
			while true do
				local dt = coroutine.yield()
				local w = current_dlc * 12 + 3 + (1 - (fade_out_t and 0 or image_t or image_swap_time) / image_swap_time) * 9
				o:set_texture_rect(0, 0, w, 16)
				o:set_w(w)
			end
		end
		table.insert(dlc_box.images, {
			texture = "guis/dlcs/flashy/textures/pd2/img_ticker",
			layer = 4,
			blend_mode = "normal",
			panel_move_x = 0,
			panel_move_y = size / 2 - 8 + panel_grow_h / 2,
			panel_grow_w = 64 - size,
			panel_grow_h = 16 - size,
			color = Color(1, 1, 1, 1),
			anim_func = ticker_update_anim
		})
		table.insert(dlc_box.images, {
			texture = "guis/dlcs/flashy/textures/pd2/img_ticker_bg",
			layer = 3,
			blend_mode = "normal",
			panel_move_x = 0,
			panel_move_y = size / 2 - 8 + panel_grow_h / 2,
			panel_grow_w = 64 - size,
			panel_grow_h = 16 - size
		})
		boxes.dlc = dlc_box
	end
	do
		local steam_box = deep_clone(template_box_default)
		steam_box.name = "steam"
		steam_box.images[1].texture = "guis/dlcs/flashy/textures/pd2/menu_img_steaminventory"
		function steam_box.clbks.left()
			managers.menu:open_node("steam_inventory")
		end
		steam_box.links.left = "dlc"
		steam_box.links.right = "news"
		steam_box.links.down = "profile"
		steam_box.links.up = "fbi_files"
		steam_box.text = managers.localization:to_upper_text("menu_steam_inventory_new")
		steam_box.unselect_shape = {
			0.5,
			0.75,
			0.475,
			0.475
		}
		steam_box.select_shape = {
			0.5,
			0.75,
			0.75,
			0.75
		}
		steam_box.images[1].image_height = 512
		steam_box.images[1].image_width = 512
		boxes.steam = steam_box
	end
	do
		local news_box = deep_clone(template_box_default)
		news_box.name = "news"
		news_box.images[1].texture = "guis/dlcs/flashy/textures/pd2/menu_img_news"
		news_box.links.left = "steam"
		news_box.links.down = "challenge"
		news_box.links.up = "settings"
		news_box.text = managers.localization:to_upper_text("menu_news_new")
		news_box.info_text = ""
		news_box.info_text_wrap = true
		news_box.info_text_word_wrap = true
		news_box.info_text_align = "center"
		news_box.info_text_vertical = "center"
		news_box.images[1].image_width = news_box.images[1].image_width * 2
		news_box.images[2].rotation = 360
		news_box.images[3].rotation = 360
		news_box.images[4].rotation = 360
		news_box.images[5].rotation = 360
		news_box.images[6].rotation = 360
		local fade_out_time = 0.2
		local fade_in_time = 0.5
		local news_swap_time = 3
		local max_news = 5
		local unselected_news_speed_mul = 0.8
		local expire_t, fade_out_t, fade_in_t
		local current_news = -1
		local news_updated = false
		local titles, links
		function news_box.clbks.left()
			if not links then
				return
			end
			if MenuCallbackHandler:is_overlay_enabled() then
				Steam:overlay_activate("url", links[current_news + 1])
			else
				managers.menu:show_enable_steam_overlay()
			end
		end
		local function news_result(success, body)
			local _get_text_block = function(s, sp, ep, max_results)
				local result = {}
				local len = string.len(s)
				local i = 1
				local function f(s, sp, ep, max_results)
					local s1, e1 = string.find(s, sp, 1, true)
					if not e1 then
						return
					end
					local s2, e2 = string.find(s, ep, e1, true)
					table.insert(result, string.sub(s, e1 + 1, s2 - 1))
				end
				while len > i and max_results > #result do
					local s1, e1 = string.find(s, "<item>", i, true)
					if not e1 then
						break
					end
					local s2, e2 = string.find(s, "</item>", e1, true)
					local item_s = string.sub(s, e1 + 1, s2 - 1)
					f(item_s, sp, ep, max_results)
					i = e1
				end
				return result
			end
			if success then
				titles = _get_text_block(body, "<title>", "</title>", max_news)
				links = _get_text_block(body, "<link><![CDATA[", "]]></link>", max_news)
				for _, text in ipairs(titles) do
					if utf8.to_lower(utf8.sub(text, 1, 10)) == "payday 2: " then
						titles[_] = utf8.sub(text, 11)
					end
				end
			end
		end
		function news_box:update_func(box, t, dt)
			if not news_updated then
				news_updated = true
				Steam:http_request("http://steamcommunity.com/games/218620/rss", news_result)
			end
			if titles and links and alive(box.panel) and box.panel:tree_visible() then
				local data = box.info_text_object
				local image = box.image_objects[1]
				if fade_out_t then
					fade_out_t = fade_out_t - dt
					data.gui:set_alpha(math.max(fade_out_t / fade_out_time, 0))
					image.gui:set_alpha(math.max(fade_out_t / fade_out_time, 0))
					if fade_out_t <= 0 then
						fade_out_t = nil
						fade_in_t = 0
						current_news = (current_news + 1) % max_news
						local text = utf8.to_upper(titles[current_news + 1])
						data.selected_text = text
						data.unselected_text = text
						data.gui:set_text(text)
						box.params.info_text = text
					end
				elseif fade_in_t then
					fade_in_t = math.step(fade_in_t, fade_in_time, dt)
					data.gui:set_alpha(math.min(fade_in_t / fade_in_time, 1))
					image.gui:set_alpha(math.min(fade_in_t / fade_in_time, 1))
					if fade_in_t >= fade_in_time then
						data.gui:set_alpha(1)
						image.gui:set_alpha(1)
						fade_in_t = nil
						expire_t = news_swap_time
					end
				else
					expire_t = expire_t or 0
					expire_t = expire_t - dt * (not box.selected and unselected_news_speed_mul or 1)
					if expire_t <= 0 then
						fade_out_t = fade_out_time
						expire_t = nil
					end
				end
			end
		end
		local function ticker_update_anim(o)
			while true do
				local dt = coroutine.yield()
				local w = current_news * 12 + 3 + (1 - (fade_out_t and 0 or expire_t or news_swap_time) / news_swap_time) * 9
				o:set_texture_rect(0, 0, w, 16)
				o:set_w(w)
			end
		end
		table.insert(news_box.images, {
			texture = "guis/dlcs/flashy/textures/pd2/img_ticker",
			layer = 4,
			blend_mode = "normal",
			panel_move_x = 0,
			panel_move_y = size / 2 - 8 + panel_grow_h / 2,
			panel_grow_w = 64 - size,
			panel_grow_h = 16 - size,
			color = Color(1, 1, 1, 1),
			anim_func = ticker_update_anim
		})
		table.insert(news_box.images, {
			texture = "guis/dlcs/flashy/textures/pd2/img_ticker_bg",
			layer = 3,
			blend_mode = "normal",
			panel_move_x = 0,
			panel_move_y = size / 2 - 8 + panel_grow_h / 2,
			panel_grow_w = 64 - size,
			panel_grow_h = 16 - size
		})
		boxes.news = news_box
	end
	do
		local play_box = deep_clone(template_box_default)
		play_box.name = "play"
		play_box.images[1].texture = "guis/dlcs/flashy/textures/pd2/menu_img_play"
		function play_box.clbks.left()
			managers.menu_component:set_new_main_menu_state("play", "play_online")
		end
		play_box.links.right = "profile"
		play_box.links.up = "dlc"
		play_box.text = managers.localization:to_upper_text("menu_play_new")
		play_box.select_shape = {
			0.5,
			0.25,
			0.75,
			0.75
		}
		play_box.unselect_shape = {
			0.5,
			0.25,
			0.5,
			0.5
		}
		play_box.images[1].image_height = 512
		play_box.images[1].image_width = 512
		boxes.play = play_box
	end
	do
		local profile_box = deep_clone(template_box_default)
		profile_box.name = "profile"
		profile_box.images[1].texture = "guis/dlcs/flashy/textures/pd2/menu_img_character"
		function profile_box.clbks.left()
			managers.menu:open_node("inventory")
		end
		profile_box.links.left = "play"
		profile_box.links.right = "challenge"
		profile_box.links.up = "steam"
		profile_box.text = managers.localization:to_upper_text("menu_player_inventory_new")
		profile_box.select_shape = {
			1,
			1,
			0.75,
			0.75
		}
		profile_box.unselect_shape = {
			1.05,
			0.75,
			0.49,
			0.49
		}
		profile_box.images[1].image_height = 512
		profile_box.images[1].image_width = 1024
		boxes.profile = profile_box
	end
	do
		local challenge_box = deep_clone(template_box_default)
		challenge_box.name = "challenge"
		challenge_box.images[1].texture = "guis/dlcs/flashy/textures/pd2/menu_img_sidejobs"
		function challenge_box.clbks.left()
			managers.menu:open_node("crimenet_contract_challenge")
		end
		challenge_box.links.left = "profile"
		challenge_box.links.up = "news"
		challenge_box.text = managers.localization:to_upper_text("menu_challenge_new")
		challenge_box.unselect_shape = {
			0.5,
			0.2,
			0.5,
			0.5
		}
		challenge_box.select_shape = {
			0.75,
			-0.15,
			0.75,
			0.75
		}
		challenge_box.images[1].image_height = 512
		challenge_box.images[1].image_width = 512
		boxes.challenge = challenge_box
	end
	local template_box_play = deep_clone(template_box_default)
	template_box_play.h = template_box_play.h * 2
	template_box_play.text_y = template_box_play.text_y * 2
	template_box_play.select_area.y = template_box_play.select_area.y * 2 - padding_y / 2
	template_box_play.select_area.h = template_box_play.select_area.h * 2 + padding_y
	template_box_play.state = "play"
	template_box_play.images[1].panel_grow_h = template_box_play.images[1].panel_grow_h * 2 + padding_y
	template_box_play.images[7].panel_grow_h = template_box_play.images[7].panel_grow_h * 2 + padding_y
	template_box_play.images[1].image_width = template_box_play.images[1].image_width * 2
	template_box_play.images[1].image_height = template_box_play.images[1].image_height * 2
	template_box_play.images[2].texture = "guis/dlcs/flashy/textures/pd2/menu_img_corners_high"
	template_box_play.images[3].texture = "guis/dlcs/flashy/textures/pd2/menu_img_innerglow_high"
	template_box_play.images[4].texture = "guis/dlcs/flashy/textures/pd2/menu_img_shadow_high"
	template_box_play.images[5].texture = "guis/dlcs/flashy/textures/pd2/menu_img_vignette_high"
	template_box_play.images[6].texture = "guis/dlcs/flashy/textures/pd2/menu_img_corners_off_high"
	do
		local play_online_box = deep_clone(template_box_play)
		play_online_box.name = "play_online"
		play_online_box.images[1].texture = "guis/dlcs/flashy/textures/pd2/menu_img_play_online"
		function play_online_box.clbks.left()
			local f = function(success)
				if success then
					MenuCallbackHandler:play_online_game()
					MenuCallbackHandler:chk_dlc_content_updated()
					managers.menu:open_node("crimenet")
				end
			end
			managers.menu:open_sign_in_menu(f)
		end
		play_online_box.links.right = "play_offline"
		play_online_box.links.down = "back_button_play"
		play_online_box.text = managers.localization:to_upper_text("menu_crimenet_new")
		play_online_box.unselect_shape = {
			0.5,
			0.5,
			0.66,
			0.66
		}
		play_online_box.select_shape = {
			0.5,
			0.5,
			1,
			1
		}
		play_online_box.images[1].image_width = 512
		play_online_box.images[1].image_height = 512
		boxes.play_online = play_online_box
	end
	do
		local play_offline_box = deep_clone(template_box_play)
		play_offline_box.name = "play_offline"
		play_offline_box.images[1].texture = "guis/dlcs/flashy/textures/pd2/menu_img_play_offline"
		function play_offline_box.clbks.left()
			MenuCallbackHandler:play_single_player()
			MenuCallbackHandler:chk_dlc_content_updated()
			managers.menu:open_node("crimenet_single_player")
		end
		play_offline_box.links.left = "play_online"
		play_offline_box.links.right = "play_safehouse"
		play_offline_box.links.down = "back_button_play"
		play_offline_box.text = managers.localization:to_upper_text("menu_crimenet_offline_new")
		play_offline_box.unselect_shape = {
			0.5,
			0.5,
			0.66,
			0.66
		}
		play_offline_box.select_shape = {
			0.5,
			0.5,
			1,
			1
		}
		play_offline_box.images[1].image_width = 512
		play_offline_box.images[1].image_height = 512
		boxes.play_offline = play_offline_box
	end
	do
		local play_safehouse_box = deep_clone(template_box_play)
		play_safehouse_box.name = "play_safehouse"
		play_safehouse_box.images[1].texture = "guis/dlcs/flashy/textures/pd2/menu_img_play_safehouse"
		play_safehouse_box.clbks.left = callback(MenuCallbackHandler, MenuCallbackHandler, "play_safehouse")
		play_safehouse_box.links.left = "play_offline"
		play_safehouse_box.links.down = "back_button_play"
		play_safehouse_box.text = managers.localization:to_upper_text("menu_safehouse_new")
		play_safehouse_box.unselect_shape = {
			0.5,
			0.4,
			0.8,
			0.8
		}
		play_safehouse_box.select_shape = {
			0.5,
			0.5,
			1,
			1
		}
		play_safehouse_box.images[1].image_width = 512
		play_safehouse_box.images[1].image_height = 512
		boxes.play_safehouse = play_safehouse_box
	end
	do
		local default_title = {
			name = "default_title",
			text = managers.localization:to_upper_text("menu_mm_default_title"),
			font = tweak_data.menu.pd2_large_font,
			font_size = tweak_data.menu.pd2_large_font_size,
			height = tweak_data.menu.pd2_large_font_size + padding_y,
			text_vertical = "top",
			text_align = "left",
			can_select = false,
			shrink_text = false,
			adept_width = true,
			keep_box_ratio = false,
			text_color = tweak_data.screen_colors.text:with_alpha(0.8),
			state = "default"
		}
		boxes.default_title = default_title
	end
	do
		local play_title = {
			name = "play_title",
			text = managers.localization:to_upper_text("menu_mm_play_title"),
			font = tweak_data.menu.pd2_large_font,
			font_size = tweak_data.menu.pd2_large_font_size,
			height = tweak_data.menu.pd2_large_font_size + padding_y,
			text_vertical = "top",
			text_align = "left",
			can_select = false,
			shrink_text = false,
			adept_width = true,
			keep_box_ratio = false,
			text_color = tweak_data.screen_colors.text:with_alpha(0.8),
			state = "play"
		}
		boxes.play_title = play_title
	end
	local layout = {
		{
			box = "credits",
			align_box = "exit",
			right_align = "left",
			top_align = "top",
			x_offset = -padding_x
		},
		{
			box = "settings",
			align_box = "credits",
			right_align = "left",
			top_align = "top",
			x_offset = -padding_x
		},
		{
			box = "fbi_files",
			align_box = "settings",
			right_align = "left",
			top_align = "top",
			x_offset = -padding_x
		},
		{
			box = "gamehub",
			align_box = "fbi_files",
			right_align = "left",
			top_align = "top",
			x_offset = -padding_x
		},
		{
			box = "news",
			align_box = "exit",
			right_align = "right",
			top_align = "top",
			x_offset = -7,
			y_offset = 131
		},
		{
			box = "steam",
			align_box = "news",
			right_align = "left",
			top_align = "top",
			x_offset = 16 - padding_x,
			y_offset = 0
		},
		{
			box = "dlc",
			align_box = "steam",
			right_align = "left",
			top_align = "top",
			x_offset = 16 - padding_x,
			y_offset = 0
		},
		{
			box = "challenge",
			align_box = "news",
			right_align = "right",
			top_align = "bottom",
			x_offset = 0,
			y_offset = -96 + padding_y
		},
		{
			box = "profile",
			align_box = "challenge",
			right_align = "left",
			top_align = "top",
			x_offset = 16 - padding_x,
			y_offset = 0
		},
		{
			box = "play",
			align_box = "profile",
			right_align = "left",
			top_align = "top",
			x_offset = 16 - padding_x,
			y_offset = 0
		},
		{
			box = "play_safehouse",
			align_box = "news",
			right_align = "right",
			top_align = "top",
			x_offset = 0,
			y_offset = -43
		},
		{
			box = "play_offline",
			align_box = "play_safehouse",
			right_align = "left",
			top_align = "top",
			x_offset = 6,
			y_offset = 0
		},
		{
			box = "play_online",
			align_box = "play_offline",
			right_align = "left",
			top_align = "top",
			x_offset = 6,
			y_offset = 0
		},
		{
			box = "default_title",
			align_box = "dlc",
			left_align = "left",
			bottom_align = "top",
			x_offset = 6,
			y_offset = 48
		},
		{
			box = "play_title",
			align_box = "dlc",
			left_align = "left",
			bottom_align = "top",
			x_offset = 6,
			y_offset = 48
		}
	}
	return boxes, layout
end
