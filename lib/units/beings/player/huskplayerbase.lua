require("lib/units/enemies/cop/CopBase")
HuskPlayerBase = HuskPlayerBase or class(PlayerBase)
HuskPlayerBase.set_anim_lod = CopBase.set_anim_lod
HuskPlayerBase.set_visibility_state = CopBase.set_visibility_state
HuskPlayerBase._anim_lods = CopBase._anim_lods
function HuskPlayerBase:init(unit)
	UnitBase.init(self, unit, false)
	self._unit = unit
	self._upgrades = {}
	self._upgrade_levels = {}
	self:_setup_suspicion_and_detection_data()
end
function HuskPlayerBase:post_init()
	self._ext_anim = self._unit:anim_data()
	self._unit:movement():post_init()
	managers.groupai:state():register_criminal(self._unit)
	managers.occlusion:remove_occlusion(self._unit)
	self:set_anim_lod(1)
	self._lod_stage = 1
	self._allow_invisible = true
	local spawn_state = self._spawn_state or "std/stand/still/idle/look"
	self._unit:movement():play_state(spawn_state)
end
function HuskPlayerBase:set_upgrade_value(category, upgrade, level)
	self._upgrades[category] = self._upgrades[category] or {}
	self._upgrade_levels[category] = self._upgrade_levels[category] or {}
	local value = managers.player:upgrade_value_by_level(category, upgrade, level)
	self._upgrades[category][upgrade] = value
	self._upgrade_levels[category][upgrade] = level
	if upgrade == "passive_concealment_modifier" then
		local con_mul, index = managers.blackmarket:get_concealment_of_peer(managers.network:session():peer_by_unit(self._unit))
		self:set_suspicion_multiplier("equipment", 1 / con_mul)
		self:set_detection_multiplier("equipment", 1 / con_mul)
	elseif upgrade == "suspicion_multiplier" then
		self:set_suspicion_multiplier(upgrade, value)
	end
end
function HuskPlayerBase:upgrade_value(category, upgrade)
	return self._upgrades[category] and self._upgrades[category][upgrade]
end
function HuskPlayerBase:upgrade_level(category, upgrade)
	return self._upgrade_levels[category] and self._upgrade_levels[category][upgrade]
end
function HuskPlayerBase:pre_destroy(unit)
	self._unit:movement():pre_destroy(unit)
	self._unit:inventory():pre_destroy(self._unit)
	managers.groupai:state():unregister_criminal(self._unit)
	if managers.network:session() then
		local peer = managers.network:session():peer_by_unit(self._unit)
		if peer then
			peer:set_unit(nil)
		end
	end
	UnitBase.pre_destroy(self, unit)
end
function HuskPlayerBase:nick_name()
	local peer = managers.network:session():peer_by_unit(self._unit)
	return peer and peer:name() or ""
end
function HuskPlayerBase:on_death_exit()
end
function HuskPlayerBase:chk_freeze_anims()
end