//
//  ProfileViewController.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/07/17.
//

import Foundation
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    // MARK: - UI ProPerties
    // UINavigationBar 선언("< 회원 정보 확인")
    lazy var navigationBar = UINavigationBar()
    
    // 인스턴스에 InputScreen() 할당
    let nameInput = InputScreen()
    let mailInput = InputScreen()
    let phoneNumberInput = InputScreen()
    
    // MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setData()
        setView()
        Constraint()
        request()
    }
    
    // MARK: - Network
    func request() {
        APIManger.shared.callGetRequest(baseEndPoint: .user, addPath: "/users") { JSON in
            let id = JSON["information"]["id"].stringValue
            let name = JSON["information"]["name"].stringValue
            let eamil = JSON["information"]["email"].stringValue
            let phonenumber = JSON["information"]["phonenumber"].stringValue
            
            let information = Information(id: id, name: name, email: eamil, phonenumber: phonenumber)
            
            DispatchQueue.main.async {
                self.nameInput.textLabel.text = information.name
                self.mailInput.textLabel.text = information.email
                self.phoneNumberInput.textLabel.text = information.phonenumber
            }
        }
    }
    
    func setView() {
        [navigationBar, nameInput.titleLabel, nameInput.textLabel, nameInput.underLine, mailInput.titleLabel, mailInput.textLabel, mailInput.underLine, phoneNumberInput.titleLabel, phoneNumberInput.textLabel, phoneNumberInput.underLine].forEach { view in
            self.view.addSubview(view)
        }
        
        navigationBarSet()
    }
    
    func setData() {
        nameInput.titleLabel.text = "이름"
        nameInput.textLabel.text = "조혜원" // -> 회원 정보 데이터로 처리
        
        mailInput.titleLabel.text = "이메일"
        mailInput.textLabel.text = "clutch@kakao.com"
        
        phoneNumberInput.titleLabel.text = "휴대폰 번호"
        phoneNumberInput.textLabel.text = "010-1234-5679"
        
    }
    
    func navigationBarSet() {
        let navigationItem = UINavigationItem()
        navigationItem.title = "회원 정보 확인"
//        let iamge = UIImage(systemName: "chevron.backward")
        let backButton = UIBarButtonItem(image:UIImage(named: "btn_arrow_big"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Clutch.mainWhite // 배경색 변경
        navigationBar.shadowImage = UIImage() // 테두리 없애기
        self.navigationBar.tintColor = .black // 백버튼 색깔 변경
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // 제목 텍스트 색상
            .font: UIFont.Clutch.subheadBold
        ]
        navigationBar.titleTextAttributes = titleTextAttributes // 제목 스타일 적용
    }
    
    // pop VC
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func Constraint() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
        }
        
        nameInput.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(navigationBar.snp.bottom).offset(75)
        }
        
        nameInput.textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(nameInput.titleLabel.snp.bottom).offset(4)
        }
        
        nameInput.underLine.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(2)
            make.top.equalTo(nameInput.textLabel.snp.bottom).offset(4)
        }
        
        mailInput.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(nameInput.underLine.snp.bottom).offset(40)
        }
        
        mailInput.textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(mailInput.titleLabel.snp.bottom).offset(4)
        }
        
        mailInput.underLine.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(2)
            make.top.equalTo(mailInput.textLabel.snp.bottom).offset(4)
        }
        
        phoneNumberInput.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(mailInput.underLine.snp.bottom).offset(40)
        }
        
        phoneNumberInput.textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(phoneNumberInput.titleLabel.snp.bottom).offset(4)
        }
        
        phoneNumberInput.underLine.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(2)
            make.top.equalTo(phoneNumberInput.textLabel.snp.bottom).offset(4)
        }
        
    }
    
}


