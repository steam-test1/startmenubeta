require("lib/managers/menu/SkillTreeGui")
require("lib/managers/menu/InfamyTreeGui")
require("lib/managers/menu/BlackMarketGui")
require("lib/managers/menu/InventoryList")
require("lib/managers/menu/MissionBriefingGui")
require("lib/managers/menu/StageEndScreenGui")
require("lib/managers/menu/LootDropScreenGUI")
require("lib/managers/menu/CrimeNetContractGui")
require("lib/managers/menu/CrimeNetFiltersGui")
require("lib/managers/menu/CrimeNetCasinoGui")
require("lib/managers/menu/MenuSceneGui")
require("lib/managers/menu/PlayerProfileGuiObject")
require("lib/managers/menu/IngameContractGui")
require("lib/managers/menu/IngameManualGui")
require("lib/managers/menu/PrePlanningMapGui")
require("lib/managers/menu/GameInstallingGui")
require("lib/managers/menu/PlayerInventoryGui")
require("lib/managers/hud/HUDLootScreen")
require("lib/managers/menu/MainMenuGui")
MenuComponentManager = MenuComponentManager or class()
function MenuComponentManager:init()
	self._ws = Overlay:gui():create_screen_workspace()
	self._fullscreen_ws = managers.gui_data:create_fullscreen_16_9_workspace()
	managers.gui_data:layout_workspace(self._ws)
	self._main_panel = self._ws:panel():panel()
	self._requested_textures = {}
	self._block_texture_requests = false
	self._REFRESH_FRIENDS_TIME = 5
	self._refresh_friends_t = TimerManager:main():time() + self._REFRESH_FRIENDS_TIME
	self._sound_source = SoundDevice:create_source("MenuComponentManager")
	self._resolution_changed_callback_id = managers.viewport:add_resolution_changed_func(callback(self, self, "resolution_changed"))
	self._request_done_clbk_func = callback(self, self, "_request_done_callback")
	self._preplanning_saved_draws = {}
	local is_installing, install_progress = managers.dlc:is_installing()
	self._is_game_installing = is_installing
	self._crimenet_enabled = not is_installing
	self._crimenet_offline_enabled = not is_installing
	self._active_components = {}
	self._active_components.news = {
		create = callback(self, self, "_create_newsfeed_gui"),
		close = callback(self, self, "close_newsfeed_gui")
	}
	self._active_components.profile = {
		create = callback(self, self, "_create_profile_gui"),
		close = callback(self, self, "_disable_profile_gui")
	}
	self._active_components.friends = {
		create = callback(self, self, "_create_friends_gui"),
		close = callback(self, self, "_disable_friends_gui")
	}
	self._active_components.chats = {
		create = callback(self, self, "_create_chat_gui"),
		close = callback(self, self, "_disable_chat_gui")
	}
	self._active_components.lobby_chats = {
		create = callback(self, self, "_create_lobby_chat_gui"),
		close = callback(self, self, "hide_lobby_chat_gui")
	}
	self._active_components.crimenet_chats = {
		create = callback(self, self, "_create_crimenet_chats_gui"),
		close = callback(self, self, "hide_crimenet_chat_gui")
	}
	self._active_components.preplanning_chats = {
		create = callback(self, self, "_create_preplanning_chats_gui"),
		close = callback(self, self, "hide_preplanning_chat_gui")
	}
	self._active_components.contract = {
		create = callback(self, self, "_create_contract_gui"),
		close = callback(self, self, "_disable_contract_gui")
	}
	self._active_components.server_info = {
		create = callback(self, self, "_create_server_info_gui"),
		close = callback(self, self, "_disable_server_info_gui")
	}
	self._active_components.debug_strings = {
		create = callback(self, self, "_create_debug_strings_gui"),
		close = callback(self, self, "_disable_debug_strings_gui")
	}
	self._active_components.debug_fonts = {
		create = callback(self, self, "_create_debug_fonts_gui"),
		close = callback(self, self, "_disable_debug_fonts_gui")
	}
	self._active_components.skilltree = {
		create = callback(self, self, "_create_skilltree_gui"),
		close = callback(self, self, "close_skilltree_gui")
	}
	self._active_components.infamytree = {
		create = callback(self, self, "_create_infamytree_gui"),
		close = callback(self, self, "close_infamytree_gui")
	}
	self._active_components.crimenet = {
		create = callback(self, self, "_create_crimenet_gui"),
		close = callback(self, self, "close_crimenet_gui")
	}
	self._active_components.crimenet_contract = {
		create = callback(self, self, "_create_crimenet_contract_gui"),
		close = callback(self, self, "close_crimenet_contract_gui")
	}
	self._active_components.crimenet_filters = {
		create = callback(self, self, "_create_crimenet_filters_gui"),
		close = callback(self, self, "close_crimenet_filters_gui")
	}
	self._active_components.crimenet_casino = {
		create = callback(self, self, "_create_crimenet_casino_gui"),
		close = callback(self, self, "close_crimenet_casino_gui")
	}
	self._active_components.lootdrop_casino = {
		create = callback(self, self, "_create_lootdrop_casino_gui"),
		close = callback(self, self, "close_lootdrop_casino_gui")
	}
	self._active_components.blackmarket = {
		create = callback(self, self, "_create_blackmarket_gui"),
		close = callback(self, self, "close_blackmarket_gui")
	}
	self._active_components.mission_briefing = {
		create = callback(self, self, "_create_mission_briefing_gui"),
		close = callback(self, self, "_hide_mission_briefing_gui")
	}
	self._active_components.stage_endscreen = {
		create = callback(self, self, "_create_stage_endscreen_gui"),
		close = callback(self, self, "_hide_stage_endscreen_gui")
	}
	self._active_components.lootdrop = {
		create = callback(self, self, "_create_lootdrop_gui"),
		close = callback(self, self, "_hide_lootdrop_gui")
	}
	self._active_components.menuscene_info = {
		create = callback(self, self, "_create_menuscene_info_gui"),
		close = callback(self, self, "_close_menuscene_info_gui")
	}
	self._active_components.player_profile = {
		create = callback(self, self, "_create_player_profile_gui"),
		close = callback(self, self, "close_player_profile_gui")
	}
	self._active_components.ingame_contract = {
		create = callback(self, self, "_create_ingame_contract_gui"),
		close = callback(self, self, "close_ingame_contract_gui")
	}
	self._active_components.ingame_manual = {
		create = callback(self, self, "_create_ingame_manual_gui"),
		close = callback(self, self, "close_ingame_manual_gui")
	}
	self._active_components.inventory_list = {
		create = callback(self, self, "_create_inventory_list_gui"),
		close = callback(self, self, "close_inventory_list_gui")
	}
	self._active_components.preplanning_map = {
		create = callback(self, self, "create_preplanning_map_gui"),
		close = callback(self, self, "close_preplanning_map_gui")
	}
	self._active_components.game_installing = {
		create = callback(self, self, "create_game_installing_gui"),
		close = callback(self, self, "close_game_installing_gui")
	}
	self._active_components.inventory = {
		create = callback(self, self, "create_inventory_gui"),
		close = callback(self, self, "close_inventory_gui")
	}
	self._active_components.main_menu = {
		create = callback(self, self, "create_main_menu_gui"),
		close = callback(self, self, "close_main_menu_gui")
	}
end
function MenuComponentManager:save(data)
end
function MenuComponentManager:load(data)
	self:on_whisper_mode_changed()
end
function MenuComponentManager:get_controller_input_bool(button)
	if not managers.menu or not managers.menu:active_menu() then
		return
	end
	local controller = managers.menu:active_menu().input:get_controller_class()
	if managers.menu:active_menu().input:get_accept_input() then
		return controller:get_input_bool(button)
	end
end
function MenuComponentManager:_setup_controller_input()
	if not self._controller_connected then
		self._left_axis_vector = Vector3()
		self._right_axis_vector = Vector3()
		self._fullscreen_ws:connect_controller(managers.menu:active_menu().input:get_controller(), true)
		self._fullscreen_ws:panel():axis_move(callback(self, self, "_axis_move"))
		self._controller_connected = true
		if SystemInfo:platform() == Idstring("WIN32") then
			self._fullscreen_ws:connect_keyboard(Input:keyboard())
			self._fullscreen_ws:panel():key_press(callback(self, self, "key_press_controller_support"))
		end
	end
end
function MenuComponentManager:_destroy_controller_input()
	if self._controller_connected then
		self._fullscreen_ws:disconnect_all_controllers()
		if alive(self._fullscreen_ws:panel()) then
			self._fullscreen_ws:panel():axis_move(nil)
		end
		self._controller_connected = nil
		if SystemInfo:platform() == Idstring("WIN32") then
			self._fullscreen_ws:disconnect_keyboard()
			self._fullscreen_ws:panel():key_press(nil)
		end
	end
