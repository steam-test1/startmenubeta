local tmp_rot1 = Rotation()
UnitNetworkHandler = UnitNetworkHandler or class(BaseNetworkHandler)
function UnitNetworkHandler:set_unit(unit, character_name, outfit_string, outfit_version, peer_id, team_id)
	print("[UnitNetworkHandler:set_unit]", unit, character_name, peer_id)
	Application:stack_dump()
	if not alive(unit) then
		return
	end
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if peer_id == 0 then
		local crim_data = managers.criminals:character_data_by_name(character_name)
		if not crim_data or not crim_data.ai then
			managers.criminals:add_character(character_name, unit, peer_id, true)
		else
			managers.criminals:set_unit(character_name, unit)
		end
		unit:movement():set_character_anim_variables()
		return
	end
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		return
	end
	if peer ~= managers.network:session():local_peer() then
		peer:set_outfit_string(outfit_string, outfit_version)
	end
	peer:set_unit(unit, character_name)
	self:_chk_flush_unit_too_early_packets(unit)
end
function UnitNetworkHandler:set_equipped_weapon(unit, item_index, blueprint_string, cosmetics_string, sender)
	if not self._verify_character(unit) then
		return
	end
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	unit:inventory():synch_equipped_weapon(item_index, blueprint_string, cosmetics_string, peer)
end
function UnitNetworkHandler:set_weapon_gadget_state(unit, gadget_state, sender)
	if not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:inventory():synch_weapon_gadget_state(gadget_state)
end
function UnitNetworkHandler:set_look_dir(unit, yaw_in, pitch_in, sender)
	if not self._verify_character_and_sender(unit, sender) then
		return
	end
	local dir = Vector3()
	local yaw = 360 * yaw_in / 255
	local pitch = math.lerp(-85, 85, pitch_in / 127)
	local rot = Rotation(yaw, pitch, 0)
	mrotation.y(rot, dir)
	unit:movement():sync_look_dir(dir)
end
function UnitNetworkHandler:action_walk_start(unit, first_nav_point, nav_link_yaw, nav_link_act_index, from_idle, haste_code, end_yaw, no_walk, no_strafe, end_pose_code)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local end_rot
	if end_yaw ~= 0 then
		end_rot = Rotation(360 * (end_yaw - 1) / 254, 0, 0)
	end
	local nav_path = {}
	if nav_link_act_index ~= 0 then
		local nav_link_rot = 360 * nav_link_yaw / 255
		local nav_link = unit:movement()._actions.walk.synthesize_nav_link(first_nav_point, nav_link_rot, unit:movement()._actions.act:_get_act_name_from_index(nav_link_act_index), from_idle)
		function nav_link.element.value(element, name)
			return element[name]
		end
		function nav_link.element.nav_link_wants_align_pos(element)
			return element.from_idle
		end
		table.insert(nav_path, nav_link)
	else
		table.insert(nav_path, first_nav_point)
	end
	local end_pose
	if end_pose_code == 1 then
		end_pose = "stand"
	elseif end_pose_code == 2 then
		end_pose = "crouch"
	end
	local action_desc = {
		type = "walk",
		variant = haste_code == 1 and "walk" or "run",
		end_rot = end_rot,
		body_part = 2,
		nav_path = nav_path,
		path_simplified = true,
		persistent = true,
		no_walk = no_walk,
		no_strafe = no_strafe,
		end_pose = end_pose,
		blocks = {
			walk = -1,
			turn = -1,
			act = -1,
			idle = -1
		}
	}
	unit:movement():action_request(action_desc)
