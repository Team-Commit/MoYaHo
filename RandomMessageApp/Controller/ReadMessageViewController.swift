//
//  SendMessageView.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/18.
//

import UIKit
import SnapKit


//MARK: - Properties
class ReadMessageViweController: UIViewController {
    
    private lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 50)
        textView.autocorrectionType = .no
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    private lazy var letterView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home")
        imageView.contentMode = .scaleAspectFill
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
    
    private lazy var sendButton:UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.layer.cornerRadius = 30
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
}



//MARK: - View Cycle

extension ReadMessageViweController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavButton()
        setupTextView()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sendMessage() {
        
        
        
    }
    
    func setupTextView() {
        
        
    }

    
}



extension ReadMessageViweController {
    func setupNavButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem
    }
}



//MARK: - Setup UI

private extension ReadMessageViweController {
    func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(letterView)
        view.addSubview(messageTextView)
        view.addSubview(sendButton)
        messageTextView.delegate = self
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        
    }
    
}

//MARK: - Constraints
private extension ReadMessageViweController {
    func setupConstraints() {
        letterView.snp.makeConstraints { make in
            
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        sendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(letterView.snp.bottom).offset(100)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
    }
    
    
}



//MARK: - UITextViewDelegate
extension ReadMessageViweController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 500
    }
}




