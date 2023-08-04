//
//  UserInfoViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/30.
//

import UIKit

class UserInfoViewController: UIViewController {
    //MARK: - UI ProPerties
    public lazy var navigationBar = UINavigationBar()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "회원 정보를 입력해주세요."
        label.numberOfLines = 2
        label.font = .Clutch.headtitlebold
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    let emailInfo = TextInputView()
    let phoneNumInfo = TextInputView()

    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        SetView()
        Constraint()
    }
    
    func SetView() {
        addsubview()
        infoViewSet()
        self.view.backgroundColor = .white
    }
    
    func addsubview() {
        [navigationBar, titleLabel, emailInfo, phoneNumInfo].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    func infoViewSet() {
        emailInfo.textInputLabel.text = "이메일 주소"
        phoneNumInfo.textInputLabel.text = "휴대폰 번호"
    }
    
    func Constraint() {
        let leading = 16
        let top = 40
        
        
        navigationBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
        }
        
        emailInfo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(top)
        }
        
        phoneNumInfo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(emailInfo.snp.bottom).offset(top)
        }
        
        
        
    }
  

}
