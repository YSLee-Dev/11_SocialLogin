//
//  ViewController.swift
//  11_SocialLogin
//
//  Created by 이윤수 on 2022/03/13.
//

import UIKit

class ViewController: UIViewController {

    var infoStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var Mtitle : UILabel = {
        let label = UILabel()
        label.text = "소셜로그인으로 편하게 로그인 할 수 있어요!\n아래 버튼을 눌러 로그인 방법을 선택하세요."
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.numberOfLines = .max
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var Mimg : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .white
        img.image = UIImage(systemName: "person")
        return img
    }()
    
    var loginStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var googleBtn : LoginUIButton = {
        let btn = LoginUIButton()
        btn.setTitle("Google", for: .normal)
        btn.setImage(UIImage(named: "logo_google"), for: .normal)
        btn.addTarget(self, action: #selector(googleClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    var appleBtn : LoginUIButton = {
        let btn = LoginUIButton()
        btn.setTitle("Apple", for: .normal)
        btn.setImage(UIImage(named: "logo_apple"), for: .normal)
        btn.addTarget(self, action: #selector(appleClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    var emailBtn : LoginUIButton = {
        let btn = LoginUIButton()
        btn.setTitle("Email/PW", for: .normal)
        btn.addTarget(self, action: #selector(emailClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }
    
    @objc func googleClick(_ sender:Any){
       
    }
    
    @objc func appleClick(_ sender:Any){
        
    }
    
    @objc func emailClick(_ sender:Any){
        self.navigationController?.pushViewController(EmailAddViewController(), animated: true)
    }

    private func viewSet(){
        self.view.backgroundColor = .black
        self.title = "LOGIN"
        
        // info 생성
        self.view.addSubview(self.infoStackView)
        NSLayoutConstraint.activate([
            self.infoStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint(item: self.infoStackView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 4/5, constant: 0).isActive = true
        
        self.infoStackView.addArrangedSubview(self.Mimg)
        NSLayoutConstraint.activate([
            self.Mimg.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            self.Mimg.heightAnchor.constraint(equalTo: self.Mimg.widthAnchor)
        ])
        self.infoStackView.addArrangedSubview(self.Mtitle)
        
        // 로그인 버튼 생성
        self.view.addSubview(self.loginStackView)
        NSLayoutConstraint.activate([
            self.loginStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.loginStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.loginStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        ])
        self.loginStackView.addArrangedSubview(self.emailBtn)
        self.loginStackView.addArrangedSubview(self.appleBtn)
        self.loginStackView.addArrangedSubview(self.googleBtn)
    }
}

