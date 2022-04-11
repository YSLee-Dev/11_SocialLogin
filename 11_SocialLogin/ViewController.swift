//
//  ViewController.swift
//  11_SocialLogin
//
//  Created by 이윤수 on 2022/03/13.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class ViewController: UIViewController {

    private var currentNonce:String?
    
    var infoStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var Mtitle : TitleUILabel = {
        let label = TitleUILabel()
        label.text = "소셜로그인으로 편하게 로그인 할 수 있어요!\n아래 버튼을 눌러 로그인 방법을 선택하세요."
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
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration.init(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self){user, error in
            guard error == nil else { return }
            
            guard let authentication = user?.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken!, accessToken: authentication.accessToken)
            // access token 부여 받음

            // 파이어베이스에 인증정보 등록
            Auth.auth().signIn(with: credential) {_,_ in
            // token을 넘겨주면, 성공했는지 안했는지에 대한 result값과 error값을 넘겨줌
                self.navigationController?.pushViewController(MainViewController(), animated: true)
            }
            
        }
        
    }
    
    @objc func appleClick(_ sender:Any){
        startSignInWithAppleFlow()
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

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print ("Error Apple sign in: %@", error)
                    return
                }
                self.navigationController?.pushViewController(MainViewController(), animated: true)
            }
        }
    }
}

extension ViewController {
    func startSignInWithAppleFlow() {
        // 암호화된 nonce 생성
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

extension ViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
