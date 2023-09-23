

import UIKit
import SnapKit


//MARK: - Properties
class SendMessageViewController: UIViewController {
    
    private lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.autocorrectionType = .no
        return textView
    }()
    
    private lazy var textCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    
    private lazy var letterView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.3
        return imageView
    }()
    
    private lazy var subLetterView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home2")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var subLetterView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home3")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var subLetterView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home4")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var sendButton:CustomButton = {
        let button = CustomButton(style: .sendMessage)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    private lazy var changeLetterButton:CustomButton = {
        let button = CustomButton(style: .changeLetter)
        button.addTarget(self, action: #selector(changeLetter), for: .touchUpInside)
        return button
    }()
    
    
}

//MARK: - View Cycle
extension SendMessageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavButton()
        messageTextView.delegate = self
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func changeLetter() {
        
    }
    
    @objc func sendMessage() {
        APIManager.shared.sendMessage(content: "Your message content here", accessToken: "Your access token here") { result in
            switch result {
            case .success(let isSuccess):
                if isSuccess {
                    print("Message sent successfully!")
                } else {
                    print("Failed to send message.")
                }
            case .failure(let error):
                print("Error sending message: \(error)")
            }
        }
    }
    
    
    
}


extension SendMessageViewController {
    func setupNavButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem
    }
}



//MARK: - Setup UI

private extension SendMessageViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(letterView)
        view.addSubview(sendButton)
        view.addSubview(messageTextView)
        view.addSubview(textCountLabel)
        messageTextView.delegate = self
        setupConstraints()
        
    }
    
}

//MARK: - Constraints
private extension SendMessageViewController {
    func setupConstraints() {
        letterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(letterView.snp.bottom).offset(100)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        
        messageTextView.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(210)
            make.bottom.equalToSuperview().offset(-220)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(430)
        }
        
        textCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(letterView).offset(-50)
            make.right.equalTo(letterView).offset(-30)
        }
    }
}

//MARK: - UITextViewDelegate
extension SendMessageViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        let projectedLength = updatedText.count
        
        // Update the text count label
        textCountLabel.text = "\(projectedLength)/200"
        
        return projectedLength >= 0 && projectedLength <= 200
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        let currentLength = textView.text.count
        textCountLabel.text = "\(currentLength)/200"
    }
    
}


//MARK: - Popup sheet
extension SendMessageViewController {
    func popUpsheet() {
        
    }
}

