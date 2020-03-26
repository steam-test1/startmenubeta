require("lib/managers/menu/WalletGuiObject")
require("lib/utils/InventoryDescription")
local IS_WIN_32 = SystemInfo:platform() == Idstring("WIN32")
local NOT_WIN_32 = not IS_WIN_32
local TOP_ADJUSTMENT = NOT_WIN_32 and 50 or 55
local BOT_ADJUSTMENT = NOT_WIN_32 and 50 or 60
local select_anim = function(o, box, instant)
	if box.image_object then
		do
			local object = box.image_object
			local current_width = object.gui:w()
			local current_height = object.gui:h()
			local end_width = object.shape[3]
			local end_height = object.shape[4]
			local cx, cy = object.gui:center()
			if instant then
				object.gui:set_size(end_width, end_height)
				object.gui:set_center(cx, cy)
			else
				over(0.2, function(p)
					object.gui:set_size(math.lerp(current_width, end_width, p), math.lerp(current_height, end_height, p))
					object.gui:set_center(cx, cy)
				end)
			end
		end
	end
end
local unselect_anim = function(o, box, instant)
	if box.image_object then
		do
			local object = box.image_object
			local current_width = object.gui:w()
			local current_height = object.gui:h()
			local end_width = object.shape[3] * 0.8
			local end_height = object.shape[4] * 0.8
			local cx, cy = object.gui:center()
			if instant then
				object.gui:set_size(end_width, end_height)
				object.gui:set_center(cx, cy)
			else
				over(0.2, function(p)
					object.gui:set_size(math.lerp(current_width, end_width, p), math.lerp(current_height, end_height, p))
					object.gui:set_center(cx, cy)
				end)
			end
		end
	end
