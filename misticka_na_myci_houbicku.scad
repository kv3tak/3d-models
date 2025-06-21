// Rozmery vetsi houbicky
cw = 9.5; // cube width
cd = 7; // cube depth
ch = 2; // cube height

bw = 0.3; // border width
ph = 0.1; // paw height

corner_radius= 0.3; // radius of the corners

main();

module main() {
  union() {
    difference() {
      // Outer frame
      // cube([cw + bw * 2, cd + bw * 2, ch + bw], center=true);
      minkowski() {
        cube([cw + bw * 2 - 2 * corner_radius, cd + bw * 2 - 2 * corner_radius, ch + bw - corner_radius], center=true);
        cylinder(r=corner_radius, h=corner_radius, center=true, $fn=32);
      }

      // Inner space
      translate([0, 0, bw])
        cube([cw, cd, ch], center=true);
    }

    translate([0, 0, -ch / 2 + bw])
      resize([5, 0], auto=[false, true])
        linear_extrude(0.2)
          import("Paw_Print.svg", center=true);
  }
}
