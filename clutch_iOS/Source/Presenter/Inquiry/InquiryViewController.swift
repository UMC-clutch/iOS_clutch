//
//  InquiryViewController.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/07/18.
//

import Foundation
import UIKit
import SnapKit
import MessageUI

class InquiryViewController: UIViewController {
    //MARK: - Properties
    lazy var completed = false
    
    // MARK: - UI ProPerties
    // UINavigationBar 선언("< 문의하기")
    public lazy var navigationBar = UINavigationBar()
    
    // 인스턴스에 InputScreen() 할당
    let nameInput = InputScreen()
    let categoryInput = InputScreen()
    let inquiryInput = InputScreen()
    
    // 문의 유형 선택 버튼, 팝업
    lazy var selectTypeButton:UIButton = {
        let button = UIButton()
        button.setTitle("문의 유형을 선택해주세요", for: .normal)
        button.setTitleColor(.Clutch.textBlack, for: .normal)
        button.titleLabel?.font = .Clutch.baseMedium
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(selectTypeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var selectImageView:UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "btn_arrow_small"))
        imageview.transform = imageview.transform.rotated(by: .pi*0.5)
        
        return imageview
    }()
    
    // 텍스트뷰
    lazy var placeholder = "어떤 내용이 궁금하신가요?"
    
    public lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.text = placeholder
        textView.font = UIFont.Clutch.baseMedium
        textView.textColor = UIColor.Clutch.textDarkGrey
        textView.backgroundColor = UIColor.Clutch.bgGrey
        textView.layer.cornerRadius = 8
        textView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainerInset = .init(top: 18, left: 23, bottom: 18, right: 23)
        textView.scrollIndicatorInsets = .init(top: 18, left: 10, bottom: 18, right: 23)
        
        return textView
    }()
    
    // UIButton 선언("문의하기")
    lazy var inquiryButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .Clutch.bgGrey
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .Clutch.subheadMedium
        btn.setTitleColor(.Clutch.textDarkGrey, for: .normal)
        btn.setTitle("문의하기", for: .normal)
        btn.addTarget(self, action: #selector(inquirywButtonTapped), for: .touchUpInside)
        btn.isEnabled = false
        
        return btn
    }()
    
    // MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setData()
        setView()
        Constraint()
        request()
    }
    
    func setView() {
        [navigationBar, nameInput.titleLabel, nameInput.textLabel, nameInput.underLine, categoryInput.titleLabel, selectTypeButton, selectImageView, categoryInput.underLine, inquiryInput.titleLabel, textView, inquiryButton].forEach { view in
            self.view.addSubview(view)
        }
        navigationBarSet()
    }
    
    //MARK: - Network
    func request() {
        APIManger.shared.callGetRequest(baseEndPoint: .user, addPath: "/users") { JSON in
            let email = JSON["information"]["email"].stringValue
            let information = Information(id: "", name: "", email: email, phonenumber: "")

            DispatchQueue.main.async {
                self.nameInput.textLabel.text = information.email
            }
        }
    }
    
    func setData() {
        nameInput.titleLabel.text = "이메일"
        nameInput.textLabel.text = "sample@example.com"
        
        categoryInput.titleLabel.text = "문의 유형"
        categoryInput.textLabel.text = "카테고리를 선택해주세요"
        
        inquiryInput.titleLabel.text = "문의 내용"
        inquiryInput.textLabel.text = "내용을 적어주세요"
    }
    
    func navigationBarSet() {
        let navigationItem = UINavigationItem()
        navigationItem.title = "문의하기"
//        let iamge = UIImage(systemName: "chevron.backward")
        let backButton = UIBarButtonItem(image: UIImage(named: "btn_arrow_big"), style: .plain, target: self, action: #selector(backButtonTapped))
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
            make.top.equalTo(navigationBar.snp.bottom).offset(50)
        }
        
        nameInput.textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(nameInput.titleLabel.snp.bottom).offset(6)
        }
        
        nameInput.underLine.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(2)
            make.top.equalTo(nameInput.textLabel.snp.bottom).offset(2)
        }
        
        categoryInput.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(nameInput.underLine.snp.bottom).offset(40)
        }
        
        selectTypeButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().offset(-27)
            make.top.equalTo(categoryInput.titleLabel.snp.bottom).offset(10)
        }
        
        selectImageView.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-27)
            make.centerY.equalTo(selectTypeButton)
        }
        
        categoryInput.underLine.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(2)
            make.top.equalTo(selectTypeButton.snp.bottom).offset(6)
        }
        
        inquiryInput.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(categoryInput.underLine.snp.bottom).offset(40)
        }
        
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(inquiryInput.titleLabel.snp.bottom).offset(6)
            make.height.equalTo(200)
        }
        
        inquiryButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
        
    }
}

