import UIKit

class CustomButton: UIButton {
    
    enum ButtonStyle {
        case login
        case onBoarding
        case writeMessage
        case sendMessage
        case profile
        case changeLetter
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(style: ButtonStyle) {
        self.init()
        
        switch style {
        case .login:
            setupLoginButton()
        case.onBoarding:
            setupOnBoardingButton()
        case .writeMessage:
            setupWriteMessageButton()
        case .sendMessage:
            setupSendMessageButton()
        case .profile:
            setupProfileButton()
        case .changeLetter:
            setupChangeLetterButton()
        }
        
        applyCommonFeature()

    }
    
    private func applyCommonFeature() {
        
        //Shadow
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = UIColor.black.cgColor
        
        //CornerRadius
        self.layer.cornerRadius = 20
            
        //Font
        self.titleLabel?.font = CustomFont.gamjaFlowerRegular.size(20)
    }
    
    private func setupLoginButton() {
        self.backgroundColor = .black
        self.frame = CGRect(x: 0, y: 0, width: 160, height: 50)
        self.setTitle("Login", for: .normal)

    }
    
    private func setupOnBoardingButton() {
        self.layer.backgroundColor = UIColor(red: 0.09, green: 0.714, blue: 0.737, alpha: 1).cgColor
        self.frame = CGRect(x: 0, y: 0, width: 160, height: 50)
        
    }
    
    private func setupWriteMessageButton() {
        self.layer.cornerRadius = 50
        self.layer.backgroundColor = UIColor(red: 0.09, green: 0.714, blue: 0.737, alpha: 1).cgColor
        self.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        self.setImage(UIImage(systemName: "pencil.and.outline"), for: .normal)
    }
    
    private func setupDeactivateSendMessageButton() {
        
    }
    
    private func setupSendMessageButton() {
        self.frame = CGRect(x: 0, y: 0, width: 160, height: 50)
        self.layer.backgroundColor = UIColor(red: 0.09, green: 0.714, blue: 0.737, alpha: 1).cgColor
        self.setTitle("편지전송", for: .normal)
        self.setImage(UIImage(systemName: "envelope"), for: .normal)
    }
    
    private func setupProfileButton() {
        self.backgroundColor = .green
        self.setTitle("Profile", for: .normal)
    }
    
    private func setupChangeLetterButton() {
        self.setImage(UIImage(named: "changeLetterIcon"), for: .normal)
    }
}