end
function MenuComponentManager:key_press_controller_support(o, k)
	if not MenuCallbackHandler:can_toggle_chat() then
		return
	end
	local toggle_chat = Idstring(managers.controller:get_settings("pc"):get_connection("toggle_chat"):get_input_name_list()[1])
	if k == toggle_chat then
		if self._game_chat_gui and self._game_chat_gui:enabled() then
			self._game_chat_gui:open_page()
			return
		end
		if managers.hud and not managers.hud:chat_focus() and managers.menu:toggle_chatinput() then
			managers.hud:set_chat_skip_first(true)
		end
		return
	end
end
function MenuComponentManager:saferect_ws()
	return self._ws
end
function MenuComponentManager:fullscreen_ws()
	return self._fullscreen_ws
end
function MenuComponentManager:resolution_changed()
	managers.gui_data:layout_workspace(self._ws)
	managers.gui_data:layout_fullscreen_16_9_workspace(self._fullscreen_ws)
	if self._tcst then
		managers.gui_data:layout_fullscreen_16_9_workspace(self._tcst)
	end
end
function MenuComponentManager:_axis_move(o, axis_name, axis_vector, controller)
	if axis_name == Idstring("left") then
		mvector3.set(self._left_axis_vector, axis_vector)
	elseif axis_name == Idstring("right") then
		mvector3.set(self._right_axis_vector, axis_vector)
	end
end
function MenuComponentManager:set_active_components(components, node)
	if not alive(self._ws) or not alive(self._fullscreen_ws) then
		return
	end
	local to_close = {}
	for component, _ in pairs(self._active_components) do
		to_close[component] = true
	end
	for _, component in ipairs(components) do
		if self._active_components[component] then
			to_close[component] = nil
			self._active_components[component].create(node)
		end
	end
	for component, _ in pairs(to_close) do
		self._active_components[component]:close()
	end
	if not managers.menu:is_pc_controller() then
		self:_setup_controller_input()
	end
