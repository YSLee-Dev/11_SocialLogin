//
//  TitleUILabel.swift
//  11_SocialLogin
//
//  Created by 이윤수 on 2022/03/20.
//

import UIKit

class TitleUILabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(){
        self.font = UIFont.boldSystemFont(ofSize: 23)
        self.numberOfLines = .max
        self.textAlignment = .center
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
