//
//  UserInfoViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/30.
//

import UIKit

class UserInfoViewController: UIViewController, CustomAlertDelegate {
    //MARK: - Properties
    lazy var completed = false
    
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
    
    lazy var emailInfo = TextInputView()
    lazy var phoneNumInfo = TextInputView()
    
    lazy var confirmButton:UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.bgGrey
        button.isEnabled = false
        
        return button
    }()

    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        SetView()
        Constraint()
    }
    
    func SetView() {
        addsubview()
        infoViewSet()
        textChange()
        self.view.backgroundColor = .white
    }
    
    func addsubview() {
        [navigationBar, titleLabel, emailInfo, phoneNumInfo, confirmButton].forEach { view in
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
        
        confirmButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-36)
        }
        
    }
    
    func textChange() {
        emailInfo.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        phoneNumInfo.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
    }
    
    @objc func textCheck() {
        let allFieldsFilled =
        emailInfo.textInputTextField.text?.isEmpty == false &&
        phoneNumInfo.textInputTextField.text?.isEmpty == false
        
        
        if allFieldsFilled {
            confirmButton.backgroundColor = .Clutch.mainDarkGreen
            confirmButton.setTitleColor(.Clutch.mainWhite, for: .normal)
            confirmButton.isEnabled = true
        } else {
            confirmButton.backgroundColor = .Clutch.bgGrey
            confirmButton.isEnabled = false
        }
    }
    
    @objc func confirmButtonTapped(_ sender: UIButton) {
        // 입력조건 확인 후
        lazy var response = 200
        if response == 200 {
            completed = true
        }
        
        if completed {
            showCustomAlert(alertType: .done,
                            alertTitle: "회원가입 완료",
                            alertContext: "정상적으로 가입되었습니다.",
                            confirmText: "확인")
        }
        else {
            showCustomAlert(alertType: .done,
                            alertTitle: "오류 발생",
                            alertContext: "다시 시도해주세요.",
                            confirmText: "확인")
        }
    }
  
    func cancel() { return }
    
    func confirm() { return }
    
    func done() {
        if completed {
            let VC = MainViewController()
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}
