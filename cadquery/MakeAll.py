import cadquery as cq

from XY_MotorMount import xyMotorMountBase


def makeCNCs():
    print("Making STEP and STL files")
    xyMotorMountLeftBase = xyMotorMountBase(cq.Workplane("XY"))
    xyMotorMountLeftBase.export("exports/XY_MotorMountLeft.step")
    xyMotorMountLeftBase.export("exports/XY_MotorMountLeft.stl")

    xyMotorMountRightBase = xyMotorMountLeftBase.mirror("YZ")
    xyMotorMountRightBase.export("exports/XY_MotorMountRightBase.step")
    xyMotorMountRightBase.export("exports/XY_MotorMountRightBase.stl")


def main() -> None:
    makeCNCs()


if __name__ == '__main__':
    main()

