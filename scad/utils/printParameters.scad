include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

include <../Parameters_Main.scad>
include <../Parameters_Positions.scad>

/*
layer height ranges:
0.4 : [  0.11,   0.34  ], at ew : [ 0.44, 0.68 ]
0.5 : [  0.1375, 0.425 ], at ew : [ 0.55, 0.85 ]
0.6 : [  0.165,  0.51  ], at ew : [ 0.66, 1.02 ]
0.8 : [  0.22,   0.68  ], at ew : [ 0.88, 1.36 ]
1.0 : [  0.275,  0.85  ], at ew : [ 1.10, 1.70 ]

extrusion width ranges (2*lh <= ew < 4*lh)
for 0.4 nozzle
lh     ew
0.15 : [ 0.44, 0.60 ]
0.2  : [ 0.44, 0.68]
0.25 : [ 0.50, 0.68]
0.3  : [ 0.60, 0.68 ]
for 0.6 nozzle
lh     ew
0.2  : [ 0.66, 0.80 ]
0.25 : [ 0.66, 1.00 ]
0.333: [ 0.666,1.02 ]
0.4  : [ 0.80, 1.02 ]
0.5  : [ 1.00, 1.02 ]
for 0.8 nozzle
lh     ew
0.25 : [ 0.88, 1.00 ]
0.33 : [ 0.88, 1.32 ]
0.4  : [ 0.88, 1.36 ]
0.5  : [ 1.00, 1.36 ]
0.6  : [ 1.20, 1.36 ]
0.666 :[ 1.333,1.36 ]
for 1.0 nozzle
lh     ew
0.33 : [ 1.1,  1.32 ]
0.4  : [ 1.1,  1.60  ]
0.5  : [ 1.1,  1.70 ]
0.6  : [ 1.2,  1.70 ]
0.666 :[ 1.333,1.70 ]
0.8  : [ 1.6,  1.70 ]

preferred settings:
n    lh    ew
0.4  0.20  0.44
0.4  0.25  0.50
0.4  0.30  0.60
0.6  0.25  0.66
0.6  0.40  0.80
0.6  0.50  1.00
0.8  0.60  1.20
0.8  0.66  1.33
1.0  0.66  1.33
1.0  0.80  1.65
*/

module echoPrintParameters() {
    //assert(extrusion_width >= 1.1*nozzle, "extrusion_width too small for nozzle");
    //assert(extrusion_width <= 1.7*nozzle, "extrusion_width too large for nozzle");
    //assert(layer_height <= 0.5*extrusion_width, "layer_height too large for extrusion_width");
    //assert(layer_height >= 0.25*extrusion_width, "layer_height too small for extrusion_width"); // not sure this one is correct

    echo(nozzle = nozzle);
    echo(extrusion_width = extrusion_width, r = [1.1*nozzle, 1.7*nozzle]);
    echo(layer_height = layer_height, r = [0.25*extrusion_width, 0.5*extrusion_width]);
    echo(layer_height_full_range = [0.25*1.1*nozzle, 0.5*1.7*nozzle], ew = [1.1*nozzle, 1.7*nozzle]);
    echo($fs=$fs);
    echo($fa=$fa);
}

module echoPrintSize() {
    echo(Variant = _variant);
    echo(Print_size = [_xMax-_xMin, _yMax-_yMin, _zMax-_zMin]);
    echo(Sizes = [eX + 2*eSize, eY + 2*eSize, eZ]);
    echo(Motors = _xyMotorDescriptor, is_undef(_zMotorDescriptor) ? "" : _zMotorDescriptor);
    echo(Rails = _xRailLength, _yRailLength);
    echo(Carriages = _xCarriageDescriptor, _yCarriageDescriptor);
    echo(Rods  = _zRodDiameter, _zRodLength);
    if (!is_undef(_zRodOffsetY))
        echo(_zRodOffsetY = _zRodOffsetY);
}