end
function MenuComponentManager:make_color_text(text_object, color)
	local text = text_object:text()
	local text_dissected = utf8.characters(text)
	local idsp = Idstring("#")
	local start_ci = {}
	local end_ci = {}
	local first_ci = true
	for i, c in ipairs(text_dissected) do
		if Idstring(c) == idsp then
			local next_c = text_dissected[i + 1]
			if next_c and Idstring(next_c) == idsp then
				if first_ci then
					table.insert(start_ci, i)
				else
					table.insert(end_ci, i)
				end
				first_ci = not first_ci
			end
		end
	end
	if #start_ci ~= #end_ci then
	else
		for i = 1, #start_ci do
			start_ci[i] = start_ci[i] - ((i - 1) * 4 + 1)
			end_ci[i] = end_ci[i] - (i * 4 - 1)
		end
	end
	text = string.gsub(text, "##", "")
	text_object:set_text(text)
	text_object:clear_range_color(1, utf8.len(text))
	if #start_ci ~= #end_ci then
		Application:error("CrimeNetGui:make_color_text: Not even amount of ##'s in text", #start_ci, #end_ci)
	else
		for i = 1, #start_ci do
			text_object:set_range_color(start_ci[i], end_ci[i], color or tweak_data.screen_colors.resource)
		end
	end
end
function MenuComponentManager:on_job_updated()
	if self._contract_gui then
		self._contract_gui:refresh()
	end
end
function MenuComponentManager:update(t, dt)
	if self._set_crimenet_enabled == true then
		if self._crimenet_gui then
			self._crimenet_gui:enable_crimenet()
		end
		self._set_crimenet_enabled = nil
	elseif self._set_crimenet_enabled == false then
		if self._crimenet_gui then
			self._crimenet_gui:disable_crimenet()
		end
		self._set_crimenet_enabled = nil
	end
	if self._mission_briefing_update_tab_wanted then
		self:update_mission_briefing_tab_positions()
	end
	self:_update_newsfeed_gui(t, dt)
	self:_update_game_installing_gui(t, dt)
	if t > self._refresh_friends_t then
		self:_update_friends_gui()
		self._refresh_friends_t = t + self._REFRESH_FRIENDS_TIME
	end
	if self._lobby_profile_gui then
		self._lobby_profile_gui:update(t, dt)
	end
	if self._profile_gui then
		self._profile_gui:update(t, dt)
	end
	if self._view_character_profile_gui then
		self._view_character_profile_gui:update(t, dt)
	end
	if self._contract_gui then
		self._contract_gui:update(t, dt)
	end
	if self._menuscene_info_gui then
		self._menuscene_info_gui:update(t, dt)
	end
	if self._skilltree_gui then
		self._skilltree_gui:update(t, dt)
	end
	if self._crimenet_contract_gui then
		self._crimenet_contract_gui:update(t, dt)
	end
	if self._lootdrop_gui then
		self._lootdrop_gui:update(t, dt)
	end
	if self._lootdrop_casino_gui then
		self._lootdrop_casino_gui:update(t, dt)
	end
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:update(t, dt)
	end
	if self._mission_briefing_gui then
		self._mission_briefing_gui:update(t, dt)
	end
	if self._ingame_manual_gui then
		self._ingame_manual_gui:update(t, dt)
	end
	if self._preplanning_map then
		self._preplanning_map:update(t, dt)
	end
	if self._blackmarket_gui then
		self._blackmarket_gui:update(t, dt)
	end
	if self._main_menu_gui then
		self._main_menu_gui:update(t, dt)
	end
end
function MenuComponentManager:get_left_controller_axis()
	if managers.menu:is_pc_controller() or not self._left_axis_vector then
		return 0, 0
	end
	local x = mvector3.x(self._left_axis_vector)
	local y = mvector3.y(self._left_axis_vector)
	return x, y
end
function MenuComponentManager:get_right_controller_axis()
	if managers.menu:is_pc_controller() or not self._right_axis_vector then
		return 0, 0
	end
	local x = mvector3.x(self._right_axis_vector)
	local y = mvector3.y(self._right_axis_vector)
	return x, y
end
function MenuComponentManager:accept_input(accept)
	if not self._weapon_text_box then
		return
	end
	if not accept then
		self._weapon_text_box:release_scroll_bar()
	end
end
function MenuComponentManager:input_focus()
	if managers.blackmarket and managers.blackmarket:is_preloading_weapons() then
		return true
	end
	if managers.system_menu and managers.system_menu:is_active() and not managers.system_menu:is_closing() then
		return true
	end
	if self._game_chat_gui then
		local input_focus = self._game_chat_gui:input_focus()
		if input_focus == true then
			return true
		elseif input_focus == 1 then
			return 1
		end
	end
	if self._skilltree_gui then
		local input_focus = self._skilltree_gui:input_focus()
		if input_focus then
			return input_focus
		end
	end
	if self._infamytree_gui and self._infamytree_gui:input_focus() then
		return 1
	end
	if self:is_preplanning_enabled() then
		return self._preplanning_map:input_focus()
	end
	if self._blackmarket_gui then
		return self._blackmarket_gui:input_focus()
	end
	if self._mission_briefing_gui then
		return self._mission_briefing_gui:input_focus()
	end
	if self._stage_endscreen_gui then
		return self._stage_endscreen_gui:input_focus()
	end
	if self._lootdrop_casino_gui then
		return self._lootdrop_casino_gui:input_focus()
	end
	if self._lootdrop_gui then
		return self._lootdrop_gui:input_focus()
	end
	if self._crimenet_gui then
		return self._crimenet_gui:input_focus()
	end
	if self._ingame_manual_gui then
		return self._ingame_manual_gui:input_focus()
	end
	if self._player_inventory_gui then
		return self._player_inventory_gui:input_focus()
	end
	if self._main_menu_gui then
		return self._main_menu_gui:input_focus()
	end
end
function MenuComponentManager:scroll_up()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if not self._weapon_text_box then
		return
	end
	self._weapon_text_box:scroll_up()
	if self._mission_briefing_gui and self._mission_briefing_gui:scroll_up() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:scroll_up() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:scroll_up() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:scroll_up() then
		return true
	end
end
function MenuComponentManager:scroll_down()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if not self._weapon_text_box then
		return
	end
	self._weapon_text_box:scroll_down()
	if self._mission_briefing_gui and self._mission_briefing_gui:scroll_down() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:scroll_down() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:scroll_down() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:scroll_down() then
		return true
	end
end
function MenuComponentManager:move_up()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:move_up() then
		return true
	end
	if self._infamytree_gui and self._infamytree_gui:move_up() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:move_up() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:move_up() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:move_up() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:move_up() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:move_up() then
		return true
	end
	if self._player_inventory_gui and self._player_inventory_gui:move_up() then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:move_up() then
		return true
	end
end
function MenuComponentManager:move_down()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:move_down() then
		return true
	end
	if self._infamytree_gui and self._infamytree_gui:move_down() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:move_down() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:move_down() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:move_down() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:move_down() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:move_down() then
		return true
	end
	if self._player_inventory_gui and self._player_inventory_gui:move_down() then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:move_down() then
		return true
	end
end
function MenuComponentManager:move_left()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:move_left() then
		return true
	end
	if self._infamytree_gui and self._infamytree_gui:move_left() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:move_left() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:move_left() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:move_left() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:move_left() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:move_left() then
		return true
	end
	if self._player_inventory_gui and self._player_inventory_gui:move_left() then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:move_left() then
		return true
	end
end
function MenuComponentManager:move_right()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:move_right() then
		return true
	end
	if self._infamytree_gui and self._infamytree_gui:move_right() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:move_right() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:move_right() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:move_right() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:move_right() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:move_right() then
		return true
	end
	if self._player_inventory_gui and self._player_inventory_gui:move_right() then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:move_right() then
		return true
	end
end
function MenuComponentManager:next_page()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:next_page(true) then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:next_page() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:next_page() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:next_page() then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:next_page() then
		return true
	end
	if self:is_preplanning_enabled() and self._preplanning_map:next_page() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:next_page() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:next_page() then
		return true
	end
	if self._ingame_manual_gui and self._ingame_manual_gui:next_page() then
		return true
	end
	if self._player_inventory_gui and self._player_inventory_gui:next_page() then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:next_page() then
		return true
	end
end
function MenuComponentManager:previous_page()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:previous_page(true) then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:previous_page() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:previous_page() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:previous_page() then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:previous_page() then
		return true
	end
	if self:is_preplanning_enabled() and self._preplanning_map:previous_page() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:previous_page() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:previous_page() then
		return true
	end
	if self._ingame_manual_gui and self._ingame_manual_gui:previous_page() then
		return true
	end
	if self._player_inventory_gui and self._player_inventory_gui:previous_page() then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:previous_page() then
		return true
	end
end
function MenuComponentManager:confirm_pressed()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:confirm_pressed() then
		return true
	end
	if self._infamytree_gui and self._infamytree_gui:confirm_pressed() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:confirm_pressed() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:confirm_pressed() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:confirm_pressed() then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:confirm_pressed() then
		return true
	end
	if self:is_preplanning_enabled() and self._preplanning_map:confirm_pressed() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:confirm_pressed() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:confirm_pressed() then
		return true
	end
	if self._player_inventory_gui and self._player_inventory_gui:confirm_pressed() then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:confirm_pressed() then
		return true
	end
	if Application:production_build() and self._debug_font_gui then
		self._debug_font_gui:toggle()
	end
end
function MenuComponentManager:back_pressed()
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:back_pressed() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:back_pressed() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:back_pressed() then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:back_pressed() then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:back_pressed() then
		return true
	end
end
function MenuComponentManager:special_btn_pressed(...)
	if self._game_chat_gui and self._game_chat_gui:input_focus() == true then
		return true
	end
	if self._game_chat_gui and self._game_chat_gui:special_btn_pressed(...) then
		return true
	end
	if self._preplanning_map and self._preplanning_map:special_btn_pressed(...) then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:special_btn_pressed(...) then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:special_btn_pressed(...) then
		return true
	end
	if self._crimenet_contract_gui and self._crimenet_contract_gui:special_btn_pressed(...) then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:special_btn_pressed(...) then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:special_btn_pressed(...) then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:special_btn_pressed(...) then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:special_btn_pressed(...) then
		return true
	end
	if self._crimenet_casino_gui and self._crimenet_casino_gui:special_btn_pressed(...) then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:special_btn_pressed(...) then
		return true
	end
	if self._player_inventory_gui and self._player_inventory_gui:special_btn_pressed(...) then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:special_btn_pressed(...) then
		return true
	end
end
function MenuComponentManager:mouse_pressed(o, button, x, y)
	if self._game_chat_gui and self._game_chat_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._infamytree_gui and self._infamytree_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._newsfeed_gui and self._newsfeed_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._profile_gui then
		if self._profile_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._profile_gui:check_minimize(x, y) then
				local minimized_data = {
					text = "PROFILE",
					help_text = "MAXIMIZE PROFILE WINDOW"
				}
				self._profile_gui:set_minimized(true, minimized_data)
				return true
			end
			if self._profile_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._profile_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._profile_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._contract_gui then
		if self._contract_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._contract_gui:check_minimize(x, y) then
				local minimized_data = {
					text = "CONTRACT",
					help_text = "MAXIMIZE CONTRACT WINDOW"
				}
				self._contract_gui:set_minimized(true, minimized_data)
				return true
			end
			if self._contract_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._contract_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._contract_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._server_info_gui then
		if self._server_info_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._server_info_gui:check_minimize(x, y) then
				local minimized_data = {
					text = "SERVER INFO",
					help_text = "MAXIMIZE SERVER INFO WINDOW"
				}
				self._server_info_gui:set_minimized(true, minimized_data)
				return true
			end
			if self._server_info_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._server_info_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._server_info_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._lobby_profile_gui then
		if self._lobby_profile_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._lobby_profile_gui:check_minimize(x, y) then
				return true
			end
			if self._lobby_profile_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._lobby_profile_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._lobby_profile_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._lootdrop_casino_gui and self._lootdrop_casino_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._crimenet_casino_gui and self._crimenet_casino_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._view_character_profile_gui then
		if self._view_character_profile_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._view_character_profile_gui:check_minimize(x, y) then
				return true
			end
			if self._view_character_profile_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._view_character_profile_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._view_character_profile_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._test_profile1 then
		if self._test_profile1:check_grab_scroll_bar(x, y) then
			return true
		end
		if self._test_profile2:check_grab_scroll_bar(x, y) then
			return true
		end
		if self._test_profile3:check_grab_scroll_bar(x, y) then
			return true
		end
		if self._test_profile4:check_grab_scroll_bar(x, y) then
			return true
		end
	end
	if self._crimenet_contract_gui and self._crimenet_contract_gui:mouse_pressed(o, button, x, y) then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:mouse_pressed(o, button, x, y) then
		return true
	end
	if self:is_preplanning_enabled() and self._preplanning_map:mouse_pressed(button, x, y) then
		return true
	end
	if self._minimized_list and button == Idstring("0") then
		for i, data in ipairs(self._minimized_list) do
			if data.panel:inside(x, y) then
				data.callback(data)
			else
			end
		end
	end
	if self._friends_book then
		if self._friends_book:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._friends_book:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._friends_book:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._friends_book:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._debug_strings_book then
		if self._debug_strings_book:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._debug_strings_book:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._debug_strings_book:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._debug_strings_book:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._weapon_text_box then
		if button == Idstring("0") then
			if self._weapon_text_box:check_close(x, y) then
				self:close_weapon_box()
				return true
			end
			if self._weapon_text_box:check_minimize(x, y) then
				self._weapon_text_box:set_visible(false)
				self._weapon_text_minimized_id = self:add_minimized({
					callback = callback(self, self, "_maximize_weapon_box"),
					text = "WEAPON"
				})
				return true
			end
			if self._weapon_text_box:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._weapon_text_box:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._weapon_text_box:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._player_inventory_gui and self._player_inventory_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._main_menu_gui and self._main_menu_gui:mouse_pressed(button, x, y) then
		return true
	end
end
function MenuComponentManager:mouse_clicked(o, button, x, y)
	if self._blackmarket_gui then
		return self._blackmarket_gui:mouse_clicked(o, button, x, y)
	end
	if self._skilltree_gui then
		return self._skilltree_gui:mouse_clicked(o, button, x, y)
	end
end
function MenuComponentManager:mouse_double_click(o, button, x, y)
	if self._blackmarket_gui then
		return self._blackmarket_gui:mouse_double_click(o, button, x, y)
	end
	if self._skilltree_gui then
		return self._skilltree_gui:mouse_double_click(o, button, x, y)
	end
end
function MenuComponentManager:mouse_released(o, button, x, y)
	if self._game_chat_gui and self._game_chat_gui:mouse_released(o, button, x, y) then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:mouse_released(o, button, x, y) then
		return true
	end
	if self:is_preplanning_enabled() and self._preplanning_map:mouse_released(button, x, y) then
		return true
	end
	if self._blackmarket_gui then
		return self._blackmarket_gui:mouse_released(button, x, y)
	end
	if self._friends_book and self._friends_book:release_scroll_bar() then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:mouse_released(button, x, y) then
		return true
	end
	if self._debug_strings_book and self._debug_strings_book:release_scroll_bar() then
		return true
	end
	if self._chat_book then
		local used, pointer = self._chat_book:release_scroll_bar()
		if used then
			return true, pointer
		end
	end
	if self._profile_gui and self._profile_gui:release_scroll_bar() then
		return true
	end
	if self._contract_gui and self._contract_gui:release_scroll_bar() then
		return true
	end
	if self._server_info_gui and self._server_info_gui:release_scroll_bar() then
		return true
	end
	if self._lobby_profile_gui and self._lobby_profile_gui:release_scroll_bar() then
		return true
	end
	if self._view_character_profile_gui and self._view_character_profile_gui:release_scroll_bar() then
		return true
	end
	if self._test_profile1 then
		if self._test_profile1:release_scroll_bar() then
			return true
		end
		if self._test_profile2:release_scroll_bar() then
			return true
		end
		if self._test_profile3:release_scroll_bar() then
			return true
		end
		if self._test_profile4:release_scroll_bar() then
			return true
		end
	end
	if self._weapon_text_box and self._weapon_text_box:release_scroll_bar() then
		return true
	end
	return false
end
function MenuComponentManager:mouse_moved(o, x, y)
	local wanted_pointer = "arrow"
	if self._game_chat_gui then
		local used, pointer = self._game_chat_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._skilltree_gui then
		local used, pointer = self._skilltree_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._infamytree_gui then
		local used, pointer = self._infamytree_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._blackmarket_gui then
		local used, pointer = self._blackmarket_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._crimenet_contract_gui then
		local used, pointer = self._crimenet_contract_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._crimenet_gui then
		local used, pointer = self._crimenet_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self:is_preplanning_enabled() then
		local used, pointer = self._preplanning_map:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._friends_book then
		local used, pointer = self._friends_book:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._friends_book:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._debug_strings_book then
		local used, pointer = self._debug_strings_book:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._debug_strings_book:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._profile_gui then
		local used, pointer = self._profile_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._profile_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._contract_gui then
		local used, pointer = self._contract_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._contract_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._server_info_gui then
		local used, pointer = self._server_info_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._server_info_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._backdrop_gui then
		local used, pointer = self._backdrop_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._mission_briefing_gui then
		local used, pointer = self._mission_briefing_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._stage_endscreen_gui then
		local used, pointer = self._stage_endscreen_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._lootdrop_gui then
		local used, pointer = self._lootdrop_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._lootdrop_casino_gui then
		local used, pointer = self._lootdrop_casino_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._crimenet_casino_gui then
		local used, pointer = self._crimenet_casino_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._lobby_profile_gui then
		local used, pointer = self._lobby_profile_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._lobby_profile_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._view_character_profile_gui then
		local used, pointer = self._view_character_profile_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._view_character_profile_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._test_profile1 then
		local used, pointer = self._test_profile1:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._test_profile2:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._test_profile3:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._test_profile4:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
	end
	if self._newsfeed_gui then
		local used, pointer = self._newsfeed_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._minimized_list then
		for i, data in ipairs(self._minimized_list) do
			if data.mouse_over ~= data.panel:inside(x, y) then
				data.mouse_over = data.panel:inside(x, y)
				data.text:set_font(data.mouse_over and tweak_data.menu.default_font_no_outline_id or Idstring(tweak_data.menu.default_font))
				data.text:set_color(data.mouse_over and Color.black or Color.white)
				data.selected:set_visible(data.mouse_over)
				data.help_text:set_visible(data.mouse_over)
			end
			data.help_text:set_position(x + 12, y + 12)
		end
	end
	if self._weapon_text_box and self._weapon_text_box:moved_scroll_bar(x, y) then
		return true, wanted_pointer
	end
	if self._player_inventory_gui then
		local used, pointer = self._player_inventory_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._main_menu_gui then
		local used, pointer = self._main_menu_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	return false, wanted_pointer
end
function MenuComponentManager:peer_outfit_updated(peer_id)
	if self._contract_gui then
		self._contract_gui:refresh()
	end
end
function MenuComponentManager:on_peer_removed(peer, reason)
	if self._lootdrop_gui then
		self._lootdrop_gui:on_peer_removed(peer, reason)
	end
	if self._lootdrop_casino_gui then
		self._lootdrop_casino_gui:on_peer_removed(peer, reason)
	end
	if self._contract_gui then
		self._contract_gui:refresh()
	end
end
function MenuComponentManager:_create_crimenet_contract_gui(node)
	self:close_crimenet_contract_gui()
	self._crimenet_contract_gui = CrimeNetContractGui:new(self._ws, self._fullscreen_ws, node)
	self:disable_crimenet()
end
function MenuComponentManager:close_crimenet_contract_gui(...)
	if self._crimenet_contract_gui then
		self._crimenet_contract_gui:close()
		self._crimenet_contract_gui = nil
		self:enable_crimenet()
	end
end
function MenuComponentManager:set_crimenet_contract_difficulty_id(difficulty_id)
	if self._crimenet_contract_gui then
		self._crimenet_contract_gui:set_difficulty_id(difficulty_id)
	end
end
function MenuComponentManager:_create_crimenet_filters_gui(node)
	self:close_crimenet_filters_gui()
	self._crimenet_filters_gui = CrimeNetFiltersGui:new(self._ws, self._fullscreen_ws, node)
	self:disable_crimenet()
end
function MenuComponentManager:close_crimenet_filters_gui(...)
	if self._crimenet_filters_gui then
		self._crimenet_filters_gui:close()
		self._crimenet_filters_gui = nil
		self:enable_crimenet()
	end
end
function MenuComponentManager:_create_crimenet_casino_gui(node)
	self:close_crimenet_casino_gui()
	self._crimenet_casino_gui = CrimeNetCasinoGui:new(self._ws, self._fullscreen_ws, node)
	self:disable_crimenet()
end
function MenuComponentManager:close_crimenet_casino_gui(...)
	if self._crimenet_casino_gui then
		self._crimenet_casino_gui:close()
		self._crimenet_casino_gui = nil
		self:enable_crimenet()
	end
end
function MenuComponentManager:can_afford()
	if self._crimenet_casino_gui then
		self._crimenet_casino_gui:can_afford()
	end
end
function MenuComponentManager:_create_crimenet_gui(...)
	if self._crimenet_gui then
		return
	end
	self._crimenet_gui = CrimeNetGui:new(self._ws, self._fullscreen_ws, ...)
end
function MenuComponentManager:start_crimenet_job()
	self:enable_crimenet()
	if self._crimenet_gui then
		self._crimenet_gui:start_job()
	end
end
function MenuComponentManager:enable_crimenet()
	self._set_crimenet_enabled = self._set_crimenet_enabled == nil and true
end
function MenuComponentManager:disable_crimenet()
	self._set_crimenet_enabled = self._set_crimenet_enabled == nil and false
end
function MenuComponentManager:update_crimenet_gui(t, dt)
	if self._crimenet_gui then
		self._crimenet_gui:update(t, dt)
	end
end
function MenuComponentManager:update_crimenet_job(...)
	self._crimenet_gui:update_job(...)
end
function MenuComponentManager:feed_crimenet_job_timer(...)
	self._crimenet_gui:feed_timer(...)
end
function MenuComponentManager:update_crimenet_server_job(...)
	if self._crimenet_gui then
		self._crimenet_gui:update_server_job(...)
	end
end
function MenuComponentManager:feed_crimenet_server_timer(...)
	self._crimenet_gui:feed_server_timer(...)
end
function MenuComponentManager:criment_goto_lobby(...)
	if self._crimenet_gui then
		self._crimenet_gui:goto_lobby(...)
	end
end
function MenuComponentManager:set_crimenet_players_online(amount)
	if self._crimenet_gui then
		self._crimenet_gui:set_players_online(amount)
	end
end
function MenuComponentManager:add_crimenet_gui_preset_job(id)
	if self._crimenet_gui then
		self._crimenet_gui:add_preset_job(id)
	end
end
function MenuComponentManager:add_crimenet_server_job(...)
	if self._crimenet_gui then
		self._crimenet_gui:add_server_job(...)
	end
end
function MenuComponentManager:remove_crimenet_gui_job(id)
	if self._crimenet_gui then
		self._crimenet_gui:remove_job(id)
	end
end
function MenuComponentManager:set_crimenet_gui_getting_hacked(hacked)
	if self._crimenet_gui then
		self._crimenet_gui:set_getting_hacked(hacked)
	end
end
function MenuComponentManager:has_crimenet_gui()
	return not not self._crimenet_gui
end
function MenuComponentManager:has_blackmarket_gui()
	return not not self._blackmarket_gui
end
function MenuComponentManager:close_crimenet_gui()
	if self._crimenet_gui then
		self._crimenet_gui:close()
		self._crimenet_gui = nil
	end
end
function MenuComponentManager:create_weapon_box(w_id, params)
	local title = managers.localization:text(tweak_data.weapon[w_id].name_id)
	local text = managers.localization:text(tweak_data.weapon[w_id].description_id)
	local stats_list = {
		{
			type = "bar",
			text = "DAMAGE: 32(+6)",
			current = 32,
			total = 50
		},
		{type = "empty", h = 2},
		{
			type = "bar",
			text = "RELOAD SPEED: 4(-2)",
			current = 4,
			total = 20
		},
		{type = "empty", h = 2},
		{
			type = "bar",
			text = "RECOIL: 8 (+0)",
			current = 8,
			total = 10
		},
		{type = "empty", h = 2},
		{
			type = "condition",
			value = params.condition or 19
		},
		{type = "empty", h = 10},
		{
			type = "mods",
			list = {
				"SHORTENED BARREL",
				"SPEEDHOLSTER SLING",
				"ONMILTE TRITIUM SIGHTS"
			}
		},
		{type = "empty", h = 10}
	}
	if self._weapon_text_box then
		self._weapon_text_box:recreate_text_box(self._ws, title, text, {stats_list = stats_list}, {
			type = "weapon_stats",
			no_close_legend = true,
			use_minimize_legend = true
		})
	else
		self._weapon_text_box = TextBoxGui:new(self._ws, title, text, {stats_list = stats_list}, {
			type = "weapon_stats",
			no_close_legend = true,
			use_minimize_legend = true
		})
	end
end
function MenuComponentManager:close_weapon_box()
	if self._weapon_text_box then
		self._weapon_text_box:close()
	end
	self._weapon_text_box = nil
	if self._weapon_text_minimized_id then
		self:remove_minimized(self._weapon_text_minimized_id)
		self._weapon_text_minimized_id = nil
	end
end
function MenuComponentManager:_create_chat_gui()
	if SystemInfo:platform() == Idstring("WIN32") and MenuCallbackHandler:is_multiplayer() and managers.network:session() then
		self._preplanning_chat_gui_active = false
		self._lobby_chat_gui_active = false
		self._crimenet_chat_gui_active = false
		if self._game_chat_gui then
			self:show_game_chat_gui()
		else
			self:add_game_chat()
		end
		self._game_chat_gui:set_params(self._saved_game_chat_params or "default")
		self._saved_game_chat_params = nil
	end
end
function MenuComponentManager:_create_lobby_chat_gui()
	if SystemInfo:platform() == Idstring("WIN32") and MenuCallbackHandler:is_multiplayer() and managers.network:session() then
		self._preplanning_chat_gui_active = false
		self._lobby_chat_gui_active = true
		self._crimenet_chat_gui_active = false
		if self._game_chat_gui then
			self:show_game_chat_gui()
		else
			self:add_game_chat()
		end
		self._game_chat_gui:set_params(self._saved_game_chat_params or "lobby")
		self._saved_game_chat_params = nil
	end
end
function MenuComponentManager:_create_crimenet_chats_gui()
	if SystemInfo:platform() == Idstring("WIN32") and MenuCallbackHandler:is_multiplayer() and managers.network:session() then
		self._preplanning_chat_gui_active = false
		self._crimenet_chat_gui_active = true
		self._lobby_chat_gui_active = false
		if self._game_chat_gui then
			self:show_game_chat_gui()
		else
			self:add_game_chat()
		end
		self._game_chat_gui:set_params(self._saved_game_chat_params or "crimenet")
		self._saved_game_chat_params = nil
	end
end
function MenuComponentManager:_create_preplanning_chats_gui()
	if SystemInfo:platform() == Idstring("WIN32") and MenuCallbackHandler:is_multiplayer() and managers.network:session() then
		self._preplanning_chat_gui_active = true
		self._crimenet_chat_gui_active = false
		self._lobby_chat_gui_active = false
		if self._game_chat_gui then
			self:show_game_chat_gui()
		else
			self:add_game_chat()
		end
		self._game_chat_gui:set_params(self._saved_game_chat_params or "preplanning")
		self._saved_game_chat_params = nil
	end
end
function MenuComponentManager:create_chat_gui()
	self:close_chat_gui()
	local config = {
		w = 540,
		h = 220,
		x = 290,
		no_close_legend = true,
		use_minimize_legend = true,
		header_type = "fit"
	}
	self._chat_book = BookBoxGui:new(self._ws, nil, config)
	self._chat_book:set_layer(8)
	local global_gui = ChatGui:new(self._ws, "Global", "")
	global_gui:set_channel_id(ChatManager.GLOBAL)
	global_gui:set_layer(self._chat_book:layer())
	self._chat_book:add_page("Global", global_gui, false)
	self._chat_book:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end
function MenuComponentManager:add_game_chat()
	if SystemInfo:platform() == Idstring("WIN32") then
		self._game_chat_gui = ChatGui:new(self._ws)
		if self._game_chat_params then
			self._game_chat_gui:set_params(self._game_chat_params)
			self._game_chat_params = nil
		end
	end
end
function MenuComponentManager:set_max_lines_game_chat(max_lines)
	if self._game_chat_gui then
		self._game_chat_gui:set_max_lines(max_lines)
	else
		self._game_chat_params = self._game_chat_params or {}
		self._game_chat_params.max_lines = max_lines
	end
end
function MenuComponentManager:pre_set_game_chat_leftbottom(from_left, from_bottom)
	if self._game_chat_gui then
		self._game_chat_gui:set_leftbottom(from_left, from_bottom)
	else
		self._game_chat_params = self._game_chat_params or {}
		self._game_chat_params.left = from_left
		self._game_chat_params.bottom = from_bottom
	end
end
function MenuComponentManager:remove_game_chat()
	if not self._chat_book then
		return
	end
	self._chat_book:remove_page("Game")
end
function MenuComponentManager:hide_lobby_chat_gui()
	if self._game_chat_gui and self._lobby_chat_gui_active then
		self._game_chat_gui:hide()
	end
end
function MenuComponentManager:hide_crimenet_chat_gui()
	if self._game_chat_gui and self._crimenet_chat_gui_active then
		self._game_chat_gui:hide()
	end
end
function MenuComponentManager:hide_preplanning_chat_gui()
	if self._game_chat_gui and self._preplanning_chat_gui_active then
		self._game_chat_gui:hide()
	end
end
function MenuComponentManager:hide_game_chat_gui()
	if self._game_chat_gui then
		self._game_chat_gui:hide()
	end
end
function MenuComponentManager:show_game_chat_gui()
	if self._game_chat_gui then
		self._game_chat_gui:show()
	end
end
function MenuComponentManager:input_focut_game_chat_gui()
	return self._game_chat_gui and self._game_chat_gui:input_focus() == true
end
function MenuComponentManager:_disable_chat_gui()
	if self._game_chat_gui and not self._lobby_chat_gui_active and not self._crimenet_chat_gui_active and not self._preplanning_chat_gui_active then
		self._game_chat_gui:set_enabled(false)
	end
end
function MenuComponentManager:close_chat_gui()
	if self._game_chat_gui then
		self._game_chat_gui:close()
		self._game_chat_gui = nil
	end
	if self._chat_book_minimized_id then
		self:remove_minimized(self._chat_book_minimized_id)
		self._chat_book_minimized_id = nil
	end
	self._game_chat_bottom = nil
	self._lobby_chat_gui_active = nil
	self._crimenet_chat_gui_active = nil
	self._preplanning_chat_gui_active = nil
end
function MenuComponentManager:set_crimenet_chat_gui(state)
	if self._game_chat_gui then
		self._game_chat_gui:set_crimenet_chat(state)
	end
end
function MenuComponentManager:_create_friends_gui()
	if SystemInfo:platform() == Idstring("WIN32") then
		if self._friends_book then
			self._friends_book:set_enabled(true)
			return
		end
		self:create_friends_gui()
	end
end
function MenuComponentManager:create_friends_gui()
	self:close_friends_gui()
	self._friends_book = BookBoxGui:new(self._ws, nil, {no_close_legend = true, no_scroll_legend = true})
	self._friends_gui = FriendsBoxGui:new(self._ws, "Friends", "")
	self._friends2_gui = FriendsBoxGui:new(self._ws, "Test", "", nil, nil, "recent")
	self._friends3_gui = FriendsBoxGui:new(self._ws, "Test", "")
	self._friends_book:add_page("Friends", self._friends_gui, true)
	self._friends_book:add_page("Recent Players", self._friends2_gui)
	self._friends_book:add_page("Clan", self._friends3_gui)
	self._friends_book:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end
function MenuComponentManager:_update_friends_gui()
	if self._friends_gui then
		self._friends_gui:update_friends()
	end
end
function MenuComponentManager:_disable_friends_gui()
	if self._friends_book then
		self._friends_book:set_enabled(false)
	end
end
function MenuComponentManager:close_friends_gui()
	if self._friends_gui then
		self._friends_gui = nil
	end
	if self._friends_book then
		self._friends_book:close()
		self._friends_book = nil
	end
end
function MenuComponentManager:_create_contract_gui()
	if self._contract_gui then
		self._contract_gui:set_enabled(true)
		return
	end
	self:create_contract_gui()
end
function MenuComponentManager:create_contract_gui()
	self:close_contract_gui()
	self._contract_gui = ContractBoxGui:new(self._ws, self._fullscreen_ws)
	local peers_state = managers.menu:get_all_peers_state() or {}
	for i = 1, 4 do
		self._contract_gui:update_character_menu_state(i, peers_state[i])
	end
end
function MenuComponentManager:update_contract_character(peer_id)
	if self._contract_gui then
		self._contract_gui:update_character(peer_id)
	end
end
function MenuComponentManager:update_contract_character_menu_state(peer_id, state)
	if self._contract_gui then
		self._contract_gui:update_character_menu_state(peer_id, state)
		self._contract_gui:update_bg_state(peer_id, state)
	end
end
function MenuComponentManager:show_contract_character(state)
	if self._contract_gui then
		for i = 1, 4 do
			self._contract_gui:set_character_panel_alpha(i, state and 1 or 0.4)
		end
	end
end
function MenuComponentManager:_disable_contract_gui()
	if self._contract_gui then
		self._contract_gui:set_enabled(false)
	end
end
function MenuComponentManager:close_contract_gui()
	if self._contract_gui then
		self._contract_gui:close()
		self._contract_gui = nil
	end
end
function MenuComponentManager:_create_skilltree_gui(node)
	self:create_skilltree_gui(node)
end
function MenuComponentManager:create_skilltree_gui(node)
	self:close_skilltree_gui()
	self._skilltree_gui = SkillTreeGui:new(self._ws, self._fullscreen_ws, node)
	self:enable_skilltree_gui()
end
function MenuComponentManager:close_skilltree_gui()
	if self._skilltree_gui then
		self._skilltree_gui:close()
		self._skilltree_gui = nil
	end
end
function MenuComponentManager:enable_skilltree_gui()
	if self._skilltree_gui then
		self._skilltree_gui:enable()
	end
end
function MenuComponentManager:disable_skilltree_gui()
	if self._skilltree_gui then
		self._skilltree_gui:disable()
	end
end
function MenuComponentManager:on_tier_unlocked(...)
	if self._skilltree_gui then
		self._skilltree_gui:on_tier_unlocked(...)
	end
end
function MenuComponentManager:on_skill_unlocked(...)
	if self._skilltree_gui then
		self._skilltree_gui:on_skill_unlocked(...)
	end
end
function MenuComponentManager:on_points_spent(...)
	if self._skilltree_gui then
		self._skilltree_gui:on_points_spent(...)
	end
end
function MenuComponentManager:on_skilltree_reset(...)
	if self._skilltree_gui then
		self._skilltree_gui:on_skilltree_reset(...)
	end
end
function MenuComponentManager:_create_infamytree_gui()
	self:create_infamytree_gui()
end
function MenuComponentManager:create_infamytree_gui(node)
	self:close_infamytree_gui()
	self._infamytree_gui = InfamyTreeGui:new(self._ws, self._fullscreen_ws, node)
end
function MenuComponentManager:close_infamytree_gui()
	if self._infamytree_gui then
		self._infamytree_gui:close()
		self._infamytree_gui = nil
	end
end
function MenuComponentManager:_create_inventory_list_gui(node)
	self:create_inventory_list_gui(node)
end
function MenuComponentManager:create_inventory_list_gui(node)
	self:close_inventory_list_gui()
	self._inventory_list_gui = InventoryList:new(self._ws, self._fullscreen_ws, node)
end
function MenuComponentManager:close_inventory_list_gui()
	if self._inventory_list_gui then
		self._inventory_list_gui:close()
		self._inventory_list_gui = nil
	end
end
function MenuComponentManager:_create_blackmarket_gui(node)
	self:create_blackmarket_gui(node)
end
function MenuComponentManager:create_blackmarket_gui(node)
	if not node then
		return
	end
	if node:parameters().set_blackmarket_enabled == nil then
		self:close_blackmarket_gui()
	end
	self._blackmarket_gui = self._blackmarket_gui or BlackMarketGui:new(self._ws, self._fullscreen_ws, node)
	if node:parameters().set_blackmarket_enabled ~= nil then
		self._blackmarket_gui:set_enabled(node:parameters().set_blackmarket_enabled)
	end
end
function MenuComponentManager:set_blackmarket_tab_positions()
	if self._blackmarket_gui then
		self._blackmarket_gui:set_tab_positions()
	end
end
function MenuComponentManager:reload_blackmarket_gui()
	if self._blackmarket_gui and not self._blackmarket_gui:in_setup() then
		self._blackmarket_gui:reload()
	end
end
function MenuComponentManager:close_blackmarket_gui()
	if self._blackmarket_gui then
		self._blackmarket_gui:close()
		self._blackmarket_gui = nil
	end
end
function MenuComponentManager:set_blackmarket_enabled(enabled)
	if self._blackmarket_gui then
		self._blackmarket_gui:set_enabled(enabled)
	end
end
function MenuComponentManager:set_blackmarket_disable_fetching(disabled)
	self._blackmarket_disable_fetching = disabled
end
function MenuComponentManager:blackmarket_fetching_disable()
	return self._blackmarket_disable_fetching
end
function MenuComponentManager:hide_blackmarket_gui()
	if self._blackmarket_gui then
		self._blackmarket_gui:hide()
	end
end
function MenuComponentManager:show_blackmarket_gui()
	if self._blackmarket_gui then
		self._blackmarket_gui:show()
	end
end
function MenuComponentManager:get_bonus_stats_blackmarket_gui(cosmetic_id, weapon_id, bonus)
	if self._blackmarket_gui then
		return self._blackmarket_gui:get_bonus_stats(cosmetic_id, weapon_id, bonus)
	end
end
function MenuComponentManager:_create_server_info_gui()
	if self._server_info_gui then
		self:close_server_info_gui()
	end
	self:create_server_info_gui()
end
function MenuComponentManager:create_server_info_gui()
	self:close_server_info_gui()
	self._server_info_gui = ServerStatusBoxGui:new(self._ws)
	self._server_info_gui:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end
function MenuComponentManager:_disable_server_info_gui()
	if self._server_info_gui then
		self._server_info_gui:set_enabled(false)
	end
end
function MenuComponentManager:close_server_info_gui()
	if self._server_info_gui then
		self._server_info_gui:close()
		self._server_info_gui = nil
	end
end
function MenuComponentManager:set_server_info_state(state)
	if self._server_info_gui then
		self._server_info_gui:set_server_info_state(state)
	end
end
function MenuComponentManager:_create_mission_briefing_gui(node)
	self:create_mission_briefing_gui(node)
end
function MenuComponentManager:create_mission_briefing_gui(node)
	if not self._mission_briefing_gui then
		self._mission_briefing_gui = MissionBriefingGui:new(self._ws, self._fullscreen_ws, node)
		if managers.groupai and managers.groupai:state() and not self._whisper_listener then
			self._whisper_listener = "MenuComponentManager_whisper_mode"
			managers.groupai:state():add_listener(self._whisper_listener, {
				"whisper_mode"
			}, callback(self, self, "on_whisper_mode_changed"))
		end
	else
		self._mission_briefing_gui:reload_loadout()
	end
	self._mission_briefing_gui:show()
end
function MenuComponentManager:_hide_mission_briefing_gui()
	self:hide_mission_briefing_gui()
end
function MenuComponentManager:hide_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:hide()
	end
end
function MenuComponentManager:show_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:show()
	end
end
function MenuComponentManager:close_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:close()
		self._mission_briefing_gui = nil
		if self._whisper_listener then
			managers.groupai:state():remove_listener(self._whisper_listener)
			self._whisper_listener = nil
		end
	end
end
function MenuComponentManager:update_mission_briefing_tab_positions()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:update_tab_positions()
		self._mission_briefing_update_tab_wanted = nil
	else
		self._mission_briefing_update_tab_wanted = true
	end
end
function MenuComponentManager:on_whisper_mode_changed()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:on_whisper_mode_changed()
		local hud = managers.hud:get_mission_briefing_hud()
		if hud then
			hud:on_whisper_mode_changed()
		end
	end
end
function MenuComponentManager:set_mission_briefing_description(text_id)
	if self._mission_briefing_gui then
		self._mission_briefing_gui:set_description_text_id(text_id)
	end
end
function MenuComponentManager:on_ready_pressed_mission_briefing_gui(ready)
	if self._mission_briefing_gui then
		self._mission_briefing_gui:on_ready_pressed(ready)
	end
end
function MenuComponentManager:disable_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:set_enabled(false)
	end
end
function MenuComponentManager:unlock_asset_mission_briefing_gui(asset_id)
	if self._mission_briefing_gui then
		self._mission_briefing_gui:unlock_asset(asset_id)
	end
end
function MenuComponentManager:set_slot_outfit_mission_briefing_gui(slot, criminal_name, outfit)
	if self._mission_briefing_gui then
		self._mission_briefing_gui:set_slot_outfit(slot, criminal_name, outfit)
	end
end
function MenuComponentManager:create_asset_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:create_asset_tab()
	end
end
function MenuComponentManager:close_asset_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:close_asset()
	end
end
function MenuComponentManager:flash_ready_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:flash_ready()
	end
end
function MenuComponentManager:_create_lootdrop_gui()
	self:create_lootdrop_gui()
end
function MenuComponentManager:create_lootdrop_gui()
	if not self._lootdrop_gui then
		self._lootdrop_gui = LootDropScreenGui:new(self._ws, self._fullscreen_ws, managers.hud:get_lootscreen_hud(), self._saved_lootdrop_state)
		self._saved_lootdrop_state = nil
	end
	self:show_lootdrop_gui()
end
function MenuComponentManager:set_lootdrop_state(state)
	if self._lootdrop_gui then
		self._lootdrop_gui:set_state(state)
	else
		self._saved_lootdrop_state = state
	end
end
function MenuComponentManager:_hide_lootdrop_gui()
	self:hide_lootdrop_gui()
end
function MenuComponentManager:hide_lootdrop_gui()
	if self._lootdrop_gui then
		self._lootdrop_gui:hide()
	end
end
function MenuComponentManager:show_lootdrop_gui()
	if self._lootdrop_gui then
		self._lootdrop_gui:show()
	end
end
function MenuComponentManager:close_lootdrop_gui()
	if self._lootdrop_gui then
		self._lootdrop_gui:close()
		self._lootdrop_gui = nil
	end
end
function MenuComponentManager:lootdrop_is_now_active()
	if self._lootdrop_gui then
		self._lootdrop_gui._panel:show()
		self._lootdrop_gui._fullscreen_panel:show()
	end
end
function MenuComponentManager:_create_lootdrop_casino_gui(node)
	self:create_lootdrop_casino_gui(node)
end
function MenuComponentManager:create_lootdrop_casino_gui(node)
	if not self._lootdrop_casino_gui then
		local casino_data = node:parameters().menu_component_data or {}
		local card_secured = casino_data.secure_cards or 0
		local card_drops = {}
		card_drops[1] = card_secured >= math.random(3) and casino_data.preferred_item
		card_secured = card_drops[1] and card_secured - 1 or card_secured
		card_drops[2] = (card_secured ~= 2 or not managers.lootdrop:specific_fake_loot_pc(casino_data.preferred_item)) and card_secured == 1 and card_secured == math.random(3) and managers.lootdrop:specific_fake_loot_pc(casino_data.preferred_item)
		card_secured = card_drops[2] and card_secured - 1 or card_secured
		card_drops[3] = card_secured > 0 and managers.lootdrop:specific_fake_loot_pc(casino_data.preferred_item)
		local skip_types = {cash = true, xp = true}
		local setup_lootdrop_data = {}
		setup_lootdrop_data.preferred_type = casino_data.preferred_item
		setup_lootdrop_data.preferred_type_drop = card_drops[1]
		setup_lootdrop_data.preferred_chance = tweak_data:get_value("casino", "prefer_chance")
		setup_lootdrop_data.increase_infamous = casino_data.increase_infamous and tweak_data:get_value("casino", "infamous_chance")
		setup_lootdrop_data.skip_types = skip_types
		setup_lootdrop_data.disable_difficulty = true
		setup_lootdrop_data.max_pcs = 1
		local new_lootdrop_data = {}
		managers.lootdrop:new_make_drop(new_lootdrop_data, setup_lootdrop_data)
		local global_values = {
			normal = 1,
			superior = 2,
			exceptional = 3,
			infamous = 4
		}
		local peer = managers.network:session() and managers.network:session():local_peer() or false
		local global_value = global_values[new_lootdrop_data.global_value] or 1
		local item_category = new_lootdrop_data.type_items
		local item_id = new_lootdrop_data.item_entry
		local max_pc = new_lootdrop_data.total_stars
		local item_pc = new_lootdrop_data.joker and 0 or math.ceil(new_lootdrop_data.item_payclass / 10)
		skip_types.weapon_mods = not managers.lootdrop:can_drop_weapon_mods() and true or nil
		local card_left_pc = card_drops[2] or managers.lootdrop:new_fake_loot_pc(nil, skip_types)
		local card_right_pc = card_drops[3] or managers.lootdrop:new_fake_loot_pc(nil, skip_types)
		local lootdrop_data = {
			peer,
			new_lootdrop_data.global_value,
			item_category,
			item_id,
			max_pc,
			item_pc,
			card_left_pc,
			card_right_pc
		}
		local selected_card = {}
		selected_card[peer and peer:id() or 1] = 2
		local parent_layer = managers.menu:active_menu() and managers.menu:active_menu().renderer:selected_node() and managers.menu:active_menu().renderer:selected_node():layer() or 100
		self._lootscreen_casino_hud = HUDLootScreen:new(nil, self._fullscreen_ws, nil, selected_card)
		self._lootscreen_casino_hud:set_layer(parent_layer + 1)
		self._lootscreen_casino_hud:show()
		self._lootdrop_casino_gui = CasinoLootDropScreenGui:new(self._ws, self._fullscreen_ws, self._lootscreen_casino_hud)
		self._lootdrop_casino_gui:set_layer(parent_layer + 1)
		self._lootscreen_casino_hud:make_cards(peer, max_pc, card_left_pc, card_right_pc)
		self._lootscreen_casino_hud:make_lootdrop(lootdrop_data)
		if not managers.menu:is_pc_controller() then
			managers.menu:active_menu().input:deactivate_controller_mouse()
		end
	end
	if self._lootdrop_casino_gui then
		self:disable_crimenet()
		self._lootdrop_casino_gui:show()
	end
end
function MenuComponentManager:close_lootdrop_casino_gui()
	if self._lootdrop_casino_gui then
		self._lootdrop_casino_gui:close()
		self._lootdrop_casino_gui = nil
		self:enable_crimenet()
	end
	if self._lootscreen_casino_hud then
		self._lootscreen_casino_hud:close()
		self._lootscreen_casino_hud = nil
		if not managers.menu:is_pc_controller() then
			managers.menu:active_menu().input:activate_controller_mouse()
		end
	end
end
function MenuComponentManager:check_lootdrop_casino_done()
	return self._lootdrop_casino_gui:card_chosen()
end
function MenuComponentManager:_create_stage_endscreen_gui()
	self:create_stage_endscreen_gui()
end
function MenuComponentManager:create_stage_endscreen_gui()
	if not self._stage_endscreen_gui then
		self._stage_endscreen_gui = StageEndScreenGui:new(self._ws, self._fullscreen_ws)
	end
	game_state_machine:current_state():set_continue_button_text()
	self._stage_endscreen_gui:show()
	if self._endscreen_predata then
		if self._endscreen_predata.cash_summary then
			self:show_endscreen_cash_summary()
		end
		if self._endscreen_predata.stats then
			self:feed_endscreen_statistics(self._endscreen_predata.stats)
		end
		if self._endscreen_predata.continue then
			self:set_endscreen_continue_button_text(self._endscreen_predata.continue[1], self._endscreen_predata.continue[2])
		end
		self._endscreen_predata = nil
	end
end
function MenuComponentManager:_hide_stage_endscreen_gui()
	self:hide_stage_endscreen_gui()
end
function MenuComponentManager:hide_stage_endscreen_gui()
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:hide()
	end
end
function MenuComponentManager:show_stage_endscreen_gui()
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:show()
	end
end
function MenuComponentManager:close_stage_endscreen_gui()
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:close()
		self._stage_endscreen_gui = nil
	end
end
function MenuComponentManager:show_endscreen_cash_summary()
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:show_cash_summary()
	else
		self._endscreen_predata = self._endscreen_predata or {}
		self._endscreen_predata.cash_summary = true
	end
end
function MenuComponentManager:feed_endscreen_statistics(data)
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:feed_statistics(data)
	else
		self._endscreen_predata = self._endscreen_predata or {}
		self._endscreen_predata.stats = data
	end
end
function MenuComponentManager:set_endscreen_continue_button_text(text, not_clickable)
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:set_continue_button_text(text, not_clickable)
	else
		self._endscreen_predata = self._endscreen_predata or {}
		self._endscreen_predata.continue = {text, not_clickable}
	end
end
function MenuComponentManager:_create_menuscene_info_gui(node)
	self:_close_menuscene_info_gui()
	if not self._menuscene_info_gui then
		self._menuscene_info_gui = MenuSceneGui:new(self._ws, self._fullscreen_ws, node)
	end
end
function MenuComponentManager:_close_menuscene_info_gui()
	if self._menuscene_info_gui then
		self._menuscene_info_gui:close()
		self._menuscene_info_gui = nil
	end
end
function MenuComponentManager:_create_player_profile_gui()
	self:create_player_profile_gui()
end
function MenuComponentManager:create_player_profile_gui()
	self:close_player_profile_gui()
	self._player_profile_gui = PlayerProfileGuiObject:new(self._ws)
end
function MenuComponentManager:refresh_player_profile_gui()
	if self._player_profile_gui then
		self:create_player_profile_gui()
	end
end
function MenuComponentManager:close_player_profile_gui()
	if self._player_profile_gui then
		self._player_profile_gui:close()
		self._player_profile_gui = nil
	end
end
function MenuComponentManager:_create_ingame_manual_gui()
	self:create_ingame_manual_gui()
end
function MenuComponentManager:create_ingame_manual_gui()
	self:close_ingame_manual_gui()
	self._ingame_manual_gui = IngameManualGui:new(self._ws, self._fullscreen_ws)
	self._ingame_manual_gui:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end
function MenuComponentManager:ingame_manual_texture_done(texture_ids)
	if self._ingame_manual_gui then
		self._ingame_manual_gui:create_page(texture_ids)
	else
		local destroy_me = self._ws:panel():bitmap({
			texture = texture_ids,
			visible = false,
			w = 0,
			h = 0
		})
		destroy_me:parent():remove(destroy_me)
	end
end
function MenuComponentManager:close_ingame_manual_gui()
	if self._ingame_manual_gui then
		self._ingame_manual_gui:close()
		self._ingame_manual_gui = nil
	end
end
function MenuComponentManager:_create_ingame_contract_gui()
	self:create_ingame_contract_gui()
end
function MenuComponentManager:create_ingame_contract_gui()
	self:close_ingame_contract_gui()
	self._ingame_contract_gui = IngameContractGui:new(self._ws)
	self._ingame_contract_gui:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end
function MenuComponentManager:close_ingame_contract_gui()
	if self._ingame_contract_gui then
		self._ingame_contract_gui:close()
		self._ingame_contract_gui = nil
	end
end
function MenuComponentManager:_create_profile_gui()
	if self._profile_gui then
		self._profile_gui:set_enabled(true)
		return
	end
	self:create_profile_gui()
end
function MenuComponentManager:create_profile_gui()
	self:close_profile_gui()
	self._profile_gui = ProfileBoxGui:new(self._ws)
	self._profile_gui:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end
function MenuComponentManager:_disable_profile_gui()
	if self._profile_gui then
		self._profile_gui:set_enabled(false)
	end
end
function MenuComponentManager:close_profile_gui()
	if self._profile_gui then
		self._profile_gui:close()
		self._profile_gui = nil
	end
end
function MenuComponentManager:create_test_profiles()
	self:close_test_profiles()
	self._test_profile1 = ProfileBoxGui:new(self._ws)
	self._test_profile1:set_title("")
	self._test_profile1:set_use_minimize_legend(false)
	self._test_profile2 = ProfileBoxGui:new(self._ws)
	self._test_profile2:set_title("")
	self._test_profile2:set_use_minimize_legend(false)
	self._test_profile3 = ProfileBoxGui:new(self._ws)
	self._test_profile3:set_title("")
	self._test_profile3:set_use_minimize_legend(false)
	self._test_profile4 = ProfileBoxGui:new(self._ws)
	self._test_profile4:set_title("")
	self._test_profile4:set_use_minimize_legend(false)
end
function MenuComponentManager:close_test_profiles()
	if self._test_profile1 then
		self._test_profile1:close()
		self._test_profile1 = nil
		self._test_profile2:close()
		self._test_profile2 = nil
		self._test_profile3:close()
		self._test_profile3 = nil
		self._test_profile4:close()
		self._test_profile4 = nil
	end
end
function MenuComponentManager:create_lobby_profile_gui(peer_id, x, y)
	self:close_lobby_profile_gui()
	self._lobby_profile_gui = LobbyProfileBoxGui:new(self._ws, nil, nil, nil, {
		h = 160,
		x = x,
		y = y
	}, peer_id)
	self._lobby_profile_gui:set_title(nil)
	self._lobby_profile_gui:set_use_minimize_legend(false)
end
function MenuComponentManager:close_lobby_profile_gui()
	if self._lobby_profile_gui then
		self._lobby_profile_gui:close()
		self._lobby_profile_gui = nil
	end
	if self._lobby_profile_gui_minimized_id then
		self:remove_minimized(self._lobby_profile_gui_minimized_id)
		self._lobby_profile_gui_minimized_id = nil
	end
end
function MenuComponentManager:create_view_character_profile_gui(user, x, y)
	self:close_view_character_profile_gui()
	self._view_character_profile_gui = ViewCharacterProfileBoxGui:new(self._ws, nil, nil, nil, {
		h = 160,
		w = 360,
		x = 837,
		y = 100
	}, user)
	self._view_character_profile_gui:set_title(nil)
	self._view_character_profile_gui:set_use_minimize_legend(false)
end
function MenuComponentManager:close_view_character_profile_gui()
	if self._view_character_profile_gui then
		self._view_character_profile_gui:close()
		self._view_character_profile_gui = nil
	end
	if self._view_character_profile_gui_minimized_id then
		self:remove_minimized(self._view_character_profile_gui_minimized_id)
		self._view_character_profile_gui_minimized_id = nil
	end
end
function MenuComponentManager:get_texture_from_mod_type(type, sub_type, gadget, silencer, is_auto, equipped, mods, types, is_a_path)
	local texture
	if is_a_path then
		texture = type
	elseif silencer then
		texture = "guis/textures/pd2/blackmarket/inv_mod_silencer"
	elseif type == "gadget" then
		texture = "guis/textures/pd2/blackmarket/inv_mod_" .. (gadget or "flashlight")
	elseif type == "upper_reciever" or type == "lower_reciever" then
		texture = "guis/textures/pd2/blackmarket/inv_mod_custom"
	elseif type == "custom" then
		texture = "guis/textures/pd2/blackmarket/inv_mod_" .. (sub_type or is_auto and "autofire" or "singlefire")
	elseif type == "sight" then
		texture = "guis/textures/pd2/blackmarket/inv_mod_scope"
	elseif type == "ammo" then
		if equipped then
			texture = "guis/textures/pd2/blackmarket/inv_mod_" .. tostring(sub_type or type)
		elseif mods and #mods > 0 then
			local weapon_factory_tweak_data = tweak_data.weapon.factory.parts
			local part_id = mods[1][1]
			type = weapon_factory_tweak_data[part_id].type
			sub_type = weapon_factory_tweak_data[part_id].sub_type
			texture = "guis/textures/pd2/blackmarket/inv_mod_" .. tostring(sub_type or type)
		end
		texture = "guis/textures/pd2/blackmarket/inv_mod_" .. tostring(sub_type or type)
	elseif type == "bonus" then
		if equipped then
			texture = "guis/textures/pd2/blackmarket/inv_mod_" .. tostring(sub_type or type)
		else
			texture = "guis/textures/pd2/blackmarket/inv_mod_bonus"
		end
		texture = "guis/textures/pd2/blackmarket/inv_mod_" .. tostring(sub_type or type)
	else
		texture = "guis/textures/pd2/blackmarket/inv_mod_" .. type
	end
	return texture
end
function MenuComponentManager:create_weapon_mod_icon_list(weapon, category, factory_id, slot)
