//
//  LoginUIButton.swift
//  11_SocialLogin
//
//  Created by 이윤수 on 2022/03/17.
//

import UIKit

class LoginUIButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 25
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
