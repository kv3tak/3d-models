// make cube (fill sides) with top open and bottom closed

cw=9.5; // cube width
cd=7; // cube depth
ch=4; // cube height

main();

module main() {
    union() {
            difference() {
                // Outer frame
                cube([cw, cd, ch], center=true);
                // Inner space
                translate([0, 0, +ch/2 + 0.1]) // Slightly lower to avoid z-fighting
                    cube([cw - 1, cd - 1, ch - 0.2], center=true);
            }
    }
}
