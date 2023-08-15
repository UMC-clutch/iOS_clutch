//
//  loginViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/14.
//

import Alamofire
import SwiftyJSON
import UIKit
import AuthenticationServices

class loginViewController: UIViewController {
    //MARK: - UI ProPerties
    let loginview = loginView()
    
    //카카오 로그인 버튼
    lazy var kakaoButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_login_kakao"), for: .normal)
        button.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //애플 로그인 버튼
//    lazy var appleButton:UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "btn_login_apple"), for: .normal)
//        button.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
//
//        return button
//    }()
    lazy var appleButton:ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .continue, authorizationButtonStyle: .black)
        button.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Define Method
    //VC의 기본 view 지정
    override func loadView() {
        view = loginview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetView()
        Constraint()

    }

    
    //뷰 관련 세팅
    func SetView() {
        [appleButton, kakaoButton].forEach { view
            in self.view.addSubview(view) }
        navigationController?.navigationBar.isHidden = true
    }
    
    func Constraint() {
        
        let leading:CGFloat = 30
        let superViewHeight = UIScreen.main.bounds.height
        
        //kakaoButton 오토레이아웃
        kakaoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(superViewHeight * 0.7)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(kakaoButton.snp.width).multipliedBy(0.15)
        }
        //appleButton 오토레이아웃
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(kakaoButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(appleButton.snp.width).multipliedBy(0.15)
            
        }
        
    }
//    //appleButton 클릭 이벤트
//    @objc func appleButtonTapped(_ sender: UIButton) {
//        let VC = UserInfoViewController()
//        navigationController?.pushViewController(VC, animated: true)
//
//    }

    //kakaoButton 클릭 이벤트
    @objc func kakaoButtonTapped(_ sender: UIButton) {
        let VC = UserInfoViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
}


// apple 로그인 처리
extension loginViewController: ASAuthorizationControllerDelegate {
    // apple id 로그인 요청
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // 로그인 수행, 값 받아오는 함수
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print(userIdentifier)
            print((fullName?.familyName ?? "") + (fullName?.givenName ?? ""))
            print(email)
            
            // 회원가입, 로그인
            let VC = UserInfoViewController()
            VC.userInfo.id = userIdentifier
            VC.userInfo.name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
            VC.userInfo.email = email ?? ""
            navigationController?.pushViewController(VC, animated: true)
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
//            let password = passwordCredential.password
            
            // 회원가입, 로그인
            let VC = UserInfoViewController()
            VC.userInfo.id = username
            navigationController?.pushViewController(VC, animated: true)
            
        default:
            break
        }
    }
    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
      // Handle error.
        print("Apple Login Error")
    }
}

extension loginViewController: ASAuthorizationControllerPresentationContextProviding {
    // 애플 로그인 창 띄우는 함수
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
