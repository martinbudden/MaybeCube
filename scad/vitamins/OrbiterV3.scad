// All dimensions from  https://www.orbiterprojects.com/so3/

smartOriterV3BaseToNozzleTipOffsetZ = 21.7;
function smartOrbiterV3LowerFixingHolesToNozzleTipOffsetZ() = 8.1 + smartOriterV3BaseToNozzleTipOffsetZ;

module smartOrbiterV3() {
    vitamin(str("smartOrbiterV3() : Smart Orbiter V3.0"));

    color(grey(30)) {
        import(str("../stlimport/OrbiterV3HeatSink.3mf"));
        translate([-8, -28, 14])
            rotate([-90, 0, 0])
                import(str("../stlimport/OrbiterV3Fan.3mf"));
        translate([0, 0, 9]) {
            import(str("../stlimport/OrbiterV3HubHousing.3mf"));
            translate([0, 1, 0])
                rotate([0, -8, 0])
                    import(str("../stlimport/OrbiterV3GearHousing.3mf"));
        }
        translate([34.7, 28.2, 20.2])
            rotate([-90, -18, 0]) {
                import(str("../stlimport/OrbiterV3Stepper.3mf"));
                translate([-36.45, 0, -14.8]) {
                    cylinder(h=8, r=34.5/2, center=false);
                    translate([0, 0, 8])
                        cylinder(h=5.6, r=36.5/2, center=false);
                }
        }
    }
    color("silver")
        translate([6.5, -15, 7.095 - smartOriterV3BaseToNozzleTipOffsetZ])
            import(str("../stlimport/OrbiterV3HeatBlock.3mf"));
}