end
PlayerInventoryGui = PlayerInventoryGui or class()
local make_fine_text = function(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
end
function PlayerInventoryGui:init(ws, fullscreen_ws, node)
	self._ws = ws
	self._fullscreen_ws = fullscreen_ws
	self._node = node
	self._panel = self._ws:panel():panel()
	self._fullscreen_panel = self._fullscreen_ws:panel():panel()
	self._show_all_panel = self._ws:panel():panel({
		visible = false,
		w = self._ws:panel():w() * 0.75,
		h = tweak_data.menu.pd2_medium_font_size
	})
	self._show_all_panel:set_righttop(self._ws:panel():w(), 0)
	local show_all_text = self._show_all_panel:text({
		text = managers.localization:to_upper_text(managers.menu:is_pc_controller() and "menu_show_all" or "menu_legend_show_all", {
			BTN_X = managers.localization:btn_macro("menu_toggle_voice_message")
		}),
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		blend_mode = "add"
	})
	make_fine_text(show_all_text)
	show_all_text:set_right(self._show_all_panel:w())
	show_all_text:set_center_y(self._show_all_panel:h() / 2)
	if not managers.menu:is_pc_controller() then
		self._show_all_panel:set_bottom(self._ws:panel():h())
	end
	show_all_text:set_world_position(math.round(show_all_text:world_x()), math.round(show_all_text:world_y()))
	self._boxes = {}
	self._boxes_by_name = {}
	self._boxes_by_layer = {}
	self._mod_boxes = {}
	self._max_layer = 1
	managers.menu_component:close_contract_gui()
	self._data = node:parameters().menu_component_data or {selected_box = "character"}
	self._node:parameters().menu_component_data = self._data
	self._input_focus = 1
	WalletGuiObject.set_wallet(self._panel)
	local y = TOP_ADJUSTMENT
	local title_text = self._panel:text({
		name = "title",
		text = managers.localization:to_upper_text("menu_player_inventory"),
		font = tweak_data.menu.pd2_large_font,
		font_size = tweak_data.menu.pd2_large_font_size,
		color = tweak_data.screen_colors.text,
		layer = 1
	})
	make_fine_text(title_text)
	local back_button = self._panel:text({
		name = "back_button",
		text = managers.localization:to_upper_text("menu_back"),
		align = "right",
		vertical = "bottom",
		font = tweak_data.menu.pd2_large_font,
		font_size = tweak_data.menu.pd2_large_font_size,
		color = tweak_data.screen_colors.button_stage_3,
		layer = 1
	})
	make_fine_text(back_button)
	back_button:set_right(self._panel:w())
	back_button:set_bottom(self._panel:h())
	back_button:set_visible(managers.menu:is_pc_controller())
	if MenuBackdropGUI then
		local massive_font = tweak_data.menu.pd2_massive_font
		local massive_font_size = tweak_data.menu.pd2_massive_font_size
		local bg_text = self._fullscreen_panel:text({
			text = title_text:text(),
			h = 90,
			align = "left",
			vertical = "top",
			font = massive_font,
			font_size = massive_font_size,
			color = tweak_data.screen_colors.button_stage_3,
			alpha = 0.4
		})
		local x, y = managers.gui_data:safe_to_full_16_9(title_text:world_x(), title_text:world_center_y())
		bg_text:set_world_left(x)
		bg_text:set_world_center_y(y)
		bg_text:move(-13, 9)
		MenuBackdropGUI.animate_bg_text(self, bg_text)
		if managers.menu:is_pc_controller() then
			local bg_back = self._fullscreen_panel:text({
				name = "back_button",
				text = back_button:text(),
				h = 90,
				align = "right",
				vertical = "bottom",
				font = massive_font,
				font_size = massive_font_size,
				color = tweak_data.screen_colors.button_stage_3,
				alpha = 0.4,
				layer = 0
			})
			local x, y = managers.gui_data:safe_to_full_16_9(back_button:world_right(), back_button:world_center_y())
			bg_back:set_world_right(x)
			bg_back:set_world_center_y(y)
			bg_back:move(13, -9)
			MenuBackdropGUI.animate_bg_text(self, bg_back)
		end
	end
	local padding_x = 10
	local padding_y = 0
	local x = self._panel:w() - 500
	local y = TOP_ADJUSTMENT + tweak_data.menu.pd2_small_font_size
	local width = self._panel:w() - x
	local height = 540
	local combined_width = width - padding_x * 2
	local combined_height = height - padding_y * 3
	local box_width = combined_width / 3
	local box_height = combined_height / 4
	local player_loadout_data = managers.blackmarket:player_loadout_data()
	local primary_box = self:create_box({
		name = "primary",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("bm_menu_primaries"),
		text = player_loadout_data.primary.info_text,
		image = player_loadout_data.primary.item_texture,
		bg_image = player_loadout_data.primary.item_bg_texture,
		text_selected_color = player_loadout_data.primary.info_text_color,
		use_background = player_loadout_data.primary.item_bg_texture and true or false,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.white:with_alpha(0.75),
		bg_blend_mode = "normal",
		clbks = {
			left = callback(self, self, "open_primary_menu"),
			right = callback(self, self, "preview_primary"),
			up = callback(self, self, "previous_primary"),
			down = callback(self, self, "next_primary")
		}
	})
	local secondary_box = self:create_box({
		name = "secondary",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("bm_menu_secondaries"),
		text = player_loadout_data.secondary.info_text,
		image = player_loadout_data.secondary.item_texture,
		bg_image = player_loadout_data.secondary.item_bg_texture,
		text_selected_color = player_loadout_data.secondary.info_text_color,
		use_background = player_loadout_data.secondary.item_bg_texture and true or false,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.white:with_alpha(0.75),
		bg_blend_mode = "normal",
		clbks = {
			left = callback(self, self, "open_secondary_menu"),
			right = callback(self, self, "preview_secondary"),
			up = callback(self, self, "previous_secondary"),
			down = callback(self, self, "next_secondary")
		}
	})
	local melee_box = self:create_box({
		name = "melee",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("bm_menu_melee_weapons"),
		text = player_loadout_data.melee_weapon.info_text,
		image = player_loadout_data.melee_weapon.item_texture,
		dual_image = not player_loadout_data.melee_weapon.item_texture and {
			player_loadout_data.melee_weapon.dual_texture_1,
			player_loadout_data.melee_weapon.dual_texture_2
		},
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		bg_blend_mode = "normal",
		clbks = {
			left = callback(self, self, "open_melee_menu"),
			right = callback(self, self, "preview_melee"),
			up = callback(self, self, "previous_melee"),
			down = callback(self, self, "next_melee")
		}
	})
	local throwable_box = self:create_box({
		name = "throwable",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("bm_menu_grenades"),
		text = player_loadout_data.grenade.info_text,
		image = player_loadout_data.grenade.item_texture,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		bg_blend_mode = "normal",
		clbks = {
			left = callback(self, self, "open_throwable_menu"),
			right = callback(self, self, "preview_throwable"),
			up = callback(self, self, "previous_throwable"),
			down = callback(self, self, "next_throwable")
		}
	})
	local armor_box = self:create_box({
		name = "armor",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("bm_menu_armors"),
		text = player_loadout_data.armor.info_text,
		image = player_loadout_data.armor.item_texture,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		bg_blend_mode = "normal",
		clbks = {
			left = callback(self, self, "open_armor_menu"),
			right = false,
			up = callback(self, self, "previous_armor"),
			down = callback(self, self, "next_armor")
		}
	})
	local deployable_box = self:create_box({
		name = "deployable",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("bm_menu_deployables"),
		text = player_loadout_data.deployable.info_text,
		image = player_loadout_data.deployable.item_texture,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		bg_blend_mode = "normal",
		clbks = {
			left = callback(self, self, "open_deployable_menu"),
			right = false,
			up = callback(self, self, "previous_deployable"),
			down = callback(self, self, "next_deployable")
		}
	})
	local mask_box = self:create_box({
		name = "mask",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("bm_menu_masks"),
		text = player_loadout_data.mask.info_text,
		image = player_loadout_data.mask.item_texture,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		bg_blend_mode = "normal",
		clbks = {
			left = callback(self, self, "open_mask_menu"),
			right = callback(self, self, "preview_mask"),
			up = callback(self, self, "previous_mask"),
			down = callback(self, self, "next_mask")
		}
	})
	if managers.network:session() then
	else
	end
	local character_box = self:create_box({
		name = "character",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("menu_preferred_character"),
		text = player_loadout_data.character.info_text,
		image = player_loadout_data.character.item_texture,
		alpha = managers.network:session() and 0.2 or 1,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		bg_blend_mode = "normal",
		clbks = {right = false} or {
			left = callback(self, self, "open_character_menu"),
			right = false,
			up = callback(self, self, "previous_character"),
			down = callback(self, self, "next_character")
		}
	})
	if managers.network:session() then
	else
	end
	local infamy_box = self:create_box({
		name = "infamy",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("menu_infamytree"),
		text = managers.localization:to_upper_text("menu_infamytree"),
		alpha = managers.network:session() and 0.2 or 1,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		bg_blend_mode = "normal",
		clbks = {right = false} or {
			left = callback(self, self, "open_infamy_menu"),
			right = false,
			up = false,
			down = false
		}
	})
	local skill_box = self:create_box({
		name = "skilltree",
		w = box_width,
		h = box_height,
		unselected_text = managers.localization:to_upper_text("menu_st_skilltree"),
		text = managers.localization:text("menu_st_skill_switch_set", {
			skill_switch = managers.skilltree:get_skill_switch_name(managers.skilltree:get_selected_skill_switch(), true)
		}),
		image = false,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		bg_blend_mode = "normal",
		clbks = {
			left = callback(self, self, "open_skilltree_menu"),
			right = false,
			up = callback(self, self, "previous_skilltree"),
			down = callback(self, self, "next_skilltree")
		}
	})
	local texture_rect_x = 0
	local texture_rect_y = 0
	local current_specialization = managers.skilltree:get_specialization_value("current_specialization")
	local specialization_data = tweak_data.skilltree.specializations[current_specialization]
	local specialization_text = specialization_data and managers.localization:text(specialization_data.name_id) or " "
	local guis_catalog = "guis/"
	if specialization_data then
		local current_tier = managers.skilltree:get_specialization_value(current_specialization, "tiers", "current_tier")
		local max_tier = managers.skilltree:get_specialization_value(current_specialization, "tiers", "max_tier")
		local tier_data = specialization_data[max_tier]
		if tier_data then
			texture_rect_x = tier_data.icon_xy and tier_data.icon_xy[1] or 0
			texture_rect_y = tier_data.icon_xy and tier_data.icon_xy[2] or 0
			if tier_data.texture_bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(tier_data.texture_bundle_folder) .. "/"
			end
			specialization_text = specialization_text .. " (" .. tostring(current_tier) .. "/" .. tostring(max_tier) .. ")"
		end
	end
	local icon_atlas_texture = guis_catalog .. "textures/pd2/specialization/icons_atlas"
	local specialization_box = self:create_box({
		name = "specialization",
		w = box_width,
		h = box_height,
		image_size_mul = 0.8,
		unselected_text = managers.localization:to_upper_text("menu_specialization"),
		text = specialization_text,
		image = icon_atlas_texture,
		image_rect = {
			texture_rect_x * 64,
			texture_rect_y * 64,
			64,
			64
		},
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		bg_blend_mode = "normal",
		clbks = {
			left = callback(self, self, "open_specialization_menu"),
			right = false,
			up = callback(self, self, "previous_specialization"),
			down = callback(self, self, "next_specialization")
		}
	})
	local box_matrix = {
		{
			"character",
			"primary",
			"deployable"
		},
		{
			"mask",
			"secondary",
			"armor"
		},
		{
			"infamy",
			"melee",
			"skilltree"
		},
		{
			nil,
			"throwable",
			"specialization"
		}
	}
	self:sort_boxes_by_matrix(box_matrix)
	local character_panel = self._panel:panel()
	local weapons_panel = self._panel:panel()
	local eqpt_skills_panel = self._panel:panel()
	character_panel:set_shape(character_box:left(), character_box:top(), infamy_box:right() - character_box:left(), infamy_box:bottom() - character_box:top())
	weapons_panel:set_shape(primary_box:left(), primary_box:top(), throwable_box:right() - primary_box:left(), throwable_box:bottom() - primary_box:top())
	eqpt_skills_panel:set_shape(deployable_box:left(), deployable_box:top(), specialization_box:right() - deployable_box:left(), specialization_box:bottom() - deployable_box:top())
	character_panel:set_w(math.floor(eqpt_skills_panel:w()))
	weapons_panel:set_w(math.floor(eqpt_skills_panel:w()))
	eqpt_skills_panel:set_w(math.floor(eqpt_skills_panel:w()))
	eqpt_skills_panel:set_right(self._panel:w())
	weapons_panel:set_right(eqpt_skills_panel:left() - padding_x)
	character_panel:set_right(weapons_panel:left() - padding_x)
	character_panel:rect({
		color = Color.black,
		alpha = 0.4
	})
	weapons_panel:rect({
		color = Color.black,
		alpha = 0.4
	})
	eqpt_skills_panel:rect({
		color = Color.black,
		alpha = 0.4
	})
	local column_one_box_panel = self._panel:panel()
	column_one_box_panel:set_shape(character_panel:shape())
	local column_two_box_panel = self._panel:panel()
	column_two_box_panel:set_shape(weapons_panel:shape())
	local column_three_box_panel = self._panel:panel()
	column_three_box_panel:set_shape(eqpt_skills_panel:shape())
	self._column_one_box = BoxGuiObject:new(column_one_box_panel, {
		sides = {
			1,
			1,
			2,
			2
		}
	})
	self._column_two_box = BoxGuiObject:new(column_two_box_panel, {
		sides = {
			1,
			1,
			2,
			2
		}
	})
	self._column_three_box = BoxGuiObject:new(column_three_box_panel, {
		sides = {
			1,
			1,
			2,
			2
		}
	})
	local character_text = self._panel:text({
		text = managers.localization:to_upper_text("menu_player_column_one_title"),
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		blend_mode = "add",
		color = tweak_data.screen_colors.text
	})
	local weapons_text = self._panel:text({
		text = managers.localization:to_upper_text("menu_player_column_two_title"),
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		blend_mode = "add",
		color = tweak_data.screen_colors.text
	})
	local eqpt_skills_text = self._panel:text({
		text = managers.localization:to_upper_text("menu_player_column_three_title"),
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		blend_mode = "add",
		color = tweak_data.screen_colors.text
	})
	make_fine_text(character_text)
	make_fine_text(weapons_text)
	make_fine_text(eqpt_skills_text)
	character_text:set_rightbottom(character_panel:right(), character_panel:top())
	weapons_text:set_rightbottom(weapons_panel:right(), weapons_panel:top())
	eqpt_skills_text:set_rightbottom(eqpt_skills_panel:right(), eqpt_skills_panel:top())
	local alias_text = self._panel:text({
		x = 2,
		y = TOP_ADJUSTMENT,
		text = tostring(managers.network.account:username() or managers.blackmarket:get_preferred_character_real_name()),
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		blend_mode = "add",
		color = tweak_data.screen_colors.text
	})
	make_fine_text(alias_text)
	local player_panel = self._panel:panel({
		x = 0,
		y = TOP_ADJUSTMENT + tweak_data.menu.pd2_small_font_size,
		w = 320,
		h = 310
	})
	self._player_panel = player_panel
	self._player_box_panel = self._panel:panel()
	self._player_box_panel:set_shape(player_panel:shape())
	self._player_box = BoxGuiObject:new(self._player_box_panel, {
		sides = {
			1,
			1,
			2,
			1
		}
	})
	local next_level_data = managers.experience:next_level_data() or {}
	local player_level = managers.experience:current_level()
	local player_rank = managers.experience:current_rank()
	local is_infamous = player_rank > 0
	local size = 96
	local player_level_panel = player_panel:panel({
		name = "player_level_panel",
		w = size,
		h = size,
		x = 10,
		y = 10
	})
	player_level_panel:bitmap({
		texture = "guis/textures/pd2/endscreen/exp_ring",
		texture_rect = {
			16,
			16,
			224,
			224
		},
		w = size,
		h = size,
		color = Color.white,
		alpha = 0.4
	})
	player_level_panel:bitmap({
		texture = "guis/textures/pd2/endscreen/exp_ring",
		texture_rect = {
			16,
			16,
			224,
			224
		},
		color = Color((next_level_data.current_points or 1) / (next_level_data.points or 1), 1, 1),
		w = size,
		h = size,
		layer = 1,
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add"
	})
	player_level_panel:text({
		text = tostring(player_level),
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		align = "center",
		vertical = "center"
	})
	local player_rank_panel = character_panel:panel({
		name = "player_rank_panel",
		w = size / 2,
		h = size / 2,
		x = player_level_panel:right() + 2,
		y = player_level_panel:top()
	})
	local texture, texture_rect = "guis/textures/pd2/inv_infamycard_bg", {
		0,
		0,
		29,
		43
	}
	local player_rank_bitmap = player_rank_panel:bitmap({texture = texture, texture_rect = texture_rect})
	do
		local panel_width = player_rank_panel:width()
		local panel_height = player_rank_panel:height()
		local texture_width = 64
		local texture_height = 92
		local aspect = panel_width / panel_height
		local sw = math.max(texture_width, texture_height * aspect)
		local sh = math.max(texture_height, texture_width / aspect)
		local dw = texture_width / sw
		local dh = texture_height / sh
		player_rank_bitmap:set_size(math.round(dw * panel_width * 0.9), math.round(dh * panel_height * 0.9))
		player_rank_bitmap:set_center(panel_width / 2, panel_height / 2)
	end
	local rank_text = player_rank_panel:text({
		text = managers.experience:rank_string(player_rank),
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		align = "center",
		vertical = "center",
		layer = 1,
		color = Color.black
	})
	local _, _, w, _ = rank_text:text_rect()
	if w > 0 and w >= player_rank_bitmap:w() - 6 then
		rank_text:set_font_size(rank_text:font_size() * ((player_rank_bitmap:w() - 6) / w))
	end
	player_rank_panel:set_layer(1)
	player_rank_panel:set_world_center(infamy_box:world_center())
	player_rank_panel:set_alpha(managers.network:session() and 0.2 or 1)
	local detection_panel = player_panel:panel({
		name = "detection_panel",
		layer = 0,
		x = 0,
		y = player_level_panel:top(),
		w = size - tweak_data.menu.pd2_small_font_size * 2,
		h = size - tweak_data.menu.pd2_small_font_size * 2
	})
	detection_panel:set_right(player_panel:w() - 10)
	local detection_ring_left_bg = detection_panel:bitmap({
		name = "detection_left_bg",
		texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
		alpha = 0.2,
		blend_mode = "add",
		layer = 0,
		w = detection_panel:w(),
		h = detection_panel:h()
	})
	local detection_ring_right_bg = detection_panel:bitmap({
		name = "detection_right_bg",
		texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
		alpha = 0.2,
		blend_mode = "add",
		layer = 0,
		w = detection_panel:w(),
		h = detection_panel:h()
	})
	detection_ring_right_bg:set_texture_rect(64, 0, -64, 64)
	local detection_ring_left = detection_panel:bitmap({
		name = "detection_left",
		texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
		alpha = 0.5,
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		layer = 1,
		w = detection_panel:w(),
		h = detection_panel:h()
	})
	local detection_ring_right = detection_panel:bitmap({
		name = "detection_right",
		texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
		alpha = 0.5,
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		layer = 1,
		w = detection_panel:w(),
		h = detection_panel:h()
	})
	detection_ring_right:set_texture_rect(64, 0, -64, 64)
	local detection_ring_left2 = detection_panel:bitmap({
		name = "detection_left2",
		texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
		alpha = 0.5,
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		layer = 1,
		w = detection_panel:w(),
		h = detection_panel:h()
	})
	local detection_ring_right2 = detection_panel:bitmap({
		name = "detection_right2",
		texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
		alpha = 0.5,
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		layer = 1,
		w = detection_panel:w(),
		h = detection_panel:h()
	})
	detection_ring_right2:set_texture_rect(64, 0, -64, 64)
	local detection_value = detection_panel:text({
		name = "detection_value",
		text = "",
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		alpha = 1,
		visible = true,
		blend_mode = "add",
		w = 64,
		h = 64
	})
	local detection_text = player_panel:text({
		name = "detection_text",
		text = managers.localization:to_upper_text("bm_menu_stats_detection"),
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		alpha = 1,
		visible = true,
		blend_mode = "add"
	})
	make_fine_text(detection_text)
	detection_panel:move(0, detection_text:h())
	detection_text:set_right(detection_panel:right())
	detection_text:set_bottom(detection_panel:top())
	self._player_stats_panel = player_panel:panel({
		name = "player_stats_panel",
		x = 10,
		w = player_panel:w() - 20,
		h = 160
	})
	self._player_stats_panel:set_bottom(player_panel:h() - 10)
	self:setup_player_stats(self._player_stats_panel)
	local info_panel = self._panel:panel({
		name = "info_panel",
		x = 0,
		y = player_panel:bottom() + 10,
		w = player_panel:w(),
		h = self._panel:h() - player_panel:top() - BOT_ADJUSTMENT - player_panel:h() - 10
	})
	BoxGuiObject:new(info_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	local info_content_panel = info_panel:panel({layer = 1})
	info_content_panel:grow(-20, -20)
	info_content_panel:move(10, 10)
	self._info_text = info_content_panel:text({
		text = "",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.screen_colors.text,
		wrap = true,
		word_wrap = true,
		blend_mode = "add"
	})
	self._info_panel = info_content_panel:panel({layer = 1})
	self:set_info_text("")
	self._legends_panel = self._panel:panel({
		w = self._panel:w() * 0.75,
		h = tweak_data.menu.pd2_medium_font_size
	})
	self._legends = {}
	if managers.menu:is_pc_controller() then
		self._legends_panel:set_righttop(self._panel:w(), 0)
		if not managers.menu:is_steam_controller() then
			do
				local panel = self._legends_panel:panel({name = "select", visible = false})
				local icon = panel:bitmap({
					name = "icon",
					texture = "guis/textures/pd2/mouse_buttons",
					texture_rect = {
						1,
						1,
						17,
						23
					},
					w = 17,
					h = 23,
					blend_mode = "add"
				})
				local text = panel:text({
					text = managers.localization:to_upper_text("menu_mouse_select"),
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					color = tweak_data.screen_colors.text,
					blend_mode = "add"
				})
				make_fine_text(text)
				text:set_left(icon:right() + 2)
				text:set_center_y(icon:center_y())
				panel:set_w(text:right())
				self._legends.select = panel
			end
			do
				local panel = self._legends_panel:panel({name = "preview", visible = false})
				local icon = panel:bitmap({
					name = "icon",
					texture = "guis/textures/pd2/mouse_buttons",
					texture_rect = {
						18,
						1,
						17,
						23
					},
					w = 17,
					h = 23,
					blend_mode = "add"
				})
				local text = panel:text({
					text = managers.localization:to_upper_text("menu_mouse_preview"),
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					color = tweak_data.screen_colors.text,
					blend_mode = "add"
				})
				make_fine_text(text)
				text:set_left(icon:right() + 2)
				text:set_center_y(icon:center_y())
				panel:set_w(text:right())
				self._legends.preview = panel
			end
			local panel = self._legends_panel:panel({name = "switch", visible = false})
			local icon = panel:bitmap({
				name = "icon",
				texture = "guis/textures/pd2/mouse_buttons",
				texture_rect = {
					35,
					1,
					17,
					23
				},
				w = 17,
				h = 23,
				blend_mode = "add"
			})
			local text = panel:text({
				text = managers.localization:to_upper_text("menu_mouse_switch"),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				color = tweak_data.screen_colors.text,
				blend_mode = "add"
			})
			make_fine_text(text)
			text:set_left(icon:right() + 2)
			text:set_center_y(icon:center_y())
			panel:set_w(text:right())
			self._legends.switch = panel
		else
			do
				local panel = self._legends_panel:panel({name = "select", visible = false})
				local text = panel:text({
					text = managers.localization:steam_btn("grip_l") .. " " .. managers.localization:to_upper_text("menu_mouse_select"),
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					color = tweak_data.screen_colors.text,
					blend_mode = "add"
				})
				make_fine_text(text)
				text:set_center_y(panel:h() / 2)
				panel:set_w(text:right())
				self._legends.select = panel
			end
			do
				local panel = self._legends_panel:panel({name = "preview", visible = false})
				local text = panel:text({
					text = managers.localization:steam_btn("grip_r") .. " " .. managers.localization:to_upper_text("menu_mouse_preview"),
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					color = tweak_data.screen_colors.text,
					blend_mode = "add"
				})
				make_fine_text(text)
				text:set_center_y(panel:h() / 2)
				panel:set_w(text:right())
				self._legends.preview = panel
			end
			local panel = self._legends_panel:panel({name = "switch", visible = false})
			local text = panel:text({
				text = managers.localization:btn_macro("previous_page") .. managers.localization:btn_macro("next_page") .. " " .. managers.localization:to_upper_text("menu_mouse_switch"),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				color = tweak_data.screen_colors.text,
				blend_mode = "add"
			})
			make_fine_text(text)
			text:set_center_y(panel:h() / 2)
			panel:set_w(text:right())
			self._legends.switch = panel
		end
		local panel = self._legends_panel:panel({name = "hide_all", visible = false})
		local text = panel:text({
			text = managers.localization:to_upper_text("menu_hide_all", {
				BTN_X = managers.localization:btn_macro("menu_toggle_voice_message")
			}),
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.text,
			blend_mode = "add"
		})
		make_fine_text(text)
		text:set_center_y(panel:h() / 2)
		panel:set_w(text:right())
		self._legends.hide_all = panel
	else
		self._legends_panel:set_rightbottom(self._panel:w(), self._panel:h())
		self._legends_panel:text({
			name = "text",
			text = "",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.text,
			blend_mode = "add",
			align = "right",
			halign = "right",
			valign = "bottom",
			vertical = "bottom"
		})
	end
	self._text_buttons = {}
	do
		local alias_show_button, alias_hide_button, column_one_show_button, column_one_hide_button, column_two_show_button, column_two_hide_button, column_three_show_button, column_three_hide_button
		local function alias_hide_func()
			if alive(alias_show_button) then
				alias_show_button:hide()
			end
			if alive(alias_hide_button) then
				alias_hide_button:show()
			end
			if alive(self._player_panel) then
				self._player_panel:hide()
			end
			if alive(self._player_box_panel) then
				self._player_box:create_sides(self._player_box_panel, {
					sides = {
						0,
						0,
						2,
						0
					}
				})
			end
			if alive(info_panel) then
				info_panel:hide()
			end
		end
		local function alias_show_func()
			if alive(alias_show_button) then
				alias_show_button:show()
			end
			if alive(alias_hide_button) then
				alias_hide_button:hide()
			end
			if alive(self._player_panel) then
				self._player_panel:show()
			end
			if alive(self._player_box_panel) then
				self._player_box:create_sides(self._player_box_panel, {
					sides = {
						1,
						1,
						2,
						1
					}
				})
			end
			if alive(info_panel) then
				info_panel:show()
			end
		end
		local function column_one_hide_func()
			if alive(column_one_show_button) then
				column_one_show_button:hide()
			end
			if alive(column_one_hide_button) then
				column_one_hide_button:show()
			end
			if alive(character_panel) then
				character_panel:hide()
			end
			if alive(column_one_box_panel) then
				self._column_one_box:create_sides(column_one_box_panel, {
					sides = {
						0,
						0,
						2,
						0
					}
				})
			end
			local box
			for _, boxes in ipairs(box_matrix) do
				box = boxes[1] and self._boxes_by_name[boxes[1]]
				if box then
					box.panel:hide()
				end
			end
		end
		local function column_one_show_func()
			if alive(column_one_show_button) then
				column_one_show_button:show()
			end
			if alive(column_one_hide_button) then
				column_one_hide_button:hide()
			end
			if alive(character_panel) then
				character_panel:show()
			end
			if alive(column_one_box_panel) then
				self._column_one_box:create_sides(column_one_box_panel, {
					sides = {
						1,
						1,
						2,
						1
					}
				})
			end
			local box
			for _, boxes in ipairs(box_matrix) do
				box = boxes[1] and self._boxes_by_name[boxes[1]]
				if box then
					box.panel:show()
				end
			end
		end
		local function column_two_hide_func()
			if alive(column_two_show_button) then
				column_two_show_button:hide()
			end
			if alive(column_two_hide_button) then
				column_two_hide_button:show()
			end
			if alive(weapons_panel) then
				weapons_panel:hide()
			end
			if alive(column_two_box_panel) then
				self._column_two_box:create_sides(column_two_box_panel, {
					sides = {
						0,
						0,
						2,
						0
					}
				})
			end
			local box
			for _, boxes in ipairs(box_matrix) do
				box = boxes[2] and self._boxes_by_name[boxes[2]]
				if box then
					box.panel:hide()
				end
			end
			for _, box in ipairs(self._boxes_by_layer[2]) do
				box.panel:hide()
			end
		end
		local function column_two_show_func()
			if alive(column_two_show_button) then
				column_two_show_button:show()
			end
			if alive(column_two_hide_button) then
				column_two_hide_button:hide()
			end
			if alive(weapons_panel) then
				weapons_panel:show()
			end
			if alive(column_two_box_panel) then
				self._column_two_box:create_sides(column_two_box_panel, {
					sides = {
						1,
						1,
						2,
						1
					}
				})
			end
			local box
			for _, boxes in ipairs(box_matrix) do
				box = boxes[2] and self._boxes_by_name[boxes[2]]
				if box then
					box.panel:show()
				end
			end
			for _, box in ipairs(self._boxes_by_layer[2]) do
				box.panel:show()
			end
		end
		local function column_three_hide_func()
			if alive(column_three_show_button) then
				column_three_show_button:hide()
			end
			if alive(column_three_hide_button) then
				column_three_hide_button:show()
			end
			if alive(eqpt_skills_panel) then
				eqpt_skills_panel:hide()
			end
			if alive(column_three_box_panel) then
				self._column_three_box:create_sides(column_three_box_panel, {
					sides = {
						0,
						0,
						2,
						0
					}
				})
			end
			local box
			for _, boxes in ipairs(box_matrix) do
				box = boxes[3] and self._boxes_by_name[boxes[3]]
				if box then
					box.panel:hide()
				end
			end
			for _, box in ipairs(self._boxes_by_layer[3]) do
				box.panel:hide()
			end
		end
		local function column_three_show_func()
			if alive(column_three_show_button) then
				column_three_show_button:show()
			end
			if alive(column_three_hide_button) then
				column_three_hide_button:hide()
			end
			if alive(eqpt_skills_panel) then
				eqpt_skills_panel:show()
			end
			if alive(column_three_box_panel) then
				self._column_three_box:create_sides(column_three_box_panel, {
					sides = {
						1,
						1,
						2,
						1
					}
				})
			end
			local box
			for _, boxes in ipairs(box_matrix) do
				box = boxes[3] and self._boxes_by_name[boxes[3]]
				if box then
					box.panel:show()
				end
			end
			for _, box in ipairs(self._boxes_by_layer[3]) do
				box.panel:show()
			end
		end
		self._show_hide_data = {}
		self._show_hide_data.panels = {
			self._player_panel,
			character_panel,
			weapons_panel,
			eqpt_skills_panel
		}
		self._show_hide_data.show_funcs = {
			alias_show_func,
			column_one_show_func,
			column_two_show_func,
			column_three_show_func
		}
		self._show_hide_data.hide_funcs = {
			alias_hide_func,
			column_one_hide_func,
			column_two_hide_func,
			column_three_hide_func
		}
		if managers.menu:is_pc_controller() then
			local show_string = managers.localization:to_upper_text("menu_button_hide")
			local hide_string = managers.localization:to_upper_text("menu_button_show")
			alias_show_button = self:create_text_button({
				left = alias_text:right() + 2,
				top = alias_text:top(),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = show_string,
				clbk = alias_hide_func,
				alpha = 0.1
			})
			alias_hide_button = self:create_text_button({
				disabled = true,
				left = alias_show_button:left(),
				top = alias_show_button:top(),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = hide_string,
				clbk = alias_show_func
			})
			column_one_show_button = self:create_text_button({
				right = character_text:left() - 2,
				top = character_text:top(),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = show_string,
				clbk = column_one_hide_func,
				alpha = 0.1
			})
			column_one_hide_button = self:create_text_button({
				disabled = true,
				right = column_one_show_button:right(),
				top = column_one_show_button:top(),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = hide_string,
				clbk = column_one_show_func
			})
			column_two_show_button = self:create_text_button({
				right = weapons_text:left() - 2,
				top = weapons_text:top(),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = show_string,
				clbk = column_two_hide_func,
				alpha = 0.1
			})
			column_two_hide_button = self:create_text_button({
				disabled = true,
				right = column_two_show_button:right(),
				top = column_two_show_button:top(),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = hide_string,
				clbk = column_two_show_func
			})
			column_three_show_button = self:create_text_button({
				right = eqpt_skills_text:left() - 2,
				top = eqpt_skills_text:top(),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = show_string,
				clbk = column_three_hide_func,
				alpha = 0.1
			})
			column_three_hide_button = self:create_text_button({
				disabled = true,
				right = column_three_show_button:right(),
				top = column_three_show_button:top(),
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = hide_string,
				clbk = column_three_show_func
			})
			local alias_big_panel = self._panel:panel({})
			alias_big_panel:set_w(self._player_panel:w())
			alias_big_panel:set_x(self._player_panel:x())
			local column_one_big_panel = self._panel:panel({})
			column_one_big_panel:set_w(character_panel:w())
			column_one_big_panel:set_x(character_panel:x())
			local column_two_big_panel = self._panel:panel({})
			column_two_big_panel:set_w(weapons_panel:w())
			column_two_big_panel:set_x(weapons_panel:x())
			local column_three_big_panel = self._panel:panel({})
			column_three_big_panel:set_w(eqpt_skills_panel:w())
			column_three_big_panel:set_x(eqpt_skills_panel:x())
			self._change_alpha_table = {
				{panel = alias_big_panel, button = alias_show_button},
				{panel = column_one_big_panel, button = column_one_show_button},
				{panel = column_two_big_panel, button = column_two_show_button},
				{panel = column_three_big_panel, button = column_three_show_button}
			}
		end
	end
	self:_round_everything()
	local box = self:_get_selected_box()
	if box then
		box.selected = true
		self:_update_stats(box.name)
		self:_update_box_status(box, true)
		self:_update_legends(box.name)
		if box.select_anim then
			box.panel:stop()
			box.panel:animate(box.select_anim, box, true)
		end
	end
	self:update_detection()
	self:_update_player_stats()
	self:_update_mod_boxes()
end
function PlayerInventoryGui:_update_legends(name)
