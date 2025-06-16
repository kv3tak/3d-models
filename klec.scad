// Rozmery stolni desky v mm
dw=1499; // cca 150 cm   (sirka)
dd=749;  // cca  75 cm   (hloubka)
dh=34;   // cca   3.5 cm (vyska)

// cage frame width - tloustka ramu klece
cfw=40;

// cage height - vyska klece
ch=710; // 71 cm

// bar diameter - prumer tyce
bd=30; // adjustable, should be less than cfw

// bar spacing - vzdalenost mezi tycemi
bs=200; // adjustable

main();

module main() {
    union(){
        color("red") desk();
        left_side();
        right_side();
        back_side();

        color("yellow") front_side_door_frame();
        front_side_wall();

        // back side fill
        translate([0, -(dd/2 - cfw/2), -(ch/2 + dh/2)]) 
            fill_side(dw - 2*cfw, floor((dw - 2*cfw) / bs));

        // front side wall fill
        translate([-(dw/2 - cfw)/2,(dd - cfw)/2,-(ch/2 + dh/2)]) 
                fill_side(dw/2 - cfw, floor((dw/2 - cfw) / bs));

        // front side door fill
        // translate([+(dw/2 - cfw)/2,(dd - cfw)/2,-(ch/2 + dh/2)]) 
        //         fill_side(dw/2 - cfw, floor((dw/2 - cfw) / bs));

        // left side fill
        translate([-(dw/2 - cfw/2),0,-(ch/2 + dh/2)]) 
            rotate([0,0,90]) // Rotate to fill vertically 
                fill_side(dd - 2*cfw, floor((dd - 2*cfw) / bs));

        // right side fill
        translate([+(dw/2 - cfw/2),0,-(ch/2 + dh/2)]) 
            rotate([0,0,90]) // Rotate to fill vertically
                fill_side(dd - 2*cfw, floor((dd - 2*cfw) / bs));
    }
}

module desk() {
    cube([dw,dd,dh], center=true);
}

module front_side_door_frame() { 
    translate([(dw/2 - cfw)/2,(dd - cfw)/2,-(ch/2 + dh/2)]) 
        difference() {
            // Outer frame
            cube([dw/2 - cfw,cfw,ch], center=true);
            // Inner space (like small/big side)
            cube([dw/2 - cfw - cfw*2, cfw+1, ch-cfw*2], center=true);
        }
}

module front_side_wall() {
    translate([-(dw/2 - cfw)/2,(dd - cfw)/2,-(ch/2 + dh/2)]) 
        difference() {
            // Outer frame
            cube([dw/2 - cfw,cfw,ch], center=true);
            // Inner space (like small/big side)
            cube([dw/2 - cfw - cfw*2, cfw+1, ch-cfw*2], center=true);
        }
}

module left_side() {
    translate([-(dw/2 - cfw/2),0,-(ch/2 + dh/2)]) 
        cage_side_small();
}

module right_side() {
    translate([+(dw/2 - cfw/2),0,-(ch/2 + dh/2)]) 
        cage_side_small();
  
}

module back_side() {
    translate([0, -(dd/2 - cfw/2), -(ch/2 + dh/2)]) 
        cage_side_big();
}

module cage_side_small() {
    // Outer side
    difference() {
        // Outer frame
        cube([cfw,dd,ch], center=true);
        // Inner space
        cube([cfw+1, dd-cfw*2, ch-cfw*2], center=true);
    }
}

module cage_side_big() {
    difference() {
        // Outer frame
        cube([(dw - 2*cfw),cfw,ch], center=true);
        // Inner space
        cube([(dw - 2*cfw) -cfw*2, cfw+1, ch-cfw*2], center=true);
    }
}

// Fill cage side with vertical bars with spaces between computed based on max width and number of bars (first bar starts at the second position)
module fill_side(max_width, num_bars=0) {
    // Calculate number of bars if not specified
    if (num_bars == 0) {
        num_bars = floor(max_width / bs);
    }
    
    // Calculate spacing between bars
    spacing = (max_width - bd * num_bars) / (num_bars + 1);
    
    // Create vertical bars
    for (i = [0:num_bars-1]) {
        x_pos = -max_width/2 + spacing * (i + 1) + bd * i;
        vertical_bar(x_pos, 0);
    }    
}

module vertical_bar(x,y) {
    // Vertical cylindrical bar
    translate([x, y, 0]) {
        cylinder(h=ch, r=bd/2, center=true);
    }
}

// Make cube cage frame
module cage_frame() {
    difference() {
        // Outer frame
        cube([dw+cfw*2, dd+cfw*2, dh+cfw], center=true);
        // Inner space
        translate([cfw, cfw, 0])
            cube([dw-cfw*2, dd-cfw*2, dh], center=true);
    }
}
