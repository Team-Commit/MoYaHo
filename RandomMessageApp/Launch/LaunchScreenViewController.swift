//
//  LaunchScreenViewController.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/21.
//

import UIKit


class LaunchScreenViewController: UIViewController {
    
    private let islandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "island")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private let labelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "luanchLabel")
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(islandImageView)
        view.addSubview(labelImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        islandImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        labelImageView.snp.makeConstraints { make in
            make.top.equalTo(islandImageView.snp_bottomMargin).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}
