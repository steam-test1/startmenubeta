LootDropManager = LootDropManager or class()
function LootDropManager:init()
	self:_setup()
end
function LootDropManager:_setup()
	self:add_qlvl_to_weapon_mods()
	if not Global.lootdrop_manager then
		Global.lootdrop_manager = {}
		self:_setup_items()
	end
	self._global = Global.lootdrop_manager
end
function LootDropManager:add_qlvl_to_weapon_mods(override_tweak_data)
	local weapon_mods_tweak_data = override_tweak_data or tweak_data.blackmarket.weapon_mods
	local weapons_data = {}
	for weapon_id, data in pairs(Global.blackmarket_manager.weapons) do
		weapons_data[data.factory_id] = data.level
	end
	for part_id, data in pairs(tweak_data.weapon.factory.parts) do
		local weapon_uses_part = managers.weapon_factory:get_weapons_uses_part(part_id) or {}
		local min_level = managers.experience:level_cap()
		for _, factory_id in ipairs(weapon_uses_part) do
			if not table.contains(tweak_data.weapon.factory[factory_id].default_blueprint, part_id) then
				min_level = math.min(min_level, weapons_data[factory_id] or 0)
			end
		end
		weapon_mods_tweak_data[part_id].qlvl = min_level
	end
end
function LootDropManager:_setup_items()
	local pc_items = {}
	Global.lootdrop_manager.pc_items = pc_items
	local function sort_pc(type, data)
		for id, item_data in pairs(data) do
			local dlcs = item_data.dlcs or {}
			local dlc = item_data.dlc
			if dlc then
				table.insert(dlcs, dlc)
			end
			local has_dlc = #dlcs == 0
			for _, dlc in pairs(dlcs) do
				has_dlc = has_dlc or managers.dlc:is_dlc_unlocked(dlc)
			end
			if has_dlc then
				if item_data.pc then
					pc_items[item_data.pc] = pc_items[item_data.pc] or {}
					pc_items[item_data.pc][type] = pc_items[item_data.pc][type] or {}
					table.insert(pc_items[item_data.pc][type], id)
				end
				if item_data.pcs then
					for _, pc in ipairs(item_data.pcs) do
						pc_items[pc] = pc_items[pc] or {}
						pc_items[pc][type] = pc_items[pc][type] or {}
						table.insert(pc_items[pc][type], id)
					end
				end
			end
		end
	end
	for type, data in pairs(tweak_data.blackmarket) do
		sort_pc(type, data)
	end
end
function LootDropManager:new_debug_drop(amount, add_to_inventory, stars)
	amount = amount or 10
	add_to_inventory = add_to_inventory or false
	local debug_infamous = 0
	local debug_max_pc = 0
	if stars == "random" then
	else
		stars = stars or 5
	end
	self._debug_drop_result = {}
	for i = 1, amount do
		local s = stars == "random" and math.random(10) or stars
		local global_value, category, id, pc = self:_new_make_drop(true, add_to_inventory, s)
		self._debug_drop_result[global_value] = self._debug_drop_result[global_value] or {}
		self._debug_drop_result[global_value][category] = self._debug_drop_result[global_value][category] or {}
		self._debug_drop_result[global_value][category][id] = (self._debug_drop_result[global_value][category][id] or 0) + 1
		if global_value == "infamous" then
			debug_infamous = debug_infamous + 1
		end
		if pc == tweak_data.lootdrop.STARS[s].pcs[1] then
			debug_max_pc = debug_max_pc + 1
		end
	end
	if stars ~= "random" then
		Application:debug(debug_max_pc .. " dropped at PC " .. stars, "infamous items dropped: " .. debug_infamous)
	end
	Global.debug_drop_result = self._debug_drop_result
end
function LootDropManager:droppable_items(item_pc, infamous_success, skip_types)
