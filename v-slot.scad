include <v-slot-parameters.scad>;

// Draws a 2D shape of a v-slot aluminium extrusion.
// * fit (default: 0) - optionally extends the v-slot's outer edges by given value.
// Useful if, for example, you want your part running freely over a v-slot.
module v_slot_2d (fit = 0) {
  d_fit = v_slot_d + fit;
  difference() {
    square([ d_fit, d_fit ], center = true);

    for (spot = [0:3]) {
      rotate([ 0, 0, spot * 90 ]) {
        translate([ 0, d_fit / 2 - v_slot_slot_h ]) {
          for (copy = [ 0, 1 ]) {
            mirror([ copy, 0, 0 ]) {
              polygon([
                [ -v_slot_slot_outer_w / 2, v_slot_slot_h ],
                [ -v_slot_slot_inner_w / 2, v_slot_slot_h - v_slot_outer_wall_t ],
                [ -v_slot_slot_w / 2, v_slot_slot_h - v_slot_outer_wall_t ],
                [
                  -v_slot_slot_w / 2, v_slot_slot_h - v_slot_outer_wall_t -
                  v_slot_slot_cam_h
                ],
                [ -v_slot_slot_inner_w / 2, 0 ],
                [ 0, 0 ],
                [ 0, v_slot_slot_h ],
              ]);
            }
          }
        }
      }
    }

    circle(d = v_slot_center_hole_d);
  }
}

module v_slot (h, fit = 0) {
  linear_extrude(h) v_slot_2d(fit);
}

module v_slot_2d_clearance (fit = 0) {
  hull() v_slot_2d(fit);
}

module v_slot_clearance (h, fit = 0) {
  linear_extrude(h) v_slot_2d_clearance(fit);
}