end
function UnitNetworkHandler:action_walk_nav_point(unit, nav_point, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():sync_action_walk_nav_point(nav_point)
end
function UnitNetworkHandler:action_walk_stop(unit)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():sync_action_walk_stop()
end
function UnitNetworkHandler:action_walk_nav_link(unit, pos, yaw, anim_index, from_idle)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local rot = 360 * yaw / 255
	unit:movement():sync_action_walk_nav_link(pos, rot, anim_index, from_idle)
end
function UnitNetworkHandler:action_spooc_start(unit, target_u_pos, flying_strike, action_id)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local action_desc = {
		type = "spooc",
		body_part = 1,
		block_type = "walk",
		nav_path = {
			unit:position()
		},
		target_u_pos = target_u_pos,
		path_index = 1,
		flying_strike = flying_strike,
		action_id = action_id,
		blocks = {
			walk = -1,
			turn = -1,
			act = -1,
			idle = -1
		}
	}
	if flying_strike then
		action_desc.blocks.light_hurt = -1
		action_desc.blocks.hurt = -1
		action_desc.blocks.heavy_hurt = -1
		action_desc.blocks.expl_hurt = -1
	end
	unit:movement():action_request(action_desc)
end
function UnitNetworkHandler:action_spooc_stop(unit, pos, nav_index, action_id, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():sync_action_spooc_stop(pos, nav_index, action_id)
end
function UnitNetworkHandler:action_spooc_nav_point(unit, pos, action_id, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():sync_action_spooc_nav_point(pos, action_id)
end
function UnitNetworkHandler:action_spooc_strike(unit, pos, action_id, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():sync_action_spooc_strike(pos, action_id)
end
function UnitNetworkHandler:action_warp_start(unit, has_pos, pos, has_rot, yaw, sender)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local action_desc = {
		type = "warp",
		body_part = 1,
		position = has_pos and pos,
		rotation = has_rot and Rotation(360 * (yaw - 1) / 254, 0, 0)
	}
	unit:movement():action_request(action_desc)
end
function UnitNetworkHandler:friendly_fire_hit(subject_unit)
	if not self._verify_character(subject_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	subject_unit:character_damage():friendly_fire_hit()
end
function UnitNetworkHandler:damage_bullet(subject_unit, attacker_unit, damage, i_body, height_offset, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_bullet(attacker_unit, damage, i_body, height_offset, death)
end
function UnitNetworkHandler:damage_explosion_fire(subject_unit, attacker_unit, damage, i_attack_variant, death, direction, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	if i_attack_variant == 3 then
		subject_unit:character_damage():sync_damage_fire(attacker_unit, damage, i_attack_variant, death, direction)
	else
		subject_unit:character_damage():sync_damage_explosion(attacker_unit, damage, i_attack_variant, death, direction)
	end
end
function UnitNetworkHandler:damage_fire(subject_unit, attacker_unit, damage, start_dot_dance_antimation, death, direction, weapon_type, weapon_unit, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_fire(attacker_unit, damage, start_dot_dance_antimation, death, direction, weapon_type, weapon_unit)
end
function UnitNetworkHandler:damage_dot(subject_unit, attacker_unit, damage, death, variant, hurt_animation, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_dot(attacker_unit, damage, death, variant, hurt_animation)
end
function UnitNetworkHandler:damage_tase(subject_unit, attacker_unit, damage, variant, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_tase(attacker_unit, damage, variant, death)
end
function UnitNetworkHandler:damage_melee(subject_unit, attacker_unit, damage, damage_effect, i_body, height_offset, variant, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_melee(attacker_unit, damage, damage_effect, i_body, height_offset, variant, death)
end
function UnitNetworkHandler:from_server_damage_bullet(subject_unit, attacker_unit, hit_offset_height, result_index, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_bullet(attacker_unit, hit_offset_height, result_index)
end
function UnitNetworkHandler:from_server_damage_explosion_fire(subject_unit, attacker_unit, result_index, i_attack_variant, sender)
	if not self._verify_character(subject_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	if i_attack_variant == 3 then
		subject_unit:character_damage():sync_damage_fire(attacker_unit, result_index, i_attack_variant)
	else
		subject_unit:character_damage():sync_damage_explosion(attacker_unit, result_index, i_attack_variant)
	end
end
function UnitNetworkHandler:from_server_damage_melee(subject_unit, attacker_unit, hit_offset_height, result_index, sender)
	if not self._verify_character(subject_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_melee(attacker_unit, attacker_unit, hit_offset_height, result_index)
end
function UnitNetworkHandler:from_server_damage_incapacitated(subject_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end
	subject_unit:character_damage():sync_damage_incapacitated()
end
function UnitNetworkHandler:from_server_damage_bleeding(subject_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end
	subject_unit:character_damage():sync_damage_bleeding()
end
function UnitNetworkHandler:from_server_damage_tase(subject_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end
	subject_unit:character_damage():sync_damage_tase()
end
function UnitNetworkHandler:from_server_unit_recovered(subject_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end
	subject_unit:character_damage():sync_unit_recovered()
end
function UnitNetworkHandler:shot_blank(shooting_unit, impact, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(shooting_unit, sender) then
		return
	end
	shooting_unit:movement():sync_shot_blank(impact)
end
function UnitNetworkHandler:shot_blank_reliable(shooting_unit, impact, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(shooting_unit, sender) then
		return
	end
	shooting_unit:movement():sync_shot_blank(impact)
end
function UnitNetworkHandler:reload_weapon(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:movement():sync_reload_weapon()
end
function UnitNetworkHandler:run_mission_element(id, unit, orientation_element_index)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		if self._verify_gamestate(self._gamestate_filter.any_end_game) then
			managers.mission:client_run_mission_element_end_screen(id, unit, orientation_element_index)
			return
		end
		print("UnitNetworkHandler:run_mission_element discarded id:", id)
		return
	end
	managers.mission:client_run_mission_element(id, unit, orientation_element_index)
end
function UnitNetworkHandler:run_mission_element_no_instigator(id, orientation_element_index)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		if self._verify_gamestate(self._gamestate_filter.any_end_game) then
			managers.mission:client_run_mission_element_end_screen(id, nil, orientation_element_index)
		end
		return
	end
	managers.mission:client_run_mission_element(id, nil, orientation_element_index)
end
function UnitNetworkHandler:to_server_mission_element_trigger(id, unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.mission:server_run_mission_element_trigger(id, unit)
end
function UnitNetworkHandler:to_server_area_event(event_id, id, unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.mission:to_server_area_event(event_id, id, unit)
end
function UnitNetworkHandler:to_server_access_camera_trigger(id, trigger, instigator)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.mission:to_server_access_camera_trigger(id, trigger, instigator)
end
function UnitNetworkHandler:sync_body_damage_bullet(body, attacker, normal_yaw, normal_pitch, position, direction_yaw, direction_pitch, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_bullet then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no damage damage_bullet function", body:name(), body:unit():name())
		return
	end
	local normal = Vector3()
	mrotation.set_yaw_pitch_roll(tmp_rot1, math.lerp(-180, 180, normal_yaw / 127), math.lerp(-90, 90, normal_pitch / 63), 0)
	mrotation.y(tmp_rot1, normal)
	local direction = Vector3()
	mrotation.set_yaw_pitch_roll(tmp_rot1, math.lerp(-180, 180, direction_yaw / 127), math.lerp(-90, 90, direction_pitch / 63), 0)
	mrotation.y(tmp_rot1, direction)
	body:extension().damage:damage_bullet(attacker, normal, position, direction, 1)
	body:extension().damage:damage_damage(attacker, normal, position, direction, damage / 163.84)
end
function UnitNetworkHandler:sync_body_damage_lock(body, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_lock] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_lock] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_lock then
		print("[UnitNetworkHandler:sync_body_damage_lock] body has no damage damage_lock function", body:name(), body:unit():name())
		return
	end
	body:extension().damage:damage_lock(nil, nil, nil, nil, damage)
end
function UnitNetworkHandler:sync_body_damage_explosion(body, attacker, normal, position, direction, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_explosion] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_explosion] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_explosion then
		print("[UnitNetworkHandler:sync_body_damage_explosion] body has no damage damage_explosion function", body:name(), body:unit():name())
		return
	end
	body:extension().damage:damage_explosion(attacker, normal, position, direction, damage / 163.84)
	body:extension().damage:damage_damage(attacker, normal, position, direction, damage / 163.84)
end
function UnitNetworkHandler:sync_body_damage_explosion_no_attacker(body, normal, position, direction, damage, sender)
	self:sync_body_damage_explosion(body, nil, normal, position, direction, damage, sender)
end
function UnitNetworkHandler:sync_body_damage_fire(body, attacker, normal, position, direction, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_fire] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_fire] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_fire then
		print("[UnitNetworkHandler:sync_body_damage_fire] body has no damage damage_fire function", body:name(), body:unit():name())
		return
	end
	body:extension().damage:damage_fire(attacker, normal, position, direction, damage / 163.84)
	body:extension().damage:damage_damage(attacker, normal, position, direction, damage / 163.84)
end
function UnitNetworkHandler:sync_body_damage_fire_no_attacker(body, normal, position, direction, damage, sender)
	self:sync_body_damage_fire(body, nil, normal, position, direction, damage, sender)
end
function UnitNetworkHandler:sync_body_damage_melee(body, attacker, normal, position, direction, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_melee] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_melee] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_melee then
		print("[UnitNetworkHandler:sync_body_damage_melee] body has no damage damage_melee function", body:name(), body:unit():name())
		return
	end
	body:extension().damage:damage_melee(attacker, normal, position, direction, damage)
end
function UnitNetworkHandler:sync_interacted(unit, unit_id, tweak_setting, status, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	if Network:is_server() and unit_id ~= -2 then
		if alive(unit) and unit:interaction().tweak_data == tweak_setting and unit:interaction():active() then
			sender:sync_interaction_reply(true)
		else
			sender:sync_interaction_reply(false)
			return
		end
	end
	if alive(unit) then
		unit:interaction():sync_interacted(peer, nil, status)
	end
end
function UnitNetworkHandler:sync_multiple_equipment_bag_interacted(unit, amount_wanted, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	if unit and alive(unit) and unit:interaction() then
		unit:interaction():sync_interacted(peer, nil, amount_wanted)
	end
end
function UnitNetworkHandler:sync_interaction_info_id(unit, info_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	if alive(unit) and unit:interaction().set_info_id then
		unit:interaction():set_info_id(info_id)
	end
end
function UnitNetworkHandler:sync_interacted_by_id(unit_id, tweak_setting, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) and not self._verify_sender(sender) then
		return
	end
	local u_data = managers.enemy:get_corpse_unit_data_from_id(unit_id)
	if not u_data then
		sender:sync_interaction_reply(false)
		return
	end
	self:sync_interacted(u_data.unit, unit_id, tweak_setting, 1, sender)
end
function UnitNetworkHandler:sync_interaction_reply(status)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(managers.player:player_unit()) then
		return
	end
	managers.player:from_server_interaction_reply(status)
end
function UnitNetworkHandler:interaction_set_active(unit, u_id, active, tweak_data, flash, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(unit) then
		local u_data = managers.enemy:get_corpse_unit_data_from_id(u_id)
		if not u_data then
			return
		end
		unit = u_data.unit
	end
	unit:interaction():set_tweak_data(tweak_data)
	unit:interaction():set_active(active)
	if flash then
		unit:interaction():set_outline_flash_state(true, nil)
	end
end
function UnitNetworkHandler:sync_teammate_progress(type_index, enabled, tweak_data_id, timer, success, sender)
	local sender_peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not sender_peer then
		return
	end
	local peer_id = sender_peer:id()
	managers.hud:teammate_progress(peer_id, type_index, enabled, tweak_data_id, timer, success)
end
function UnitNetworkHandler:action_aim_state(cop)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(cop) then
		return
	end
	local shoot_action = {
		type = "shoot",
		body_part = 3,
		block_type = "action"
	}
	cop:movement():action_request(shoot_action)
end
function UnitNetworkHandler:action_aim_end(cop)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(cop) then
		return
	end
	cop:movement():sync_action_aim_end()
end
function UnitNetworkHandler:action_hurt_end(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():sync_action_hurt_end()
end
function UnitNetworkHandler:set_attention(unit, target_unit, reaction, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	if not alive(target_unit) then
		unit:movement():synch_attention()
		return
	end
	local handler
	if target_unit:attention() then
		handler = target_unit:attention()
	elseif target_unit:brain() and target_unit:brain().attention_handler then
		handler = target_unit:brain():attention_handler()
	elseif target_unit:movement() and target_unit:movement().attention_handler then
		handler = target_unit:movement():attention_handler()
	elseif target_unit:base() and target_unit:base().attention_handler then
		handler = target_unit:base():attention_handler()
	end
	if not handler and (not target_unit:movement() or not target_unit:movement().m_head_pos) then
		debug_pause_unit(target_unit, "[UnitNetworkHandler:set_attention] no attention handler or m_head_pos", target_unit)
		return
	end
	unit:movement():synch_attention({
		unit = target_unit,
		u_key = target_unit:key(),
		handler = handler,
		reaction = reaction
	})
end
function UnitNetworkHandler:cop_set_attention_pos(unit, pos)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():synch_attention({
		pos = pos,
		reaction = AIAttentionObject.REACT_IDLE
	})
end
function UnitNetworkHandler:set_allow_fire(unit, state)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():synch_allow_fire(state)
end
function UnitNetworkHandler:set_stance(unit, stance_code, instant, execute_queued, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:movement():sync_stance(stance_code, instant, execute_queued)
end
function UnitNetworkHandler:set_pose(unit, pose_code, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:movement():sync_pose(pose_code)
end
function UnitNetworkHandler:long_dis_interaction(target_unit, amount, aggressor_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(target_unit) or not self._verify_character(aggressor_unit) then
		return
	end
	local target_is_criminal = target_unit:in_slot(managers.slot:get_mask("criminals")) or target_unit:in_slot(managers.slot:get_mask("harmless_criminals"))
	local target_is_civilian = not target_is_criminal and target_unit:in_slot(21)
	local aggressor_is_criminal = aggressor_unit:in_slot(managers.slot:get_mask("criminals")) or aggressor_unit:in_slot(managers.slot:get_mask("harmless_criminals"))
	if target_is_criminal then
		if aggressor_is_criminal then
			if target_unit:brain() then
				if target_unit:brain().on_long_dis_interacted then
					target_unit:movement():set_cool(false)
					target_unit:brain():on_long_dis_interacted(amount, aggressor_unit)
				end
			elseif amount == 1 then
				target_unit:movement():on_morale_boost(aggressor_unit)
			end
		else
			target_unit:brain():on_intimidated(amount / 10, aggressor_unit)
		end
	elseif amount == 0 and target_is_civilian and aggressor_is_criminal then
		if self._verify_in_server_session() then
			aggressor_unit:movement():sync_call_civilian(target_unit)
		end
	elseif target_unit:brain() then
		target_unit:brain():on_intimidated(amount / 10, aggressor_unit)
	end
end
function UnitNetworkHandler:alarm_pager_interaction(u_id, tweak_table, status, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local unit_data = managers.enemy:get_corpse_unit_data_from_id(u_id)
	if unit_data and unit_data.unit:interaction():active() and unit_data.unit:interaction().tweak_data == tweak_table then
		local peer = self._verify_sender(sender)
		if peer then
			local status_str
			if status == 1 then
				status_str = "started"
			elseif status == 2 then
				status_str = "interrupted"
			else
				status_str = "complete"
			end
			unit_data.unit:interaction():sync_interacted(peer, nil, status_str)
		end
	end
end
function UnitNetworkHandler:remove_corpse_by_id(u_id, carry_bodybag, peer_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if carry_bodybag and Network:is_client() then
		managers.player:register_carry(managers.network:session():peer(peer_id), "person")
	end
	managers.enemy:remove_corpse_by_id(u_id)
end
function UnitNetworkHandler:unit_tied(unit, aggressor)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:brain():on_tied(aggressor)
end
function UnitNetworkHandler:unit_traded(unit, trader)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:brain():on_trade(trader)
end
function UnitNetworkHandler:hostage_trade(unit, enable, trade_success)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	CopLogicTrade.hostage_trade(unit, enable, trade_success)
end
function UnitNetworkHandler:set_unit_invulnerable(unit, enable)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:character_damage():set_invulnerable(enable)
end
function UnitNetworkHandler:set_trade_countdown(enable)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.trade:set_trade_countdown(enable)
end
function UnitNetworkHandler:set_trade_death(criminal_name, respawn_penalty, hostages_killed)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.trade:sync_set_trade_death(criminal_name, respawn_penalty, hostages_killed)
end
function UnitNetworkHandler:set_trade_spawn(criminal_name)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.trade:sync_set_trade_spawn(criminal_name)
end
function UnitNetworkHandler:set_trade_replace(replace_ai, criminal_name1, criminal_name2, respawn_penalty)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.trade:sync_set_trade_replace(replace_ai, criminal_name1, criminal_name2, respawn_penalty)
end
function UnitNetworkHandler:action_idle_start(unit, body_part, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():action_request({type = "idle", body_part = body_part})
end
function UnitNetworkHandler:action_act_start(unit, act_index, blocks_hurt, clamp_to_graph, needs_full_blend)
	self:action_act_start_align(unit, act_index, blocks_hurt, clamp_to_graph, needs_full_blend, nil, nil)
end
function UnitNetworkHandler:action_act_start_align(unit, act_index, blocks_hurt, clamp_to_graph, needs_full_blend, start_yaw, start_pos)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	local start_rot
	if start_yaw and start_yaw ~= 0 then
		start_rot = Rotation(360 * (start_yaw - 1) / 254, 0, 0)
	end
	unit:movement():sync_action_act_start(act_index, blocks_hurt, clamp_to_graph, needs_full_blend, start_rot, start_pos)
end
function UnitNetworkHandler:action_act_end(unit)
	if not alive(unit) or unit:character_damage():dead() then
		return
	end
	unit:movement():sync_action_act_end()
end
function UnitNetworkHandler:action_dodge_start(unit, body_part, variation, side, rotation, speed, shoot_acc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():sync_action_dodge_start(body_part, variation, side, rotation, speed, shoot_acc)
end
function UnitNetworkHandler:action_dodge_end(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():sync_action_dodge_end()
end
function UnitNetworkHandler:action_tase_event(taser_unit, event_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(taser_unit) then
		return
	end
	local sender_peer = self._verify_sender(sender)
	if not sender_peer then
		return
	end
	if event_id == 1 then
		if not managers.network:session():is_client() or managers.network:session():server_peer() ~= sender_peer then
			return
		end
		local tase_action = {type = "tase", body_part = 3}
		taser_unit:movement():action_request(tase_action)
	elseif event_id == 2 then
		if not managers.network:session():is_client() or managers.network:session():server_peer() ~= sender_peer then
			return
		end
		taser_unit:movement():sync_action_tase_end()
	else
		taser_unit:movement():sync_taser_fire()
	end
end
function UnitNetworkHandler:alert(alerted_unit, aggressor)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(alerted_unit) or not self._verify_character(aggressor) then
		return
	end
	local record = managers.groupai:state():criminal_record(aggressor:key())
	if not record then
		return
	end
	local aggressor_pos
	if aggressor:movement() and aggressor:movement().m_head_pos then
		aggressor_pos = aggressor:movement():m_head_pos()
	else
		aggressor_pos = aggressor:position()
	end
	alerted_unit:brain():on_alert({
		"aggression",
		aggressor_pos,
		false,
		nil,
		aggressor
	})
end
function UnitNetworkHandler:revive_player(revive_health_level, revive_damage_reduction, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.need_revive) or not peer then
		return
	end
	local player = managers.player:player_unit()
	if revive_health_level > 0 and alive(player) then
		player:character_damage():set_revive_boost(revive_health_level)
	end
	if revive_damage_reduction > 0 then
		managers.player:activate_temporary_upgrade_by_level("temporary", "passive_revive_damage_reduction", revive_damage_reduction)
	end
	if alive(player) then
		player:character_damage():revive()
	end
end
function UnitNetworkHandler:start_revive_player(timer, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.downed) or not peer then
		return
	end
	local player = managers.player:player_unit()
	if alive(player) then
		player:character_damage():pause_downed_timer(timer, peer:id())
	end
end
function UnitNetworkHandler:interupt_revive_player(sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.downed) or not peer then
		return
	end
	local player = managers.player:player_unit()
	if alive(player) then
		player:character_damage():unpause_downed_timer(peer:id())
	end
end
function UnitNetworkHandler:start_free_player(sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.arrested) or not peer then
		return
	end
	local player = managers.player:player_unit()
	if alive(player) then
		player:character_damage():pause_arrested_timer(peer:id())
	end
end
function UnitNetworkHandler:interupt_free_player(sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.arrested) or not peer then
		return
	end
	local player = managers.player:player_unit()
	if alive(player) then
		player:character_damage():unpause_arrested_timer(peer:id())
	end
end
function UnitNetworkHandler:pause_arrested_timer(unit, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer or not self._verify_character(unit) then
		return
	end
	unit:character_damage():pause_arrested_timer(peer:id())
end
function UnitNetworkHandler:unpause_arrested_timer(unit, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer or not self._verify_character(unit) then
		return
	end
	unit:character_damage():unpause_arrested_timer(peer:id())
end
function UnitNetworkHandler:revive_unit(unit, reviving_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) or not alive(reviving_unit) then
		return
	end
	unit:interaction():interact(reviving_unit)
end
function UnitNetworkHandler:pause_bleed_out(unit, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer or not self._verify_character(unit) then
		return
	end
	unit:character_damage():pause_bleed_out(peer:id())
end
function UnitNetworkHandler:unpause_bleed_out(unit, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer or not self._verify_character(unit) then
		return
	end
	unit:character_damage():unpause_bleed_out(peer:id())
end
function UnitNetworkHandler:interaction_set_waypoint_paused(unit, paused, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(unit) then
		return
	end
	if not unit:interaction() then
		return
	end
	unit:interaction():set_waypoint_paused(paused)
end
function UnitNetworkHandler:attach_device(pos, normal, sensor_upgrade, rpc)
	local peer = self._verify_sender(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	if not managers.player:verify_equipment(peer:id(), "trip_mine") then
		return
	end
	local rot = Rotation(normal, math.UP)
	local peer = self._verify_sender(rpc)
	local unit = TripMineBase.spawn(pos, rot, sensor_upgrade, peer:id())
	unit:base():set_server_information(peer:id())
	rpc:activate_trip_mine(unit)
end
function UnitNetworkHandler:activate_trip_mine(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if alive(unit) then
		unit:base():set_active(true, managers.player:player_unit())
	end
end
function UnitNetworkHandler:sync_trip_mine_setup(unit, sensor_upgrade, peer_id)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.player:verify_equipment(peer_id, "trip_mine")
	unit:base():sync_setup(sensor_upgrade)
end
function UnitNetworkHandler:sync_trip_mine_explode(unit, user_unit, ray_from, ray_to, damage_size, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(user_unit) then
		user_unit = nil
	end
	if alive(unit) then
		unit:base():sync_trip_mine_explode(user_unit, ray_from, ray_to, damage_size, damage)
	end
end
function UnitNetworkHandler:sync_trip_mine_explode_no_user(unit, ray_from, ray_to, damage_size, damage, sender)
	self:sync_trip_mine_explode(unit, nil, ray_from, ray_to, damage_size, damage, sender)
end
function UnitNetworkHandler:sync_trip_mine_set_armed(unit, bool, length, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_trip_mine_set_armed(bool, length)
end
function UnitNetworkHandler:request_place_ecm_jammer(pos, normal, battery_life_upgrade_lvl, rpc)
	local peer = self._verify_sender(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	local owner_unit = peer:unit()
	if not alive(owner_unit) or owner_unit:id() == -1 then
		rpc:from_server_ecm_jammer_place_result(nil)
		return
	end
	if not managers.player:verify_equipment(peer:id(), "ecm_jammer") then
		return
	end
	local rot = Rotation(normal, math.UP)
	local peer = self._verify_sender(rpc)
	local unit = ECMJammerBase.spawn(pos, rot, battery_life_upgrade_lvl, owner_unit, peer:id())
	unit:base():set_server_information(peer:id())
	unit:base():set_active(true)
	rpc:from_server_ecm_jammer_place_result(unit)
end
function UnitNetworkHandler:from_server_ecm_jammer_place_result(unit, rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(unit) or not unit then
		unit = nil
	end
	if alive(managers.player:player_unit()) then
		managers.player:player_unit():equipment():from_server_ecm_jammer_placement_result(unit and true or false)
	end
	if not unit then
		return
	end
	unit:base():set_owner(managers.player:player_unit())
end
function UnitNetworkHandler:from_server_ecm_jammer_rejected(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if alive(managers.player:player_unit()) then
		managers.player:player_unit():equipment():from_server_ecm_jammer_placement_result(false)
	end
end
function UnitNetworkHandler:sync_unit_event_id_16(unit, ext_name, event_id, rpc)
	local peer = self._verify_sender(rpc)
	if not peer or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local extension = unit[ext_name](unit)
	if not extension then
		debug_pause("[UnitNetworkHandler:sync_unit_event_id_16] unit", unit, "does not have extension", ext_name)
		return
	end
	extension:sync_net_event(event_id, peer)
end
function UnitNetworkHandler:m79grenade_explode_on_client(position, normal, user, damage, range, curve_pow, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(user, sender) then
		return
	end
	ProjectileBase._explode_on_client(position, normal, user, damage, range, curve_pow)
end
function UnitNetworkHandler:element_explode_on_client(position, normal, damage, range, curve_pow, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.explosion:client_damage_and_push(position, normal, nil, damage, range, curve_pow)
end
function UnitNetworkHandler:place_sentry_gun(pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, equipment_selection_index, user_unit, rpc)
	local peer = self._verify_sender(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	local unit = SentryGunBase.spawn(user_unit, pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, peer:id(), true)
	if unit then
		unit:base():set_server_information(peer:id())
	end
	managers.network:session():send_to_peers_synched("from_server_sentry_gun_place_result", peer:id(), unit and equipment_selection_index or 0, unit, unit and unit:movement()._rot_speed_mul, unit and unit:weapon()._setup.spread_mul, unit and unit:base():has_shield() and true or false)
end
function UnitNetworkHandler:from_server_sentry_gun_place_result(owner_peer_id, equipment_selection_index, sentry_gun_unit, rot_speed_mul, spread_mul, shield, rpc)
	local local_peer = managers.network:session():local_peer()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(rpc) or not alive(sentry_gun_unit) or not managers.network:session():peer(owner_peer_id) then
		if alive(local_peer:unit()) then
			local_peer:unit():equipment():from_server_sentry_gun_place_result()
		end
		return
	end
	sentry_gun_unit:base():set_owner_id(owner_peer_id)
	if owner_peer_id == local_peer:id() and alive(local_peer:unit()) then
		managers.player:from_server_equipment_place_result(equipment_selection_index, local_peer:unit())
	end
	if shield then
		sentry_gun_unit:base():enable_shield()
	end
	sentry_gun_unit:movement():setup(rot_speed_mul)
	sentry_gun_unit:brain():setup(1 / rot_speed_mul)
	local setup_data = {
		spread_mul = spread_mul,
		ignore_units = {sentry_gun_unit}
	}
	sentry_gun_unit:weapon():setup(setup_data, 1)
end
function UnitNetworkHandler:place_ammo_bag(pos, rot, ammo_upgrade_lvl, rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(rpc) then
		return
	end
	local peer = self._verify_sender(rpc)
	local unit = AmmoBagBase.spawn(pos, rot, ammo_upgrade_lvl)
	unit:base():set_server_information(peer:id())
end
function UnitNetworkHandler:sentrygun_ammo(unit, ammo_ratio)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:weapon():sync_ammo(ammo_ratio)
end
function UnitNetworkHandler:sentrygun_health(unit, health_ratio)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:character_damage():sync_health(health_ratio)
end
function UnitNetworkHandler:turret_idle_state(unit, state)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:brain():set_idle(state)
end
function UnitNetworkHandler:turret_update_shield_smoke_level(unit, ratio, up)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:character_damage():update_shield_smoke_level(ratio, up)
end
function UnitNetworkHandler:turret_repair(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():repair()
end
function UnitNetworkHandler:turret_complete_repairing(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():complete_repairing()
end
function UnitNetworkHandler:turret_repair_shield(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:character_damage():repair_shield()
end
function UnitNetworkHandler:sync_unit_module(parent_unit, module_unit, align_obj_name, module_id, parent_extension_name)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(parent_unit) or not alive(module_unit) then
		return
	end
	parent_unit[parent_extension_name](parent_unit):spawn_module(module_unit, align_obj_name, module_id)
end
function UnitNetworkHandler:run_unit_module_function(parent_unit, module_id, parent_extension_name, module_extension_name, func_name, params)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(parent_unit) then
		return
	end
	local params_split = string.split(params, " ")
	parent_unit[parent_extension_name](parent_unit):run_module_function_unsafe(module_id, module_extension_name, func_name, params_split[1], params_split[2])
end
function UnitNetworkHandler:sync_equipment_setup(unit, upgrade_lvl, peer_id)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:base():sync_setup(upgrade_lvl, peer_id)
end
function UnitNetworkHandler:sync_ammo_bag_ammo_taken(unit, amount, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_ammo_taken(amount)
end
function UnitNetworkHandler:sync_grenade_crate_grenade_taken(unit, amount, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_grenade_taken(amount)
end
function UnitNetworkHandler:place_deployable_bag(class_name, pos, rot, upgrade_lvl, rpc)
	local peer = self._verify_sender(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	local class_name_to_deployable_id = tweak_data.equipments.class_name_to_deployable_id
	if not managers.player:verify_equipment(peer:id(), class_name_to_deployable_id[class_name]) then
		return
	end
	local class = CoreSerialize.string_to_classtable(class_name)
	if class then
		local unit = class.spawn(pos, rot, upgrade_lvl, peer:id())
		unit:base():set_server_information(peer:id())
	end
end
function UnitNetworkHandler:used_deployable(rpc)
	local peer = self._verify_sender(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	peer:set_used_deployable(true)
end
function UnitNetworkHandler:sync_doctor_bag_taken(unit, amount, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_taken(amount)
end
function UnitNetworkHandler:sync_money_wrap_money_taken(unit, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_money_taken()
end
function UnitNetworkHandler:sync_pickup(unit, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local pickup_extension = unit:base()
	if not pickup_extension or not pickup_extension.sync_pickup then
		pickup_extension = unit:pickup()
	end
	if pickup_extension and pickup_extension.sync_pickup then
		pickup_extension:sync_pickup(self._verify_sender(sender))
	end
end
function UnitNetworkHandler:unit_sound_play(unit, event_id, source, sender)
	if not alive(unit) or not self._verify_sender(sender) then
		return
	end
	if source == "" then
		source = nil
	end
	unit:sound():play(event_id, source, false)
end
function UnitNetworkHandler:corpse_sound_play(unit_id, event_id, source)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local u_data = managers.enemy:get_corpse_unit_data_from_id(unit_id)
	if not u_data then
		return
	end
	if not u_data.unit then
		debug_pause("[UnitNetworkHandler:corpse_sound_play] u_data without unit", inspect(u_data))
		return
	end
	if not u_data.unit:sound() then
		return
	end
	u_data.unit:sound():play(event_id, source, false)
end
function UnitNetworkHandler:say(unit, event_id, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if unit:in_slot(managers.slot:get_mask("all_criminals")) and not managers.groupai:state():is_enemy_converted_to_criminal(unit) then
		unit:sound():say(event_id, nil, false)
	else
		unit:sound():say(event_id, nil, true)
	end
end
function UnitNetworkHandler:sync_remove_one_teamAI(name, replace_with_player)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_remove_one_teamAI(name, replace_with_player)
end
function UnitNetworkHandler:sync_smoke_grenade(detonate_pos, shooter_pos, duration, flashbang)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_smoke_grenade(detonate_pos, shooter_pos, duration, flashbang)
end
function UnitNetworkHandler:sync_smoke_grenade_kill()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_smoke_grenade_kill()
end
function UnitNetworkHandler:sync_cs_grenade(detonate_pos, shooter_pos, duration)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_cs_grenade(detonate_pos, shooter_pos, duration)
end
function UnitNetworkHandler:sync_cs_grenade_kill()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_cs_grenade_kill()
end
function UnitNetworkHandler:sync_hostage_headcount(value)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_hostage_headcount(value)
end
function UnitNetworkHandler:play_distance_interact_redirect(unit, redirect, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:movement():play_redirect(redirect)
end
function UnitNetworkHandler:start_timer_gui(unit, timer, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:timer_gui():sync_start(timer)
end
function UnitNetworkHandler:give_equipment(equipment, amount, transfer, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:add_special({
		name = equipment,
		amount = amount,
		transfer = transfer
	})
end
function UnitNetworkHandler:killzone_set_unit(type)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.killzone:set_unit(managers.player:player_unit(), type)
end
function UnitNetworkHandler:dangerzone_set_level(level)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.player:player_unit():character_damage():set_danger_level(level)
end
function UnitNetworkHandler:sync_player_movement_state(unit, state, down_time, unit_id_str)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	self:_chk_unit_too_early(unit, unit_id_str, "sync_player_movement_state", 1, unit, state, down_time, unit_id_str)
	if not alive(unit) then
		return
	end
	Application:trace("[UnitNetworkHandler:sync_player_movement_state]: ", unit:movement():current_state_name(), "->", state)
	local local_peer = managers.network:session():local_peer()
	if local_peer:unit() and unit:key() == local_peer:unit():key() then
		local valid_transitions = {
			standard = {
				bleed_out = true,
				arrested = true,
				tased = true,
				incapacitated = true,
				carry = true
			},
			carry = {
				bleed_out = true,
				arrested = true,
				tased = true,
				incapacitated = true,
				standard = true
			},
			mask_off = {
				standard = true,
				carry = true,
				arrested = true
			},
			bleed_out = {
				fatal = true,
				standard = true,
				carry = true
			},
			fatal = {standard = true, carry = true},
			arrested = {standard = true, carry = true},
			tased = {
				standard = true,
				carry = true,
				incapacitated = true
			},
			incapacitated = {standard = true, carry = true},
			clean = {
				civilian = true,
				mask_off = true,
				standard = true,
				carry = true,
				arrested = true
			},
			civilian = {
				clean = true,
				mask_off = true,
				standard = true,
				carry = true,
				arrested = true
			}
		}
		if unit:movement():current_state_name() == state then
			return
		end
		if unit:movement():current_state_name() and valid_transitions[unit:movement():current_state_name()][state] then
			managers.player:set_player_state(state)
		else
			debug_pause_unit(unit, "[UnitNetworkHandler:sync_player_movement_state] received invalid transition", unit, unit:movement():current_state_name(), "->", state)
		end
	else
		unit:movement():sync_movement_state(state, down_time)
	end
end
function UnitNetworkHandler:sync_show_hint(id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.hint:sync_show_hint(id)
end
function UnitNetworkHandler:sync_show_action_message(unit, id, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.action_messaging:sync_show_message(id, unit)
end
function UnitNetworkHandler:sync_waiting_for_player_start(variant, soundtrack)
	if not self._verify_gamestate(self._gamestate_filter.waiting_for_players) then
		return
	end
	game_state_machine:current_state():sync_start(variant, soundtrack)
end
function UnitNetworkHandler:sync_waiting_for_player_skip()
	if not self._verify_gamestate(self._gamestate_filter.waiting_for_players) then
		return
	end
	game_state_machine:current_state():sync_skip()
end
function UnitNetworkHandler:criminal_hurt(criminal_unit, attacker_unit, damage_ratio, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(criminal_unit, sender) then
		return
	end
	if not alive(attacker_unit) or criminal_unit:key() == attacker_unit:key() then
		attacker_unit = nil
	end
	managers.hud:set_mugshot_damage_taken(criminal_unit:unit_data().mugshot_id)
	managers.groupai:state():criminal_hurt_drama(criminal_unit, attacker_unit, damage_ratio * 0.01)
end
function UnitNetworkHandler:arrested(unit)
	if not alive(unit) then
		return
	end
	unit:movement():sync_arrested()
end
function UnitNetworkHandler:suspect_uncovered(enemy_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local suspect_member = managers.network:session():local_peer()
	local suspect_unit = suspect_member and suspect_member:unit()
	if not suspect_unit then
		return
	end
	suspect_unit:movement():on_uncovered(enemy_unit)
end
function UnitNetworkHandler:add_synced_team_upgrade(category, upgrade, level, sender)
	local sender_peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not sender_peer then
		return
	end
	local peer_id = sender_peer:id()
	managers.player:add_synced_team_upgrade(peer_id, category, upgrade, level)
end
function UnitNetworkHandler:sync_deployable_equipment(deployable, amount, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.player:set_synced_deployable_equipment(peer, deployable, amount)
end
function UnitNetworkHandler:sync_cable_ties(amount, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.player:set_synced_cable_ties(peer:id(), amount)
end
function UnitNetworkHandler:sync_grenades(grenade, amount, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.player:set_synced_grenades(peer:id(), grenade, amount)
end
function UnitNetworkHandler:sync_ammo_amount(selection_index, max_clip, current_clip, current_left, max, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.player:set_synced_ammo_info(peer:id(), selection_index, max_clip, current_clip, current_left, max)
end
function UnitNetworkHandler:sync_bipod(bipod_pos, body_pos, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.player:set_synced_bipod(peer, bipod_pos, body_pos)
end
function UnitNetworkHandler:sync_carry(carry_id, multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.player:set_synced_carry(peer, carry_id, multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
end
function UnitNetworkHandler:sync_remove_carry(sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.player:remove_synced_carry(peer)
end
function UnitNetworkHandler:server_drop_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, dir, throw_distance_multiplier_upgrade_level, zipline_unit, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.player:server_drop_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer)
end
function UnitNetworkHandler:sync_carry_data(unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer_id, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:verify_carry(managers.network:session():peer(peer_id), carry_id)
	managers.player:sync_carry_data(unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer_id)
end
function UnitNetworkHandler:request_throw_projectile(projectile_type, position, dir, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	local peer_id = peer:id()
	local projectile_entry = tweak_data.blackmarket:get_projectile_name_from_index(projectile_type)
	local no_cheat_count = tweak_data.blackmarket.projectiles[projectile_entry].no_cheat_count
	if not no_cheat_count and not managers.player:verify_grenade(peer_id) then
		return
	end
	ProjectileBase.throw_projectile(projectile_type, position, dir, peer_id)
end
function UnitNetworkHandler:sync_throw_projectile(unit, pos, dir, projectile_type, peer_id, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		print("_verify failed!!!")
		return
	end
	local projectile_entry = tweak_data.blackmarket:get_projectile_name_from_index(projectile_type)
	local tweak_entry = tweak_data.blackmarket.projectiles[projectile_entry]
	if tweak_entry.client_authoritative then
		if not unit then
			local unit_name = Idstring(tweak_entry.local_unit)
			unit = World:spawn_unit(unit_name, pos, Rotation(dir, math.UP))
		end
		unit:base():set_owner_peer_id(peer_id)
	end
	if not alive(unit) then
		print("unit is not alive!!!")
		return
	end
	local server_peer = managers.network:session():server_peer()
	if tweak_entry.throwable and not peer == server_peer then
		print("projectile is throwable, should not be thrown by client!!!")
		return
	end
	local no_cheat_count = tweak_entry.no_cheat_count
	if not no_cheat_count then
		managers.player:verify_grenade(peer_id)
	end
	local member = managers.network:session():peer(peer_id)
	local thrower_unit = member and member:unit()
	unit:base():set_thrower_unit(thrower_unit)
	if not tweak_entry.throwable and thrower_unit:movement() and thrower_unit:movement():current_state() then
		unit:base():set_weapon_unit(thrower_unit:movement():current_state()._equipped_unit)
	end
	unit:base():sync_throw_projectile(dir, projectile_type)
end
function UnitNetworkHandler:sync_attach_projectile(unit, instant_dynamic_pickup, parent_unit, parent_body, parent_object, local_pos, dir, projectile_type, peer_id, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		print("_verify failed!!!")
		return
	end
	local world_position = parent_object and local_pos:rotate_with(parent_object:rotation()) + parent_object:position() or local_pos
	if Network:is_server() then
		local projectile_entry = tweak_data.blackmarket:get_projectile_name_from_index(projectile_type)
		local tweak_entry = tweak_data.blackmarket.projectiles[projectile_entry]
		local unit_name = Idstring(tweak_entry.unit)
		local synced_unit = World:spawn_unit(unit_name, world_position, Rotation(dir, math.UP))
		managers.network:session():send_to_peers_synched("sync_attach_projectile", synced_unit, instant_dynamic_pickup, alive(parent_unit) and parent_unit:id() ~= -1 and parent_unit or nil, alive(parent_unit) and parent_unit:id() ~= -1 and parent_body or nil, alive(parent_unit) and parent_unit:id() ~= -1 and parent_object or nil, local_pos, dir, projectile_type, peer_id)
		synced_unit:base():set_thrower_unit_by_peer_id(peer_id)
		synced_unit:base():sync_attach_to_unit(instant_dynamic_pickup, parent_unit, parent_body, parent_object, local_pos, dir)
	elseif unit then
		unit:set_position(world_position)
		unit:base():set_thrower_unit_by_peer_id(peer_id)
		unit:base():sync_attach_to_unit(instant_dynamic_pickup, parent_unit, parent_body, parent_object, local_pos, dir)
	end
	if peer_id ~= 1 then
		local dummy_unit = ArrowBase.find_nearest_arrow(peer_id, world_position)
		if dummy_unit then
			dummy_unit:set_slot(0)
		end
	end
end
function UnitNetworkHandler:sync_detonate_molotov_grenade(unit, ext_name, event_id, normal, rpc)
	local peer = self._verify_sender(rpc)
	if not peer or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local extension = unit[ext_name](unit)
	if not extension then
		debug_pause("[UnitNetworkHandler:sync_detonate_molotov_grenade] unit", unit, "does not have extension", ext_name)
		return
	end
	extension:sync_detonate_molotov_grenade(event_id, normal, peer)
end
function UnitNetworkHandler:sync_add_doted_enemy(enemy_unit, fire_damage_received_time, weapon_unit, dot_length, dot_damage, rpc)
	local peer = self._verify_sender(rpc)
	managers.fire:sync_add_fire_dot(enemy_unit, fire_damage_received_time, weapon_unit, dot_length, dot_damage, peer)
end
function UnitNetworkHandler:server_secure_loot(carry_id, multiplier_level, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.loot:server_secure_loot(carry_id, multiplier_level)
end
function UnitNetworkHandler:sync_secure_loot(carry_id, multiplier_level, silent, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) and not self._verify_gamestate(self._gamestate_filter.any_end_game) or not self._verify_sender(sender) then
		return
	end
	managers.loot:sync_secure_loot(carry_id, multiplier_level, silent)
end
function UnitNetworkHandler:sync_small_loot_taken(unit, multiplier_level, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:base():taken(multiplier_level)
end
function UnitNetworkHandler:server_unlock_asset(asset_id, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.assets:server_unlock_asset(asset_id, peer)
end
function UnitNetworkHandler:sync_unlock_asset(asset_id, unlocker_peer_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local peer = managers.network:session():peer(unlocker_peer_id)
	managers.assets:sync_unlock_asset(asset_id, peer)
end
function UnitNetworkHandler:sync_heist_time(time, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.game_play_central:sync_heist_time(time)
end
function UnitNetworkHandler:run_mission_door_sequence(unit, sequence_name, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:base():run_sequence_simple(sequence_name)
end
function UnitNetworkHandler:set_mission_door_device_powered(unit, powered, interaction_enabled, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	MissionDoor.set_mission_door_device_powered(unit, powered, interaction_enabled)
end
function UnitNetworkHandler:run_mission_door_device_sequence(unit, sequence_name, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	MissionDoor.run_mission_door_device_sequence(unit, sequence_name)
end
function UnitNetworkHandler:server_place_mission_door_device(unit, player, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local result = unit:interaction():server_place_mission_door_device(player, sender)
end
function UnitNetworkHandler:result_place_mission_door_device(unit, result, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	unit:interaction():result_place_mission_door_device(result)
end
function UnitNetworkHandler:set_armor(unit, percent, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local peer = self._verify_sender(sender)
	local peer_id = peer:id()
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		managers.hud:set_teammate_armor(character_data.panel_id, {
			current = percent / 100,
			total = 1,
			max = 1
		})
	else
		managers.hud:set_mugshot_armor(unit:unit_data().mugshot_id, percent / 100)
	end
end
function UnitNetworkHandler:set_health(unit, percent, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local peer = self._verify_sender(sender)
	local peer_id = peer:id()
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		managers.hud:set_teammate_health(character_data.panel_id, {
			current = percent / 100,
			total = 1,
			max = 1
		})
	else
		managers.hud:set_mugshot_health(unit:unit_data().mugshot_id, percent / 100)
	end
	if percent ~= 100 then
		managers.mission:call_global_event("player_damaged")
	end
end
function UnitNetworkHandler:sync_equipment_possession(peer_id, equipment, amount, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:set_synced_equipment_possession(peer_id, equipment, amount)
end
function UnitNetworkHandler:sync_remove_equipment_possession(peer_id, equipment, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local equipment_peer = managers.network:session():peer(peer_id)
	if not equipment_peer then
		print("[UnitNetworkHandler:sync_remove_equipment_possession] unknown peer", peer_id)
		return
	end
	managers.player:remove_equipment_possession(peer_id, equipment)
end
function UnitNetworkHandler:sync_start_anticipation()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_start_anticipation()
end
function UnitNetworkHandler:sync_start_anticipation_music()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_start_anticipation_music()
end
function UnitNetworkHandler:sync_start_assault()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_start_assault()
end
function UnitNetworkHandler:sync_end_assault(result)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_end_assault(result)
end
function UnitNetworkHandler:sync_assault_dialog(index)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_assault_dialog(index)
end
function UnitNetworkHandler:sync_contour_state(unit, u_id, type, state, multiplier, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local contour_unit
	if alive(unit) and unit:id() ~= -1 then
		contour_unit = unit
	else
		local unit_data = managers.enemy:get_corpse_unit_data_from_id(u_id)
		if unit_data then
			contour_unit = unit_data.unit
		end
	end
	if not contour_unit then
		Application:error("[UnitNetworkHandler:sync_contour_state] Unit is missing")
		return
	end
	if state then
		contour_unit:contour():add(ContourExt.indexed_types[type], false, multiplier)
	else
		contour_unit:contour():remove(ContourExt.indexed_types[type], nil)
	end
end
function UnitNetworkHandler:mark_minion(unit, minion_owner_peer_id, convert_enemies_health_multiplier_level, passive_convert_enemies_health_multiplier_level, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	local health_multiplier = 1
	if convert_enemies_health_multiplier_level > 0 then
		health_multiplier = health_multiplier * tweak_data.upgrades.values.player.convert_enemies_health_multiplier[convert_enemies_health_multiplier_level]
	end
	if passive_convert_enemies_health_multiplier_level > 0 then
		health_multiplier = health_multiplier * tweak_data.upgrades.values.player.passive_convert_enemies_health_multiplier[passive_convert_enemies_health_multiplier_level]
	end
	unit:character_damage():convert_to_criminal(health_multiplier)
	unit:contour():add("friendly", false)
	managers.groupai:state():sync_converted_enemy(unit)
	if minion_owner_peer_id == managers.network:session():local_peer():id() then
		managers.player:count_up_player_minions()
	end
end
function UnitNetworkHandler:count_down_player_minions()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.player:count_down_player_minions()
end
function UnitNetworkHandler:sync_teammate_helped_hint(hint, helped_unit, helping_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(helped_unit, sender) or not self._verify_character(helping_unit, sender) then
		return
	end
	managers.trade:sync_teammate_helped_hint(helped_unit, helping_unit, hint)
end
function UnitNetworkHandler:sync_assault_mode(enabled)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_assault_mode(enabled)
end
function UnitNetworkHandler:sync_hostage_killed_warning(warning)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_hostage_killed_warning(warning)
end
function UnitNetworkHandler:set_interaction_voice(unit, voice, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:brain():set_interaction_voice(voice ~= "" and voice or nil)
end
function UnitNetworkHandler:sync_teammate_comment(message, pos, pos_based, radius, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.groupai:state():sync_teammate_comment(message, pos, pos_based, radius)
end
function UnitNetworkHandler:sync_teammate_comment_instigator(unit, message)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.groupai:state():sync_teammate_comment_instigator(unit, message)
end
function UnitNetworkHandler:begin_gameover_fadeout()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():begin_gameover_fadeout()
end
function UnitNetworkHandler:send_statistics(total_kills, total_specials_kills, total_head_shots, accuracy, downs, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_end_game) then
		return
	end
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	managers.network:session():on_statistics_recieved(peer:id(), total_kills, total_specials_kills, total_head_shots, accuracy, downs)
end
function UnitNetworkHandler:sync_statistics_result(...)
	if game_state_machine:current_state().on_statistics_result then
		game_state_machine:current_state():on_statistics_result(...)
	end
end
function UnitNetworkHandler:statistics_tied(name, sender)
	if not self._verify_sender(sender) then
		return
	end
	managers.statistics:tied({name = name})
end
function UnitNetworkHandler:bain_comment(bain_line, sender)
	if not self._verify_sender(sender) then
		return
	end
	if managers.dialog and managers.groupai and managers.groupai:state():bain_state() then
		managers.dialog:queue_dialog(bain_line, {})
	end
end
function UnitNetworkHandler:is_inside_point_of_no_return(is_inside, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	managers.groupai:state():set_is_inside_point_of_no_return(peer:id(), is_inside)
end
function UnitNetworkHandler:mission_ended(win, num_is_inside, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if managers.platform:presence() == "Playing" then
		if win then
			game_state_machine:change_state_by_name("victoryscreen", {
				num_winners = num_is_inside,
				personal_win = not managers.groupai:state()._failed_point_of_no_return and alive(managers.player:player_unit())
			})
		else
			game_state_machine:change_state_by_name("gameoverscreen")
		end
	end
end
function UnitNetworkHandler:sync_level_up(level, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	peer:set_level(level)
end
function UnitNetworkHandler:sync_disable_shout(unit, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	ElementDisableShout.sync_function(unit, state)
end
function UnitNetworkHandler:sync_run_sequence_char(unit, seq, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	ElementSequenceCharacter.sync_function(unit, seq)
end
function UnitNetworkHandler:sync_player_kill_statistic(tweak_table_name, is_headshot, weapon_unit, variant, stats_name, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) or not alive(weapon_unit) then
		return
	end
	local data = {
		name = tweak_table_name,
		stats_name = stats_name,
		head_shot = is_headshot,
		weapon_unit = weapon_unit,
		variant = variant
	}
	managers.statistics:killed_by_anyone(data)
	local attacker_state = managers.player:current_state()
	data.attacker_state = attacker_state
	managers.statistics:killed(data)
end
function UnitNetworkHandler:set_attention_enabled(unit, setting_index, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	if unit:in_slot(managers.slot:get_mask("players")) and unit:base().is_husk_player then
		local setting_name = tweak_data.attention:get_attention_name(setting_index)
		unit:movement():sync_attention_setting(setting_name, state, false)
	else
		debug_pause_unit(unit, "[UnitNetworkHandler:set_attention_enabled] invalid unit", unit)
	end
end
function UnitNetworkHandler:link_attention_no_rot(parent_unit, attention_object, parent_object, local_pos, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not alive(parent_unit) or not alive(attention_object) then
		return
	end
	attention_object:attention():link(parent_unit, parent_object, local_pos)
end
function UnitNetworkHandler:unlink_attention(attention_object, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not alive(attention_object) then
		return
	end
	attention_object:attention():link(nil)
end
function UnitNetworkHandler:suspicion(suspect_peer_id, susp_value, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local suspect_member = managers.network:session():peer(suspect_peer_id)
	if not suspect_member then
		return
	end
	local suspect_unit = suspect_member:unit()
	if not suspect_unit then
		return
	end
	if susp_value == 0 then
		susp_value = false
	elseif susp_value == 255 then
		susp_value = true
	else
		susp_value = susp_value / 254
	end
	suspect_unit:movement():on_suspicion(nil, susp_value)
end
function UnitNetworkHandler:suspicion_hud(observer_unit, status)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not alive(observer_unit) then
		return
	end
	if status == 0 then
		status = false
	elseif status == 1 then
		status = 1
	elseif status == 2 then
		status = true
	elseif status == 3 then
		status = "calling"
	elseif status == 4 then
		status = "called"
	elseif status == 5 then
		status = "call_interrupted"
	end
	managers.groupai:state():on_criminal_suspicion_progress(nil, observer_unit, status)
end
function UnitNetworkHandler:group_ai_event(event_id, blame_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_event(event_id, blame_id)
end
function UnitNetworkHandler:start_timespeed_effect(effect_id, timer_name, affect_timer_names_str, speed, fade_in, sustain, fade_out, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local affect_timer_names
	if affect_timer_names_str ~= "" then
		affect_timer_names = string.split(affect_timer_names_str, ";")
	end
	local effect_desc = {
		timer = timer_name,
		affect_timer = affect_timer_names,
		speed = speed,
		fade_in = fade_in,
		sustain = sustain,
		fade_out = fade_out
	}
	managers.time_speed:play_effect(effect_id, effect_desc)
end
function UnitNetworkHandler:stop_timespeed_effect(effect_id, fade_out_duration, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.time_speed:stop_effect(effect_id, fade_out_duration)
end
function UnitNetworkHandler:sync_upgrade(upgrade_category, upgrade_name, upgrade_level, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		print("[UnitNetworkHandler:sync_upgrade] missing peer", upgrade_category, upgrade_name, upgrade_level, sender:ip_at_index(0))
		return
	end
	local function _get_unit()
		local unit = peer:unit()
		if not unit then
			print("[UnitNetworkHandler:sync_upgrade] missing unit", upgrade_category, upgrade_name, upgrade_level, sender:ip_at_index(0))
		end
		return unit
	end
	local unit = _get_unit()
	if not unit then
		return
	end
	unit:base():set_upgrade_value(upgrade_category, upgrade_name, upgrade_level)
end
function UnitNetworkHandler:suppression(unit, ratio, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	local sup_tweak = unit:base():char_tweak().suppression
	if not sup_tweak then
		debug_pause_unit(unit, "[UnitNetworkHandler:suppression] husk missing suppression settings", unit)
		return
	end
	local amount_max = sup_tweak.brown_point or sup_tweak.react_point[2]
	local amount, panic_chance
	if ratio == 16 then
		amount = "max"
		panic_chance = -1
	elseif ratio == 15 then
		amount = "max"
	else
		amount = amount_max > 0 and amount_max * ratio / 15 or "max"
	end
	unit:character_damage():build_suppression(amount, panic_chance)
end
function UnitNetworkHandler:suppressed_state(unit, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():on_suppressed(state)
end
function UnitNetworkHandler:camera_yaw_pitch(cam_unit, yaw_255, pitch_255)
	if not alive(cam_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local yaw = 360 * yaw_255 / 255 - 180
	local pitch = 180 * pitch_255 / 255 - 90
	cam_unit:base():apply_rotations(yaw, pitch)
end
function UnitNetworkHandler:loot_link(loot_unit, parent_unit, sender)
	if not alive(loot_unit) or not alive(parent_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if loot_unit == parent_unit then
		loot_unit:carry_data():unlink()
	else
		loot_unit:carry_data():link_to(parent_unit)
	end
end
function UnitNetworkHandler:remove_unit(unit, sender)
	if not alive(unit) then
		return
	end
	if unit:id() ~= -1 then
		Network:detach_unit(unit)
	end
	unit:set_slot(0)
end
function UnitNetworkHandler:sync_gui_net_event(unit, event_id, value, sender)
	if not alive(unit) or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:digital_gui():sync_gui_net_event(event_id, value)
end
function UnitNetworkHandler:sync_proximity_activation(unit, proximity_name, range_data_string, sender)
	if not alive(unit) or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:damage():sync_proximity_activation(proximity_name, range_data_string)
end
function UnitNetworkHandler:sync_inflict_body_damage(body, unit, normal, position, direction, damage, velocity, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_inflict_body_damage] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_inflict_body_damage] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_fire then
		print("[UnitNetworkHandler:sync_inflict_body_damage] body has no damage damage_bullet function", body:name(), body:unit():name())
		return
	end
	body:extension().damage:damage_fire(unit, normal, position, direction, damage, velocity)
end
function UnitNetworkHandler:sync_team_relation(team_index_1, team_index_2, relation_code)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local team_id_1 = tweak_data.levels:get_team_names_indexed()[team_index_1]
	local team_id_2 = tweak_data.levels:get_team_names_indexed()[team_index_2]
	local relation = relation_code == 1 and "neutral" or relation_code == 2 and "friend" or "foe"
	if not team_id_1 or not team_id_2 or relation_code < 1 or relation_code > 3 then
		debug_pause("[UnitNetworkHandler:sync_team_relation] invalid params", team_index_1, team_index_2, relation_code, Global.level_data.level_id)
		return
	end
	managers.groupai:state():set_team_relation(team_id_1, team_id_2, relation, nil)
end
function UnitNetworkHandler:sync_char_team(unit, team_index, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not self._verify_character(unit) then
		return
	end
	local team_id = tweak_data.levels:get_team_names_indexed()[team_index]
	local team_data = managers.groupai:state():team_data(team_id)
	unit:movement():set_team(team_data)
end
function UnitNetworkHandler:sync_vehicle_driving(action, unit, player)
	Application:debug("[DRIVING_NET] sync_vehicle_driving " .. action)
	if not alive(unit) then
		return
	end
	local ext = unit:npc_vehicle_driving()
	ext = ext or unit:vehicle_driving()
	if action == "start" then
		ext:sync_start(player)
	elseif action == "stop" then
		ext:sync_stop()
	end
end
function UnitNetworkHandler:sync_vehicle_set_input(unit, accelerate, steer, brake, handbrake, gear_up, gear_down, forced_gear)
	if not alive(unit) then
		return
	end
	unit:vehicle_driving():sync_set_input(accelerate, steer, brake, handbrake, gear_up, gear_down, forced_gear)
end
function UnitNetworkHandler:sync_vehicle_state(unit, position, rotation, velocity)
	if not alive(unit) then
		return
	end
	unit:vehicle_driving():sync_state(position, rotation, velocity)
end
function UnitNetworkHandler:sync_enter_vehicle_host(vehicle, seat_name, peer_id, player)
	Application:debug("[DRIVING_NET] sync_enter_vehicle_host", seat_name)
	if not alive(vehicle) then
		return
	end
	managers.player:server_enter_vehicle(vehicle, peer_id, player, seat_name)
end
function UnitNetworkHandler:sync_vehicle_player(action, vehicle, peer_id, player, seat_name)
	Application:debug("[DRIVING_NET] sync_vehicle_player " .. action)
	if action == "enter" then
		managers.player:sync_enter_vehicle(vehicle, peer_id, player, seat_name)
	elseif action == "exit" then
		managers.player:sync_exit_vehicle(peer_id, player)
	end
end
function UnitNetworkHandler:sync_vehicle_data(vehicle, state_name, occupant_driver, occupant_left, occupant_back_left, occupant_back_right, is_trunk_open)
	Application:debug("[DRIVING_NET] sync_vehicles_data")
	if not alive(vehicle) then
		return
	end
	managers.vehicle:sync_vehicle_data(vehicle, state_name, occupant_driver, occupant_left, occupant_back_left, occupant_back_right, is_trunk_open)
end
function UnitNetworkHandler:sync_npc_vehicle_data(vehicle, state_name, target_unit)
	Application:debug("[DRIVING_NET] sync_npc_vehicle_data", vehicle, state_name)
	if not alive(vehicle) then
		return
	end
	managers.vehicle:sync_npc_vehicle_data(vehicle, state_name, target_unit)
end
function UnitNetworkHandler:sync_vehicle_loot(vehicle, carry_id1, multiplier1, carry_id2, multiplier2, carry_id3, multiplier3)
	Application:debug("[DRIVING_NET] sync_vehicle_loot")
	if not alive(vehicle) then
		return
	end
	managers.vehicle:sync_vehicle_loot(vehicle, carry_id1, multiplier1, carry_id2, multiplier2, carry_id3, multiplier3)
end
function UnitNetworkHandler:sync_ai_vehicle_action(action, vehicle, data, unit)
	Application:debug("[DRIVING_NET] sync_ai_vehicle_action: ", action, data)
	if not alive(vehicle) then
		return
	end
	if action == "health" then
		vehicle:character_damage():sync_vehicle_health(data)
	elseif action == "revive" then
		vehicle:character_damage():sync_vehicle_revive(data)
	elseif action == "state" then
		vehicle:vehicle_driving():sync_vehicle_state(data)
	else
		if not alive(unit) then
			return
		end
		vehicle:vehicle_driving():sync_ai_vehicle_action(action, data, unit)
	end
end
function UnitNetworkHandler:server_store_loot_in_vehicle(vehicle, loot_bag)
	Application:debug("[DRIVING_NET] server_store_loot_in_vehicle")
	if not alive(vehicle) or not alive(loot_bag) then
		return
	end
	vehicle:vehicle_driving():server_store_loot_in_vehicle(loot_bag)
end
function UnitNetworkHandler:sync_vehicle_change_stance(shooting_unit, stance)
	Application:debug("[DRIVING_NET] sync_vehicle_change_stance")
	if not alive(shooting_unit) then
		return
	end
	shooting_unit:movement():sync_vehicle_change_stance(stance)
end
function UnitNetworkHandler:sync_store_loot_in_vehicle(vehicle, loot_bag, carry_id, multiplier)
	Application:debug("[DRIVING_NET] sync_store_loot_in_vehicle")
	if not alive(vehicle) or not alive(loot_bag) then
		return
	end
	vehicle:vehicle_driving():sync_store_loot_in_vehicle(loot_bag, carry_id, multiplier)
end
function UnitNetworkHandler:server_give_vehicle_loot_to_player(vehicle, peer_id)
	Application:debug("[DRIVING_NET] server_give_vehicle_loot_to_player")
	vehicle:vehicle_driving():server_give_vehicle_loot_to_player(peer_id)
end
function UnitNetworkHandler:sync_give_vehicle_loot_to_player(vehicle, carry_id, multiplier, peer_id)
	Application:debug("[DRIVING_NET] sync_give_vehicle_loot_to_player")
	vehicle:vehicle_driving():sync_give_vehicle_loot_to_player(carry_id, multiplier, peer_id)
end
function UnitNetworkHandler:sync_vehicle_interact_trunk(vehicle, peer_id)
	Application:debug("[DRIVING_NET] sync_vehicle_interact_trunk")
	vehicle:vehicle_driving():_interact_trunk(vehicle)
end
function UnitNetworkHandler:sync_damage_reduction_buff(damage_reduction)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not damage_reduction then
		debug_pause("[UnitNetworkHandler:sync_damage_reduction_buff] invalid params", damage_reduction)
		return
	end
	managers.groupai:state():set_phalanx_damage_reduction_buff(damage_reduction)
end
function UnitNetworkHandler:sync_assault_endless(enabled)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():set_assault_endless(enabled)
end
function UnitNetworkHandler:action_jump(unit, pos, jump_vec, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(unit) then
		return
	end
	unit:movement():sync_action_jump(pos, jump_vec)
end
function UnitNetworkHandler:action_jump_middle(unit, pos, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(unit) then
		return
	end
	unit:movement():sync_action_jump_middle(pos)
end
function UnitNetworkHandler:action_land(unit, pos, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(unit) then
		return
	end
	unit:movement():sync_action_land(pos)
end
function UnitNetworkHandler:sync_fall_position(unit, pos, rot)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if alive(unit) then
		unit:movement():sync_fall_position(pos, rot)
	end
end
