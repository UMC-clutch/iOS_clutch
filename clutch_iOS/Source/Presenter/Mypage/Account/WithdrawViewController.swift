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
    lazy var navigationBar = UINavigationBar()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "클러치를 탈퇴하기 전에\n확인해주세요"
        label.font = .Clutch.headtitlebold
        label.numberOfLines = 2
        label.textColor = .Clutch.textBlack
        
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
        button.setTitle("탈퇴 이유를 선택해주세요", for: .normal)
        button.setTitleColor(.Clutch.textBlack, for: .normal)
        button.titleLabel?.font = .Clutch.baseMedium
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(selectReasonButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var selectImageView:UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "btn_arrow_small"))
        imageview.transform = imageview.transform.rotated(by: .pi*0.5)
        
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
        button.isEnabled = false
        
        return button
    }()
    
    // MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        setConstraint()
    }
        
    //MARK: - Set UI
    func setView() {
        [navigationBar, titleLabel, nameLabel, userNameLabel, underLine1, reasonLabel, selectReasonButton, selectImageView, underLine2, withdrawButton].forEach { view in
            self.view.addSubview(view)
        }
        setNavigationBar()
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        let backButton = UIBarButtonItem(
            image:UIImage(named: "btn_arrow_big"),
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
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(navigationBar.snp.bottom).offset(39)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }

        underLine1.snp.makeConstraints{ make in
            make.height.equalTo(2)
            make.top.equalTo(userNameLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
            make.centerX.equalToSuperview()
        }
        
        reasonLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(underLine1.snp.bottom).offset(40)
        }
        
        selectReasonButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().offset(-27)
            make.top.equalTo(reasonLabel.snp.bottom).offset(10)
        }
        
        selectImageView.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-27)
            make.centerY.equalTo(selectReasonButton)
        }
        
        underLine2.snp.makeConstraints{ make in
            make.height.equalTo(2)
            make.top.equalTo(selectReasonButton.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
            make.centerX.equalToSuperview()
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
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
        if selected == "" { return }
        
        selectReasonButton.setTitle(selected, for: .normal)
        
        withdrawButton.backgroundColor = .Clutch.mainDarkGreen
        withdrawButton.setTitleColor(.Clutch.mainWhite, for: .normal)
        withdrawButton.isEnabled = true
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
