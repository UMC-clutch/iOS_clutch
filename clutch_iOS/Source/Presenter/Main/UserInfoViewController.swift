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
    lazy var loginPath = ""
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
    
    lazy var exampleButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("", for: .normal)
        btn.addTarget(self, action: #selector(exampleButtonTapped), for: .touchUpInside)
        btn.isEnabled = true
        return btn
    }()

    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        SetView()
        Constraint()
    }
    
    //MARK: - Network
    func requestLogin() {
        
        let parameter: [String:String] = [
            "oauthId": userInfo.id,
            "name": namelInfo.textInputTextField.text ?? userInfo.name,
            "email": emailInfo.textInputTextField.text ?? userInfo.email,
            "phoneNumber": phoneNumInfo.textInputTextField.text ?? userInfo.phonenumber
        ]
        
        APIManger.shared.callLoginPostRequest(baseEndPoint: .login, addPath: loginPath, parameters: parameter) { JSON in
            // 호출 오류시 처리
            if JSON["check"].boolValue == false {
                self.showCustomAlert(alertType: .done,
                                alertTitle: "오류 발생",
                                alertContext: "다시 시도해주세요.",
                                confirmText: "확인")
                return
            }
            
            let grantType = JSON["information"]["grantType"].stringValue
            let accessToken = JSON["information"]["accessToken"].stringValue
            let accessTokenExpirationTime = JSON["information"]["accessTokenExpirationTime"].int64Value
            let refreshToken = JSON["information"]["refreshToken"].stringValue
            let refreshTokenExpirationTime = JSON["information"]["refreshTokenExpirationTime"].int64Value
            
            //탈퇴 페이지 회원 정보 넘기기
            singleItem.shared.username = self.namelInfo.textInputTextField.text ?? self.userInfo.name

            
            // 테스트
            print(grantType)
            print(accessToken)
            print(accessTokenExpirationTime)
            print(refreshToken)
            print(refreshTokenExpirationTime)
            
            // 로그인 성공, 토큰 저장 처리
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
        [navigationBar, titleLabel, namelInfo ,emailInfo, phoneNumInfo, confirmButton, exampleButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    func infoViewSet() {
        namelInfo.textInputLabel.text = "이름"
        emailInfo.textInputTextField.text = userInfo.name
        emailInfo.textInputTextField.textColor = .black
        
        emailInfo.textInputLabel.text = "이메일 주소"
        emailInfo.textInputTextField.text = userInfo.email
        emailInfo.textInputTextField.textColor = .black
        
        phoneNumInfo.textInputLabel.text = "휴대폰 번호"
        phoneNumInfo.textInputTextField.textColor = .black
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
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(top)
        }
        
        emailInfo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(namelInfo.snp.bottom).offset(top)
        }
        
        phoneNumInfo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(emailInfo.snp.bottom).offset(top)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
        
        exampleButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
            make.size.equalTo(titleLabel.snp.size)
        }
        
    }
    
    @objc func exampleButtonTapped() {
        emailInfo.textInputTextField.text = "dwryu3079@gmail.com"
        phoneNumInfo.textInputTextField.text = "010-3370-3079"
        namelInfo.textInputTextField.text = "류동완"
        emailInfo.textIsEmpty()
        phoneNumInfo.textIsEmpty()
        namelInfo.textIsEmpty()
        self.textCheck()
    }
    
    func textChange() {
        namelInfo.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        emailInfo.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        phoneNumInfo.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
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
