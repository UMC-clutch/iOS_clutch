//
//  WithdrawViewController.swift
//  clutch_iOS
//
//  Created by 이지웅 on 2023/07/13.
//

import Foundation
import UIKit

class WithdrawViewController: UIViewController {
    // MARK: - UI ProPerties
    let navigationBar = UINavigationBar()
    lazy var withdrawReason = "탈퇴 이유를 선택해주세요"
    
    lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.text = "클러치를 탈퇴하기 전에\n확인해주세요"
        label.font = .Clutch.headtitlebold
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey

        return label
    }()

    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        //실제 text 사용자 이름으로 받아오기 필요
        label.text = "User Name"
        label.font = .Clutch.baseMedium
        label.textColor = .Clutch.textDarkGrey

        return label
    }()

    lazy var underLine1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Clutch.bgGrey

        return view
    }()
    
    lazy var reasonLabel: UILabel = {
        let label = UILabel()
        label.text = "탈퇴 사유"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey

        return label
    }()
    
    lazy var selectReasonButton:UIButton = {
        let button = UIButton()
        button.setTitle(withdrawReason, for: .normal)
        button.setTitleColor(.Clutch.textBlack, for: .normal)
        button.titleLabel?.font = .Clutch.baseMedium
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(selectReasonButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var selectImageView:UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "mypage"))
        
        return imageview
    }()
    
    lazy var underLine2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Clutch.bgGrey

        return view
    }()
    
    lazy var withdrawButton:UIButton = {
        let button = UIButton()
        button.setTitle("탈퇴하기", for: .normal)
        button.setTitleColor(.Clutch.textDarkGrey, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(withdrawButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.bgGrey
        // Highlighted 상태일 때 배경 및 텍스트 색상
//        let iamge = image(withColor: .Clutch.mainDarkGreen!)
//        button.setBackgroundImage(iamge, for: .highlighted)
//        button.setTitleColor(.Clutch.mainWhite, for: .highlighted)
        return button
    }()
    
    // MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        setData()
        setView()
        setConstraint()
    }
        
    //MARK: - Set UI
    func setView() {
        [navigationBar, checkLabel, nameLabel, userNameLabel, underLine1, reasonLabel, selectReasonButton, selectImageView, underLine2, withdrawButton].forEach { view in
            self.view.addSubview(view)
        }
        setNavigationBar()
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        let backButton = UIBarButtonItem(
            image:UIImage(systemName: "chevron.backward"),
            style: .plain, target: self,
            action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Clutch.mainWhite // 배경색 변경
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }
    
    func setConstraint() {
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
        }
        
        checkLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            //작은 폰에서 넘 아래로 감. 동적으로 맞춰는게 좋을까?
            make.top.equalToSuperview().offset(131)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(234)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(267)
        }

        underLine1.snp.makeConstraints{ make in
            make.height.equalTo(2)
            make.top.equalToSuperview().offset(293)
            make.leading.equalToSuperview().offset(17)
            make.trailingMargin.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
        }
        
        reasonLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(335)
        }
        
        selectReasonButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().offset(-27)
            make.top.equalToSuperview().offset(368)
//            make.top.equalTo(reasonLabel.snp.bottom).offset(10)
        }
        
        selectImageView.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-27)
            make.centerY.equalTo(selectReasonButton)
        }
        
        underLine2.snp.makeConstraints{ make in
            make.height.equalTo(2)
            make.top.equalToSuperview().offset(394)
            make.leading.equalToSuperview().offset(17)
            make.trailingMargin.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailingMargin.equalToSuperview().offset(16)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}

extension WithdrawViewController: CustomPopupDelegate, CustomAlertDelegate {
    // MARK: - Define Method
    @objc func backButtonTapped() {
        // 이전 view로 돌아가는 코드 필요
        print("Back Button Tapped")
    }
    
    @objc func selectReasonButtonTapped() {
        showCustomPopup(popupTitle: "탈퇴 사유를 알려주세요",
                        popupList: ["서비스 이용이 불편함",
                                    "문제가 해결되어 이용 의사가 없음",
                                    "개인정보 및 보안 우려",
                                    "서비스 대상이 아님"]
        )
    }
    
    func getSelectedCell(selected: String) {
        withdrawReason = selected
        selectReasonButton.setTitle(withdrawReason, for: .normal)
    }
    
    @objc func withdrawButtonTapped(_ sender: UIButton) {
        showCustomAlert(alertType: .canCancel,
                        alertTitle: "탈퇴하기",
                        alertContext: "정말로 탈퇴하시겠습니까?",
                        cancelText: "취소",
                        confirmText: "탈퇴하기")
    }
    
    func cancel() {
        print("custom cancel Button Tapped")
    }
    
    func confirm() {
        print("custom action Button Tapped")
        // 탈퇴하기 API 호출
        let response = "200"
        // 정상적으로 호출되면 메시지 출력, 창 닫기
        if response == "200" {
            showCustomAlert(alertType: .done,
                            alertTitle: "탈퇴 완료",
                            alertContext: "정상적으로 탈퇴되었습니다.",
                            confirmText: "확인")
            // 창 닫는 코드
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
        print("custom done Button Tapped")
    }
    
}
