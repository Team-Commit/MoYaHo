

    import UIKit


    class GreetViewController: UIViewController   {
        
        let soundEffect = SoundEffect()
        private lazy var backgroundImage: UIImageView = {
            let imageView = UIImageView(frame: self.view.bounds)
            imageView.image = UIImage(named: "greet")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()

        private lazy var textField: UITextField = {
            let textField = UITextField()
            return textField
        }()
        
        private lazy var enrolledButton: CustomButton = {
            let button = CustomButton(style: .login)
            button.addTarget(self, action: #selector(presentMainVC), for: .touchUpInside)
            return button
        }()
    }


    //MARK: - View Cycle

    extension GreetViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            navigationController?.popViewController(animated: true)

        }
        
        
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("viewWillAppear called22")
            soundEffect.playCrashSound()
            soundEffect.windAudioPlayer?.stop()
        }
    }


    //MARK: - Setup UI

    extension GreetViewController {
        
        func setupUI() {
            view.addSubview(backgroundImage)
            view.addSubview(textField)
            view.addSubview(enrolledButton)
            constraints()
            
        }
        
        func constraints() {
            
            backgroundImage.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            enrolledButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-130)
                make.centerX.equalToSuperview()
                make.width.equalTo(180)
                make.height.equalTo(50)
            }
        }
        
    }


    //MARK: - Transition Effect
    extension GreetViewController {
        @objc func presentMainVC() {
            let fadeTransitioningDelegate = FadeTransitioningDelegate()
            let mainVC = MainViewController()
            let navVC = UINavigationController(rootViewController: mainVC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.transitioningDelegate = fadeTransitioningDelegate
            self.present(navVC, animated: true) {
            }
        }
    }
