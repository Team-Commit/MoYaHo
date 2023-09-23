


    import UIKit

    enum CustomFont: String {
        
        case gamjaFlowerRegular = "GamjaFlower-Regular"
        case hiMelody = "HiMelody-Regular"
        case notoSansKR = "NotoSansKR-VariableFont_wght"

        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
