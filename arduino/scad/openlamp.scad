radius = 100; 

linear_extrude(height=radius*1.5, scale=0.5, twist=90) {
    difference() { 
        circle(r=radius, $fn=5);
        circle(r=radius-10, $fn=5);
    }
    // for (deg=[0:360/5:360]) {
    //     rotate([0,0,deg]) {
    //         translate([100, 0, 0]) {
    //             circle(r=radius/2, $fn=3);
    //         }
    //     }
    // } 
}
