//
//  ViewController.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/17.
//

import UIKit
import RiveRuntime
import SnapKit
import LocalAuthentication


//MARK: - Properties
class LoginViewController: UIViewController {
    
    let soundEffect = SoundEffect()
    let context = LAContext()
    var error: NSError? = nil
    let reason = "Please authenticate yourself to proceed."
    let simpleVM = RiveViewModel(fileName: "login")
    
    private lazy var riveView: RiveView = {
        let view = RiveView()
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "MainLabel"
        label.textAlignment = .center
        label.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.borderWidth = 3
        label.layer.cornerRadius = 20
        return label
    }()
    
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton(style: .login)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var background: UIImageView = {
        let background = UIImageView()
        return background
    }()
    
    
}

//MARK: - Button Action: Login

extension LoginViewController {
    
    @objc func loginButtonTapped() {
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print("Device does not support Face ID / Touch ID.")
            showAlert(title: "Error", message: "Device does not support Face ID / Touch ID.")
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, authenticationError in
            DispatchQueue.main.async {
                guard success else {
                    print("Authentication failed. Reason: \(authenticationError?.localizedDescription ?? "Unknown error")")
                    self?.showAlert(title: "Error", message: "Authentication failed. Please try again.")
                    return
                }
                
                var userUUID = APIManager.getUUIDFromKeychain()
                if userUUID == nil {
                    
                    userUUID = "aweofiawe-23"
                    APIManager.storeUUIDInKeychain(uuid: userUUID!)
                }
                
                print("UUID::::: \(userUUID!)")
                
                APIManager.shared.requestTokenWithUUID(uuid: userUUID!) { result in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let token):
                            APIManager.storeTokenInKeychain(token: token)
                            print("::::::token - \(token)")
                            self?.presentGreetVC()
                        case .failure(let error):
                            print("Error fetching token:", error.localizedDescription)
                            self?.showAlert(title: "Error", message: "Failed to fetch token from server.")
                        }
                    }
                }
            }
        }
    }
}


//MARK: - View Cycle

extension LoginViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
        soundEffect.playWindSound()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Rive Background
        let riveView = simpleVM.createRiveView()
        view.addSubview(riveView)
        let width: CGFloat = 1000
        let height: CGFloat = 1000
        let x: CGFloat = (view.bounds.width - width) / 2
        let y: CGFloat = (view.bounds.height - height) / 2
        riveView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        //setupUI
        setupUI()
    }
}


//MARK: - Setup UI
extension LoginViewController {
    
    func setupUI() {
        view.addSubview(loginButton)
        view.addSubview(label)
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
            make.width.equalTo(200)
            
            
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
    }
}




//MARK: - Alert
extension LoginViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}


//MARK: - Transition Effect
extension LoginViewController {
    func presentGreetVC() {
        let greetVC = GreetViewController()
        let fadeTransitioningDelegate = FadeTransitioningDelegate()
        greetVC.modalPresentationStyle = .custom
        greetVC.transitioningDelegate = fadeTransitioningDelegate
        present(greetVC, animated: true)
    }
}




