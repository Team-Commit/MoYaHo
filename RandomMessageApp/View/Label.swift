import UIKit

class CustomLabel: UILabel {

    enum LabelStyle {
        case myPageLabel
        case myPageCount
        case myPageCountRightLabel
        case myPageMenuLabel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(style: LabelStyle) {
        self.init()
        
        switch style {
        case .myPageLabel:
            myPageLabel()
        case .myPageCount:
            setupMyPageCountLabel()
        case .myPageCountRightLabel:
            setupMyPageCountRightLabel()
        case .myPageMenuLabel:
            setupMyPageMenuLabel()
        }
    }
    
    private func myPageLabel() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 20
    }
    
    private func setupMyPageCountLabel() {
    }
    
    private func setupMyPageCountRightLabel() {
    }
    
    
    private func setupMyPageMenuLabel() {
    }
}
