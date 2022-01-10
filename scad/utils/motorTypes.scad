function isNEMAType(motorType) = is_list(motorType) && motorType[0][0] == "N";

function motorWidth(motorType) = isNEMAType(motorType) ? NEMA_width(motorType) : motorType[0]=="BLDC4250" ? 56 : 62.5;

function motorType(motorDescriptor) =
    motorDescriptor == "NEMA14" ? NEMA14 :
    motorDescriptor == "NEMA17_40" ? NEMA17M :
    motorDescriptor == "NEMA17_48" ? NEMA17 :
    motorDescriptor == "NEMA17_60" ? NEMA17_60 :
    motorDescriptor == "NEMA17_40L160" ? NEMA17_40L160 :
    motorDescriptor == "NEMA17_40L230" ? NEMA17_40L230 :
    motorDescriptor == "NEMA17_40L280" ? NEMA17_40L280 :
    motorDescriptor == "NEMA17_40L330" ? NEMA17_40L330 :
    motorDescriptor == "BLDC4250" ? BLDC4250 :
    undef;
