wh = 10; // sirka hacku
th = 1.625;  // tlouska hacku
wd = 28; // sirka drivka 
rh = 9; // polomer spodku hacku
dkh = 4; // delka konce hacku
symbol_depth = 0.625; // hloubka symb. packy/kosticky
symbol_margin = 3; // odsazeni od 

$fn=100;

// Render celeho hacku
main();

module main() {
    difference() {
        // join parts
        union() {
            frame_base();
            hook_ending();
            holding_block();
        }
        bone();
        //paw();
    }
}

// tvar pruzeru drivka
module base_shape() {
    difference() {
        cube([wd,wd,wh], center=true);
        for (deg = [0 : 90 : 270]) {    
            rotate([0,0,deg])
            translate([wd/2,wd/2,0])
            rotate([0,0,45])
            cube([pow(2, 1/2), pow(2, 1/2), wh], center=true);
        }
    }
}

// hlavni tvar
module frame_base() {
    difference() {
        resize([wd+2*th, wd+2*th, wh])
            base_shape();
        base_shape();
        translate([0,-wd-th,0])
            cube([wd+2*th, wd+2*th, wh], center=true);
    }
}


module hook_ending() {
    // Konec hacku
    translate([
        -(wd/2) +th/2 -(2*rh),
        -(wd/2) + dkh/2,
        0
    ])
    cube([th, dkh, wh], center=true);

    // Konec hacku - zaboleni
    translate([
        -(wd/2) +th/2 -(2*rh),
        -(wd/2) + dkh ,
        0
    ])
    rotate([0,90,0])
    intersection(){
        translate([0,wh/2,0])
            cube([wh,wh,th], center=true);
        cylinder(h=th, r=wh/2, center=true);
    }


    // zaoblena cast spodku
    translate([
        -rh -wd/2,
        -wd/2,
        0
    ])
    difference() {
        cylinder(h = wh, r = rh, center = true);
        cylinder(h = wh, r = rh - th, center = true);
        translate([0,rh,0]) 
            cube([2*rh, 2*rh, wh], center=true);
    }
}


// zobáček na zavřené straně
module holding_block() {
    l1=5.5;
    l2=2.625;
    hull() {
        translate([
            wd/2 + th/2 - (l1/2), 
            -(th/2) -(wd/2),
            0
        ]) cube([l1, th, wh], center=true);
        
        translate([
            wd/2 + th/2,
            -wd/2 - (l2/2),
            0
        ]) cube([th, l2, wh], center=true);
    }
    
}


module paw() {
    translate([-(wd/2) - th, wh/3, 0])
    rotate([0,90,0])
    linear_extrude(symbol_depth)
    resize([wh - symbol_margin, 0], auto=[false, true])
    import("Paw_Print.svg", center=true);
}

module bone() {
    translate([-(wd/2) -th, wh/3, 0])
    rotate([0,90,0])
    linear_extrude(symbol_depth)
    resize([wh - symbol_margin, 0], auto=[false, true])
    import("bone.svg", center=true);
}




