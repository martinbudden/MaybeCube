import cadquery as cq

from TypeDefinitions import T, Point2D, Point3D

from constants import fittingTolerance, cncKerf, cncCuttingRadius, lsrKerf, lsrCuttingRadius, wjKerf, wjCuttingRadius
from constants import eSize
from constants import M3_tap_radius, M3_clearance_radius, M4_clearance_radius

from stepper_motors import NEMA17_40, NEMA_boss_radius, NEMA_hole_pitch


def xyMotorMountBase(
    self: T,
    sizeX: float = 79,
    sizeY: float = 58,
    sizeZ: float = 4.5,
    cuttingRadius: float = cncCuttingRadius,
    kerf: float = 0,
) -> T:

    size = Point3D(sizeX, sizeY, sizeZ)
    rearBlockSize = Point3D(size.x - eSize, eSize, 2)
    fillet = 2
    motor = NEMA17_40
    motorPos = Point2D(size.x - 22.5, 22.35)
    assert(motorPos.x <= size.x -22)

    result = (
        self.center(-size.x/2, -size.y/2)
        .rect(size.x, size.y)
        .center(-size.x/2, -size.y/2) # set origin to bottom left corner of face
    )

    sideHoles = [(eSize/2, y) for y in [8, 30]]
    pulleyHoles = [(30.5, y - 0.15) for y in [8, 27]]
    backHoles = [(x, size.y - eSize/2) for x in [eSize + 10, size.x - 10]]

    result = (
        result
        .pushPoints(sideHoles)
        .circle(M3_clearance_radius - kerf/2)
        .pushPoints(pulleyHoles)
        .circle(M3_tap_radius - kerf/2)
    )

    result = result.extrude(size.z)

    # cut out the corner
    result = (
        result
        .faces(">Z")
        .moveTo(eSize/2, size.y - eSize/2)
        .rect(eSize, eSize)
        .cutThruAll()
    )

    # cut out the corner indent, to allow space for the CNC cutter
    result = (
        result
        .faces(">Z")
        .moveTo(eSize - cuttingRadius, size.y - eSize)
        .circle(cuttingRadius)
        .cutThruAll()
    )

    # add the rear block
    result = (
        result
        .faces(">Z")
        .workplane()
        .moveTo(eSize, size.y - eSize)
        .box(rearBlockSize.x, rearBlockSize.y, rearBlockSize.z, centered=False)
    )

    # cut out the motor holes
    result = (
        result
        .faces(">Z")
        .moveTo(motorPos.x, motorPos.y)
        .circle(NEMA_boss_radius(motor) + 0.5)
        .rect(NEMA_hole_pitch(motor), NEMA_hole_pitch(motor), forConstruction=True)
        .vertices()
        .circle(M3_clearance_radius)
        .cutThruAll()
    )

    # cut out the back holes
    result = (
        result
        .faces(">Z")
        .pushPoints(backHoles)
        .circle(M4_clearance_radius)
        .cutThruAll()
    )

    # cut out counterbores in the rear block for the back two motor boltheads
    result = (
        result
        .faces(">Z")
        .moveTo(motorPos.x, motorPos.y)
        .rect(NEMA_hole_pitch(motor), NEMA_hole_pitch(motor), forConstruction=True)
        .vertices()
        # 6.88 is maximum size without interfering with fillets
        .circle(6.88/2 - kerf/2)
        .cutBlind(rearBlockSize.z)
    )

    result = (
        result
        .edges("|Z")
        .fillet(fillet)
    )

    return result


def main() -> None:
    #step = cq.importers.importStep("../FreeCAD/XY_Motor_Mount_Left_Base.step")
    #show_object(step)

    xyMotorMountLeftBase  = xyMotorMountBase(cq.Workplane("XY"))

    xyMotorMountRightBase = xyMotorMountLeftBase.mirror("YZ")

    show_object(xyMotorMountLeftBase)
    xyMotorMountLeftBase.export("exports/XY_MotorMountLeft.stl")
    #show_object(xyMotorMountRightBase)


if 'show_object' in globals():
    main()
