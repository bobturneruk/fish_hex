
point_to_point = 35; // diameter
inner_radius = point_to_point / 2; // edge length
outer_radius = inner_radius + 2;
fillet = 1;
fillet_radius = outer_radius + fillet / 2;
centre_to_edge = sqrt(3) * (fillet_radius) / 2;

module unit(inner_radius = inner_radius, outer_radius = outer_radius, height = 3, base_thickness = 1) {
    difference() {
        linear_extrude(height = height, center = false)
        offset(r = fillet) {circle(r=outer_radius, $fn=6);}  
        translate([0, 0, 1])
        linear_extrude(height = height + 4, center = false)
        offset(r = fillet) {circle(r=inner_radius, $fn=6);}  
        translate([0, 0, 3])
        rotate([0, 0, 0])
        cube([15, 50, 4], center = true);
        translate([0, 0, 3])
        rotate([0, 0, 60])
        cube([15, 50, 4], center = true);
        translate([0, 0, 3])
        rotate([0, 0, 120])
        cube([15, 50, 4], center = true);
    }
}

module row_short() {
    for (dy=[0:centre_to_edge*2:centre_to_edge * 2 * 6]) {
        translate([0,dy,0])
            unit();
    }
}

module row_long() {
    for (dy=[0:centre_to_edge*2:centre_to_edge * 2 * 7]) {
        translate([0,dy,0])
            unit();
    }
}

module two_rows() {
    row_long();
    translate([fillet_radius/2 + fillet_radius, centre_to_edge, 0])
    row_short();
}

module main_board() {
    for (dx=[0:fillet_radius*3:fillet_radius * 3 * 3]) {
        translate([dx,0,0])
            two_rows();
    }
}

main_board();
