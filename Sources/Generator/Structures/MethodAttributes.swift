struct MethodAttributes {
    enum MemberAccess: UInt16, Maskable {
        static let mask: UInt16 = 0x0007

        case compilerControlled = 0x0000
        case `private` = 0x0001
        case famANDAssem = 0x0002
        case assem = 0x0003
        case family = 0x0004
        case famORAssem = 0x0005
        case `public` = 0x0006
    }

    // I don't know what this enum should be calles, so I'm just calling this SlotInit for now
    enum SlotInit: UInt16 {
        case reuseSlot = 0x0000
        case newSlot = 0x0100
    }

    struct InteropAttributes: OptionSet {
        let rawValue: UInt16
        
        static let pInvokeImpl = Self(rawValue: 0x2000)
        static let unmanagedExport = Self(rawValue: 0x0008)
    }

    struct AdditionalFlags: OptionSet {
        let rawValue: UInt16
        
        static let rtSpecialName = Self(rawValue: 0x1000)
        static let hasSecurity = Self(rawValue: 0x4000)
        static let requireSecObject = Self(rawValue: 0x8000)
    }
}