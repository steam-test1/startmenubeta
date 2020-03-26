PlayerProfileGuiObject = PlayerProfileGuiObject or class()
function PlayerProfileGuiObject:init(ws)
	local panel = ws:panel():panel()
	managers.menu_component:close_contract_gui()
	local next_level_data = managers.experience:next_level_data() or {}
	local max_left_len = 0
	local max_right_len = 0
	local font = tweak_data.menu.pd2_small_font
	local font_size = tweak_data.menu.pd2_small_font_size
	local bg_ring_white = panel:bitmap({
		texture = "guis/textures/pd2/level_ring_small",
		w = font_size * 4,
		h = font_size * 4,
		x = 10,
		y = 10,
		color = Color.white,
		alpha = 0.2,
		layer = -1
	})
	local bg_ring = panel:bitmap({
		texture = "guis/textures/pd2/level_ring_small",
		w = font_size * 4,
		h = font_size * 4,
		x = 10,
		y = 10,
		color = Color.black,
		alpha = 0.4
	})
	local exp_ring = panel:bitmap({
		texture = "guis/textures/pd2/level_ring_small",
		w = font_size * 4,
		h = font_size * 4,
		x = 10,
		y = 10,
		color = Color((next_level_data.current_points or 1) / (next_level_data.points or 1), 1, 1),
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		layer = 1
	})
	local player_level = managers.experience:current_level()
	local player_rank = managers.experience:current_rank()
	local is_infamous = player_rank > 0
	local level_string = (is_infamous and managers.experience:rank_string(player_rank) .. "-" or "") .. tostring(player_level)
	local level_text = panel:text({
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size + (is_infamous and -5 or 0),
		text = level_string,
		color = tweak_data.screen_colors.text,
		align = "center",
		vertical = "center"
	})
	self:_make_fine_text(level_text)
	level_text:set_font_size(level_text:font_size() * math.min(font_size * 2 / level_text:w(), 1))
	level_text:set_center(exp_ring:center())
	max_left_len = math.max(max_left_len, level_text:w())
	local player_text = panel:text({
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		text = tostring(managers.network.account:username() or managers.blackmarket:get_preferred_character_real_name()),
		y = 10,
		color = tweak_data.screen_colors.text
	})
	self:_make_fine_text(player_text)
	player_text:set_left(math.round(exp_ring:right()))
	max_left_len = math.max(max_left_len, player_text:w())
	local money_text = panel:text({
		text = self:get_text("menu_cash", {
			money = managers.money:total_string()
		}),
		font_size = font_size,
		font = font,
		color = tweak_data.screen_colors.text
	})
	self:_make_fine_text(money_text)
	money_text:set_left(math.round(exp_ring:right()))
	money_text:set_top(math.round(player_text:bottom()))
	max_left_len = math.max(max_left_len, money_text:w())
	local total_money_text = panel:text({
		text = self:get_text("hud_offshore_account") .. ": " .. managers.experience:cash_string(managers.money:offshore()),
		font_size = font_size,
		font = font,
		color = tweak_data.screen_colors.text
	})
	self:_make_fine_text(total_money_text)
	total_money_text:set_left(math.round(exp_ring:right()))
	total_money_text:set_top(math.round(money_text:bottom()))
	max_left_len = math.max(max_left_len, total_money_text:w())
	local font_scale = 1
	self._panel = panel
	local w = math.max(exp_ring:w() + max_left_len + 15 + max_right_len + 10, 438)
	local h = math.max(total_money_text:bottom(), 100)
	self._panel:set_size(w, h)
	self._panel:set_bottom(self._panel:parent():h())
	self._panel:rect({
		color = Color.black,
		alpha = 0.5,
		layer = -2
	})
	BoxGuiObject:new(self._panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	bg_ring_white:move(-5, 0)
	bg_ring:move(-5, 0)
	exp_ring:move(-5, 0)
	level_text:set_center(exp_ring:center())
	self:_rec_round_object(panel)
end
function PlayerProfileGuiObject:_rec_round_object(object)
	local x, y, w, h = object:shape()
	object:set_shape(math.round(x), math.round(y), math.round(w), math.round(h))
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
end
function PlayerProfileGuiObject:get_text(text, macros)
	return utf8.to_upper(managers.localization:text(text, macros))
end
function PlayerProfileGuiObject:_make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
end
function PlayerProfileGuiObject:close()
	if self._panel and alive(self._panel) then
		self._panel:parent():remove(self._panel)
		self._panel = nil
	end
end
