import UIKit

class CustomButton: UIButton {

    enum ButtonStyle {
        case login
        case register
        case profile
        // Add other styles as needed
    }
    
    // Initializers
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
        case .register:
            setupRegisterButton()
        case .profile:
            setupProfileButton()
        }
    }
    
    // UI Configuration for different styles
    private func setupLoginButton() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 20
        self.setTitle("Login", for: .normal)
    }
    
    private func setupRegisterButton() {
        self.backgroundColor = .blue
        self.layer.cornerRadius = 10
        self.setTitle("Register", for: .normal)
    }
    
    private func setupProfileButton() {
        self.backgroundColor = .green
        self.layer.cornerRadius = 15
        self.setTitle("Profile", for: .normal)
    }
    
    // Add more setup functions as needed
}
