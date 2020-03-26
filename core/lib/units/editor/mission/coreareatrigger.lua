core:import("CoreShapeManager")
CoreAreaTriggerUnitElement = CoreAreaTriggerUnitElement or class(MissionElement)
AreaTriggerUnitElement = AreaTriggerUnitElement or class(CoreAreaTriggerUnitElement)
function AreaTriggerUnitElement:init(...)
	CoreAreaTriggerUnitElement.init(self, ...)
end
function CoreAreaTriggerUnitElement:init(unit)
	MissionElement.init(self, unit)
	self._timeline_color = Vector3(1, 1, 0)
	self._brush = Draw:brush()
	self._hed.trigger_times = 1
	self._hed.interval = 0.1
	self._hed.trigger_on = "on_enter"
	self._hed.instigator = managers.mission:default_area_instigator()
	self._hed.shape_type = "box"
	self._hed.width = 500
	self._hed.depth = 500
	self._hed.height = 500
	self._hed.radius = 250
	self._hed.spawn_unit_elements = {}
	self._hed.amount = "1"
	self._hed.use_shape_element_ids = nil
	self._hed.use_disabled_shapes = false
	self._hed.rules_element_ids = nil
	self._hed.unit_ids = nil
	table.insert(self._save_values, "interval")
	table.insert(self._save_values, "trigger_on")
	table.insert(self._save_values, "instigator")
	table.insert(self._save_values, "shape_type")
	table.insert(self._save_values, "width")
	table.insert(self._save_values, "depth")
	table.insert(self._save_values, "height")
	table.insert(self._save_values, "radius")
	table.insert(self._save_values, "spawn_unit_elements")
	table.insert(self._save_values, "amount")
	table.insert(self._save_values, "use_shape_element_ids")
	table.insert(self._save_values, "use_disabled_shapes")
	table.insert(self._save_values, "rules_element_ids")
	table.insert(self._save_values, "unit_ids")
end
function CoreAreaTriggerUnitElement:draw_links(t, dt, selected_unit, all_units)
	MissionElement.draw_links(self, t, dt, selected_unit, all_units)
	for _, id in ipairs(self._hed.spawn_unit_elements) do
		local unit = all_units[id]
		if self:_should_draw_link(selected_unit, unit) then
			self:_draw_link({
				from_unit = self._unit,
				to_unit = unit,
				r = 0.75,
				g = 0,
				b = 0
			})
		end
	end
	if self._hed.unit_ids then
		for _, id in ipairs(self._hed.unit_ids) do
			local unit = managers.editor:layer("Statics"):created_units_pairs()[id]
			if alive(unit) then
				if self:_should_draw_link(selected_unit, unit) then
					self:_draw_link({
						from_unit = unit,
						to_unit = self._unit,
						r = 0,
						g = 0.5,
						b = 0.75
					})
					Application:draw(unit, 0, 0.5, 0.75)
				end
			else
				self:_remove_unit_id(id)
			end
		end
	end
	self:_check_removed_units(all_units)
	if self._hed.use_shape_element_ids then
		for _, id in ipairs(self._hed.use_shape_element_ids) do
			local unit = all_units[id]
			if self:_should_draw_link(selected_unit, unit) then
				local r, g, b = unit:mission_element():get_link_color()
				self:_draw_link({
					from_unit = unit,
					to_unit = self._unit,
					r = r,
					g = g,
					b = b
				})
			end
		end
	end
	if self._hed.rules_element_ids then
		for _, id in ipairs(self._hed.rules_element_ids) do
			local unit = all_units[id]
			if self:_should_draw_link(selected_unit, unit) then
				local r, g, b = unit:mission_element():get_link_color()
				self:_draw_link({
					from_unit = unit,
					to_unit = self._unit,
					r = r,
					g = g,
					b = b
				})
			end
		end
	end
end
function CoreAreaTriggerUnitElement:_check_removed_units(all_units)
	if self._hed.use_shape_element_ids then
		for _, id in ipairs(clone(self._hed.use_shape_element_ids)) do
			local unit = all_units[id]
			if not alive(unit) then
				table.delete(self._hed.use_shape_element_ids, id)
			end
		end
	end
	if self._hed.rules_element_ids then
		for _, id in ipairs(clone(self._hed.rules_element_ids)) do
			local unit = all_units[id]
			if not alive(unit) then
				table.delete(self._hed.rules_element_ids, id)
			end
		end
	end
