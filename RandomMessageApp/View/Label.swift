import UIKit

class CustomLabel: UILabel {

    enum LabelStyle {
        case myPageLabel
        case myPageCount
        case myPageCountRightLabel
        case myPageMenuLabel
        case mainPageLabel
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
        case .mainPageLabel:
            setupMainPageLabel()
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
    
    private func setupMainPageLabel() {
        self.text = "무야호!"
        self.textColor = .black
        self.font = UIFont.boldSystemFont(ofSize: 20)
        self.font = CustomFont.gamjaFlowerRegular.size(20)
    }
}
