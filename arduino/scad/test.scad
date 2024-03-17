size = 20;
cubesize = 3 * size;
cutsphere = 2 * size;
innersphere = size;
cylinderheight = 4 * size;
cylinderradius = size;
cylinderoffset = 2 * size;
 

//create a cyan rectangle @y+35
translate([0, cubesize, 0])
color([0, 1, 1])
cube([2, 3, 4]);

// create a red rectangle at x+35
translate([cubesize, 0, 0]) {
    color([1,0,0])
    cube([2, 3, 4]);
}

// create a green 30x30x30 cube at the center with a r20 sphere cut out
difference() {
    color([0,1,0])
    cube(cubesize, center=true);
    sphere(cutsphere);
}

// create a h40 r10 cylinder at z+30
translate([0, 0, cylinderoffset]) {
    cylinder(h=cylinderheight, r=cylinderradius);
}

// create a r10 sphere at the center
sphere(innersphere);
