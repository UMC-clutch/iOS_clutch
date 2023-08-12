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
    //appleButton 클릭 이벤트
    @objc func appleButtonTapped(_ sender: UIButton) {
        print(1)
        let VC = UserInfoViewController()
        navigationController?.pushViewController(VC, animated: true)

    }
    //kakaoButton 클릭 이벤트
    @objc func kakaoButtonTapped(_ sender: UIButton) {
        let VC = UserInfoViewController()
        navigationController?.pushViewController(VC, animated: true)
    }

}

