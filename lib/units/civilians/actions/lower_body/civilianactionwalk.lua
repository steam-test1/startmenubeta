CivilianActionWalk = CivilianActionWalk or class(CopActionWalk)
CivilianActionWalk._walk_anim_velocities = {
	stand = {
		ntl = {
			walk = {
				fwd = 129,
				bwd = 111.3,
				l = 136.1,
				r = 136.1
			},
			run = {
				fwd = 421,
				bwd = 222,
				l = 436,
				r = 419
			}
		},
		hos = {
			walk = {
				fwd = 170,
				bwd = 170,
				l = 170,
				r = 170
			},
			run = {
				fwd = 421,
				bwd = 222,
				l = 436,
				r = 419
			}
		}
	}
}
CivilianActionWalk._walk_anim_velocities.stand.cbt = CivilianActionWalk._walk_anim_velocities.stand.hos
CivilianActionWalk._anim_movement = {
	stand = {
		run_start_turn_bwd = {
			ds = Vector3(49, -161, 0)
		},
		run_start_turn_l = {
			ds = Vector3(-250, 90, 0)
		},
		run_start_turn_r = {
			ds = Vector3(240, 68, 0)
		},
		run_stop_fwd = 120,
		run_stop_l = 110,
		run_stop_r = 80
	}
}
