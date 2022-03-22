//
//  EmailAddViewController.swift
//  11_SocialLogin
//
//  Created by 이윤수 on 2022/03/17.
//

import UIKit
import FirebaseAuth

class EmailAddViewController : UIViewController {
    
    var mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var Mtitle : UILabel = {
        let label = TitleUILabel()
        label.adjustsFontSizeToFitWidth = true
        label.text = "사용하실 Email/PW를 입력해주세요."
        return label
    }()
    
    var emailTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.borderStyle = .none
        tf.placeholder = "Email"
        tf.layer.cornerRadius = 25
        tf.layer.borderColor = UIColor.white.cgColor
        tf.keyboardType = .emailAddress
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
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }
    
    @objc func okBtnClick(_ sender:Any){
        
        //Firebase 이메일, 비밀번호 인증
        let email = emailTF.text ?? ""
        let pw = pwTF.text ?? ""
        
        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: pw) {[weak self] authResult, error in
            guard let self = self else{return}
            
            if let error = error{
                let code = (error as NSError).code
                
                switch code{
                case 17007: // 이미 가입한 계정일 때
                    // 로그인 하기
                    self.loginUser(email: email, pw: pw)
                default:
                    self.Mtitle.text = error.localizedDescription
                }
            }else{
                self.navigationController?.pushViewController(MainViewController(), animated: true)
            }
        }
    }

    private func viewSet(){
        self.view.backgroundColor = .black
        
        // 네비게이션 부분
        self.title = "Email/PW"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(okBtnClick(_:)))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationController?.isNavigationBarHidden = false
        // 델리게이트 설정
        self.pwTF.delegate = self
        self.emailTF.delegate = self
        
        // 오토 레이아웃
        self.view.addSubview(self.mainStackView)
        NSLayoutConstraint.activate([
            self.mainStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        self.mainStackView.addArrangedSubview(self.Mtitle)
        self.mainStackView.addArrangedSubview(self.emailTF)
        self.mainStackView.addArrangedSubview(self.pwTF)
        NSLayoutConstraint.activate([
            self.emailTF.heightAnchor.constraint(equalToConstant: 50),
            self.pwTF.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // 이메일 부분으로 바로 가기
        self.emailTF.becomeFirstResponder()
    }
    
    private func loginUser(email:String, pw:String){
        Auth.auth().signIn(withEmail: email, password: pw){[weak self] _, error in
            guard let self = self else {return}
            
            if let error = error {
                self.Mtitle.text = error.localizedDescription
            }else{
                self.navigationController?.pushViewController(MainViewController(), animated: true)
            }
        }
    }
}

extension EmailAddViewController : UITextFieldDelegate {
    
    // return 키 눌렀을 때 키보드 내리기
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
     
    func textFieldDidEndEditing(_ textField: UITextField) {
        let email = self.emailTF.text == ""
        let pw = self.pwTF.text == ""
        
        self.navigationItem.rightBarButtonItem?.isEnabled = !email && !pw
    }
}
