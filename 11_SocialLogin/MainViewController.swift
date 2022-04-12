//
//  MainViewController.swift
//  11_SocialLogin
//
//  Created by 이윤수 on 2022/03/20.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    var Mtitle : TitleUILabel = {
        let label = TitleUILabel()
        label.text = "환영합니다."
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var backBtn : LoginUIButton = {
        let btn = LoginUIButton()
        btn.setTitle("LOGOUT", for: .normal)
        btn.addTarget(self, action: #selector(logoutBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    var pwResetBtn : LoginUIButton = {
        let btn = LoginUIButton()
        btn.setTitle("PASSWORD RESET", for: .normal)
        btn.addTarget(self, action: #selector(pwResetBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    var profileBtn : LoginUIButton = {
        let btn = LoginUIButton()
        btn.setTitle("PROFILE UPDATE", for: .normal)
        btn.addTarget(self, action: #selector(profileBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSet()
        self.userInfo()
    }
    
    @objc private func logoutBtnClick(_ sender:Any){
        let firebaseAuth = Auth.auth()
        
        do{
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            print("Error: \(signOutError.localizedDescription)")
        }
    }
    
    @objc private func pwResetBtnClick(_ sender:Any){
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if error != nil {return}
            let alert = UIAlertController(title: "메일 발송됨", message: "비밀번호 초기화 메일이 발송되었습니다.\n메일을 확인해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    @objc private func profileBtnClick(_ sender:Any){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        let alert = UIAlertController(title: "NAME INSERT", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
            changeRequest?.displayName = alert.textFields?[0].text
            changeRequest?.commitChanges{[weak self] _ in
                self?.Mtitle.text = Auth.auth().currentUser?.displayName ?? "환영합니다. 고객님"
            }
        })
        self.present(alert, animated: true)
        
    }
    
    private func viewSet(){
        // 네비게이션 바 숨김, 제스처 비활성화
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.view.addSubview(self.Mtitle)
        NSLayoutConstraint.activate([
            self.Mtitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.Mtitle.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.Mtitle.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
        ])
        
        // 유저 로그인 방식 확인
        let userLoginType = Auth.auth().currentUser?.providerData[0].providerID == "password"
        self.pwResetBtn.isHidden = !userLoginType
        
        self.view.addSubview(self.backBtn)
        self.view.addSubview(self.pwResetBtn)
        self.view.addSubview(self.profileBtn)
        NSLayoutConstraint.activate([
            self.backBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.backBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.backBtn.topAnchor.constraint(equalTo: self.Mtitle.bottomAnchor, constant: 15),
            self.backBtn.heightAnchor.constraint(equalToConstant: 50),
            
            self.pwResetBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.pwResetBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.pwResetBtn.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: 15),
            self.pwResetBtn.heightAnchor.constraint(equalToConstant: 50),
            
            self.profileBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.profileBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.profileBtn.topAnchor.constraint(equalTo: self.pwResetBtn.bottomAnchor, constant: 15),
            self.profileBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func userInfo(){
        let email = Auth.auth().currentUser?.email ?? "고객"
        Mtitle.text = "환영합니다. \(email)님"
    }
}
