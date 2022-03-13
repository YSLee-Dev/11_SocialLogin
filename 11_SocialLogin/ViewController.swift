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
        stack.backgroundColor = .red
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }

    func viewSet(){
        self.view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true
        
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
    }
}

