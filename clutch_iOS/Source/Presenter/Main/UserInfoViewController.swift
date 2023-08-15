//
//  UserInfoViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/30.
//

import UIKit

struct Information: Codable {
    public var id: String
    public var name, email, phonenumber: String
}

class UserInfoViewController: UIViewController, CustomAlertDelegate {
    //MARK: - Properties
    lazy var completed = false
    lazy var userInfo = Information(id: "", name: "", email: "", phonenumber: "")
    
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
    
    lazy var namelInfo = TextInputView()
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
    
    //MARK: - Network
    func requestLogin() {
        print("called")
        let parameter = [
            "oauthId": userInfo.id,
            "name": namelInfo.textInputTextField.text ?? userInfo.name,
            "email": emailInfo.textInputTextField.text ?? userInfo.email,
            "phonenumber": phoneNumInfo.textInputTextField.text ?? userInfo.phonenumber
        ]
        
        APIManger.shared.callPostRequest(baseEndPoint: .login, addPath: "/apple/", parameters: parameter) { JSON in
            // 호출 오류시 처리 -- 의도대로 안됨.
            if JSON["check"].boolValue == false {
                print("fail")
                self.showCustomAlert(alertType: .done,
                                alertTitle: "오류 발생",
                                alertContext: "다시 시도해주세요.",
                                confirmText: "확인")
            }
            
            let grnatType = JSON["grnatType"].stringValue
            let accessToken = JSON["accessToken"].stringValue
            let accessTokenExpirationTime = JSON["accessTokenExpirationTime"].intValue
            let refreshToken = JSON["refreshToken"].stringValue
            let refreshTokenExpirationTime = JSON["refreshTokenExpirationTime"].intValue
            
            // 테스트
            print(grnatType)
            print(accessToken)
            print(accessTokenExpirationTime)
            print(refreshToken)
            print(refreshTokenExpirationTime)
            
            // 로그인, 토큰 저장 처리
            APIManger.shared.jwtToken = accessToken
            self.completed = true
            self.showCustomAlert(alertType: .done,
                            alertTitle: "회원가입 완료",
                            alertContext: "정상적으로 가입되었습니다.",
                            confirmText: "확인")
        }
    }
    
    
    
    func SetView() {
        addsubview()
        infoViewSet()
        textChange()
        self.view.backgroundColor = .white
    }
    
    func addsubview() {
        [navigationBar, titleLabel, namelInfo ,emailInfo, phoneNumInfo, confirmButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    func infoViewSet() {
        namelInfo.textInputLabel.text = "이름"
        emailInfo.textInputTextField.text = userInfo.name
        
        emailInfo.textInputLabel.text = "이메일 주소"
        emailInfo.textInputTextField.text = userInfo.email
        
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
        
        namelInfo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(top)
        }
        
        emailInfo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(namelInfo.snp.bottom).offset(top)
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
        namelInfo.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        emailInfo.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        phoneNumInfo.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
    }
    
    @objc func textCheck() {
        let allFieldsFilled =
        namelInfo.textInputTextField.text?.isEmpty == false &&
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
        showCustomAlert(alertType: .canCancel,
                        alertTitle: "회원가입",
                        alertContext: "위 정보로 가입하시겠습니까?",
                        cancelText: "취소",
                        confirmText: "확인")
    }
  
    func cancel() { return }
    
    func confirm() {
        print("confirm")
        requestLogin()
    }
    
    func done() {
        if completed {
            let VC = MainViewController()
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}