//MARK: - extension
extension InquiryViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension InquiryViewController: CustomPopupDelegate, CustomAlertDelegate, UITextViewDelegate {
    // MARK: - Define Method
    @objc func selectTypeButtonTapped() {
        showCustomPopup(popupTitle: "문의 유형",
                        popupList: ["서비스 이용 문의",
                                    "오류 및 버그 신고",
                                    "소송 진행상황 문의",
                                    "법률 관련 문의"]
        )
    }
    
    func getSelectedCell(selected: String) {
        
        if selected == "" { return }
        
        selectTypeButton.setTitle(selected, for: .normal)
        
    }
    
    @objc func inquirywButtonTapped(_ sender: UIButton) {
        showCustomAlert(alertType: .canCancel,
                        alertTitle: "문의하기",
                        alertContext: "위 내용으로 문의하시겠습니까?",
                        cancelText: "취소",
                        confirmText: "문의하기")
        
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients(["jhh980622@naver.com"])
            mailComposer.setSubject("클러치 문의")
            
            if let inquiryText = textView.text {
                mailComposer.setMessageBody(inquiryText, isHTML: false)
            }
            
            present(mailComposer, animated: true, completion: nil)
        } else {
            print("메일 전송에 실패했습니다")
        }
    }
    
    func cancel() {
        print("custom cancel Button Tapped")
    }
    
    func confirm() {
        print("custom action Button Tapped")
        // 문의하기 API 호출
        let response = "200"
        if response == "200" {
            completed = true
        }
        // 정상적으로 호출되면 메시지 출력, 창 닫기
        if completed {
            showCustomAlert(alertType: .done,
                            alertTitle: "문의 완료",
                            alertContext: "정상적으로 접수되었습니다.",
                            confirmText: "확인")
        }
        // 오류 발생시 메시지 출력
        else {
            showCustomAlert(alertType: .done,
                            alertTitle: "오류 발생",
                            alertContext: "다시 시도해주세요.",
                            confirmText: "확인")
        }
    }
    
    func done() {
        if completed {
            navigationController?.popViewController(animated: true)
        }
    }
    
    //TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        /// 플레이스홀더
        if textView.text == placeholder {
            self.textView.textColor = .Clutch.textBlack
            self.textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //플레이스홀더
        if textView.text.isEmpty {
            self.textView.textColor = UIColor.Clutch.textDarkGrey
            self.textView.text = placeholder
        }
        
        //textview에 내용입력, selectTypeButton을 통해 문의 사유를 선택했을 시 버튼 활성 화
        if textView.text.isEmpty || textView.text == placeholder || selectTypeButton.title(for: .normal) == "문의 유형을 선택해주세요" {
            inquiryButton.backgroundColor = .Clutch.bgGrey
            inquiryButton.setTitleColor(.Clutch.mainWhite, for: .normal)
            inquiryButton.isEnabled = false
        } else {
            
            inquiryButton.backgroundColor = .Clutch.mainDarkGreen
            inquiryButton.setTitleColor(.Clutch.mainWhite, for: .normal)
            inquiryButton.isEnabled = true
        }
    }
}
