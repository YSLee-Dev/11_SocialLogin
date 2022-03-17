//
//  EmailAddViewController.swift
//  11_SocialLogin
//
//  Created by 이윤수 on 2022/03/17.
//

import UIKit

class EmailAddViewController : UIViewController {
    
    var mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var emailTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.borderStyle = .none
        tf.placeholder = "Email"
        tf.layer.cornerRadius = 25
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 0.5
        return tf
    }()
    
    var pwTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.borderStyle = .none
        tf.placeholder = "PW"
        tf.layer.cornerRadius = 25
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 0.5
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }
    
    @objc func okBtnClick(_ sender:Any){
        
    }

    private func viewSet(){
        self.view.backgroundColor = .black
        self.title = "Email/PW"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(okBtnClick(_:)))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.view.addSubview(self.mainStackView)
        NSLayoutConstraint.activate([
            self.mainStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        self.mainStackView.addArrangedSubview(self.emailTF)
        self.mainStackView.addArrangedSubview(self.pwTF)
        NSLayoutConstraint.activate([
            self.emailTF.heightAnchor.constraint(equalToConstant: 50),
            self.pwTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
