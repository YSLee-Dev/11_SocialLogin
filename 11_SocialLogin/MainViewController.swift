//
//  MainViewController.swift
//  11_SocialLogin
//
//  Created by 이윤수 on 2022/03/20.
//

import UIKit

class MainViewController: UIViewController {

    var Mtitle : UILabel = {
        let label = TitleUILabel()
        label.text = "환영합니다."
        return label
    }()
    
    var backBtn : UIButton = {
        let btn = LoginUIButton()
        btn.setTitle("LOGOUT", for: .normal)
        btn.addTarget(self, action: #selector(logoutBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSet()
    }
    
    @objc private func logoutBtnClick(_ sender:Any){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func viewSet(){
        // 네비게이션 바 숨김, 제스처 비활성화
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.view.addSubview(self.Mtitle)
        NSLayoutConstraint.activate([
            self.Mtitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.Mtitle.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        self.view.addSubview(self.backBtn)
        NSLayoutConstraint.activate([
            self.backBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.backBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.backBtn.topAnchor.constraint(equalTo: self.Mtitle.bottomAnchor, constant: -15),
            self.backBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