end
function CoreAreaTriggerUnitElement:update_editing()
end
function CoreAreaTriggerUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit then
		if string.find(ray.unit:name():s(), "point_spawn_unit", 1, true) then
			local id = ray.unit:unit_data().unit_id
			if table.contains(self._hed.spawn_unit_elements, id) then
				table.delete(self._hed.spawn_unit_elements, id)
			else
				table.insert(self._hed.spawn_unit_elements, id)
			end
		end
		if ray.unit:name():s() == "core/units/mission_elements/trigger_area/trigger_area" or string.find(ray.unit:name():s(), "point_shape", 1, true) then
			self._hed.use_shape_element_ids = self._hed.use_shape_element_ids or {}
			local id = ray.unit:unit_data().unit_id
			if table.contains(self._hed.use_shape_element_ids, id) then
				table.delete(self._hed.use_shape_element_ids, id)
			else
				table.insert(self._hed.use_shape_element_ids, id)
			end
			self._hed.use_shape_element_ids = #self._hed.use_shape_element_ids > 0 and self._hed.use_shape_element_ids or nil
			self:_set_shape_type()
		end
		if string.find(ray.unit:name():s(), "data_instigator_rule", 1, true) then
			self._hed.rules_element_ids = self._hed.rules_element_ids or {}
			local id = ray.unit:unit_data().unit_id
			if table.contains(self._hed.rules_element_ids, id) then
				table.delete(self._hed.rules_element_ids, id)
			else
				table.insert(self._hed.rules_element_ids, id)
			end
			self._hed.rules_element_ids = 0 < #self._hed.rules_element_ids and self._hed.rules_element_ids or nil
		end
		return
	end
	local ray = managers.editor:unit_by_raycast({
		mask = 1,
		ray_type = "body editor"
	})
	if ray and ray.unit then
		self._hed.unit_ids = self._hed.unit_ids or {}
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.unit_ids, id) then
			self:_remove_unit_id(id)
		else
			self:_add_unit_id(id)
		end
	end
end
function CoreAreaTriggerUnitElement:_add_unit_id(id)
	table.insert(self._hed.unit_ids, id)
	if self._instigator_ctrlr then
		self._instigator_ctrlr:set_enabled(not self._hed.unit_ids)
	end
end
function CoreAreaTriggerUnitElement:_remove_unit_id(id)
	table.delete(self._hed.unit_ids, id)
	self._hed.unit_ids = #self._hed.unit_ids > 0 and self._hed.unit_ids or nil
	if alive(self._instigator_ctrlr) then
		self._instigator_ctrlr:set_enabled(not self._hed.unit_ids)
	end
end
function CoreAreaTriggerUnitElement:remove_links(unit)
	for _, id in ipairs(self._hed.spawn_unit_elements) do
		if id == unit:unit_data().unit_id then
			table.delete(self._hed.spawn_unit_elements, id)
		end
	end
end
function CoreAreaTriggerUnitElement:update_selected(t, dt, selected_unit, all_units)
	if not self._hed.use_shape_element_ids then
		local shape = self:get_shape()
		if shape then
			shape:draw(t, dt, 1, 1, 1)
		end
	else
		self:_check_removed_units(all_units)
		for _, id in ipairs(self._hed.use_shape_element_ids) do
			local unit = all_units[id]
			local shape = unit:mission_element():get_shape()
			shape:draw(t, dt, 0.85, 0.85, 0.85)
		end
	end
end
function CoreAreaTriggerUnitElement:get_shape()
	if not self._shape then
		self:_create_shapes()
	end
	return self._hed.shape_type == "box" and self._shape or self._hed.shape_type == "cylinder" and self._cylinder_shape
end
function CoreAreaTriggerUnitElement:set_shape_property(params)
	self._shape:set_property(params.property, self._hed[params.value])
	self._cylinder_shape:set_property(params.property, self._hed[params.value])
end
function CoreAreaTriggerUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end
function CoreAreaTriggerUnitElement:_set_shape_type()
