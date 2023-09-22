import UIKit

class CustomButton: UIButton {
    
    enum ButtonStyle {
        case login
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
        case .sendMessage:
            sendMessageButton()
        case .profile:
            setupProfileButton()
        case .changeLetter:
            setupChangeLetterButton()
        }
    }
    
    private func setupLoginButton() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 20
        self.setTitle("Login", for: .normal)
    }
    
    private func sendMessageButton() {
        self.layer.cornerRadius = 50
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        self.layer.cornerRadius = 30
        self.setTitle("Send", for: .normal)
        self.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    private func setupProfileButton() {
        self.backgroundColor = .green
        self.layer.cornerRadius = 15
        self.setTitle("Profile", for: .normal)
    }
    
    private func setupChangeLetterButton() {
        self.setImage(UIImage(named: "changeLetterIcon"), for: .normal)
    }
}
