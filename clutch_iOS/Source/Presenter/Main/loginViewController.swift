//
//  loginViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/14.
//

import UIKit

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
    lazy var appleButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_login_apple"), for: .normal)
        button.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
        
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

    //MARK: - Properties
    
    //MARK: - Set Ui
    //뷰 관련 세팅
    func SetView() {
        [appleButton, kakaoButton].forEach { view
            in self.view.addSubview(view) }
    }

    func Constraint() {
        //kakaoButton 오토레이아웃
        kakaoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(600)
            make.width.equalTo(332)
            make.height.equalTo(50)
        }
        //appleButton 오토레이아웃
        appleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(kakaoButton.snp.bottom).offset(20)
            make.width.equalTo(332)
            make.height.equalTo(50)
        }
        
    }
    //appleButton 클릭 이벤트
    @objc func appleButtonTapped(_ sender: UIButton) {
        let mainVC = MainViewController()
           mainVC.modalPresentationStyle = .fullScreen
           present(mainVC, animated: true)

    }
    //kakaoButton 클릭 이벤트
    @objc func kakaoButtonTapped(_ sender: UIButton) {
        let mainVC = MainViewController()
           mainVC.modalPresentationStyle = .fullScreen
           present(mainVC, animated: true)
    }

}
