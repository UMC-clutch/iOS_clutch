//
//  ReportDoneViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/30.
//

import UIKit

class ReportDoneViewController: UIViewController, UIScrollViewDelegate {
    //MARK: - UI propereties
    lazy var canceled = false
    
    //스크롤을 위한 스크롤 뷰
    lazy var scrollview:UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    //스크롤 뷰 안에 들어갈 내용을 표시할 뷰
    let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    //스크롤 기능을 탑재한 버튼
    lazy var doneButton:UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.mainDarkGreen
        // Highlighted 상태일 때 배경색
        let iamge = image(withColor: .Clutch.mainGreen!)
        button.setBackgroundImage(iamge, for: .highlighted)
        
        return button
    }()
    
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("신고 취소", for: .normal)
        button.setTitleColor(.Clutch.mainDarkGreen, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.mainWhite
        // Highlighted 상태일 때 배경색
        let iamge = image(withColor: .Clutch.mainGreen!)
        button.setBackgroundImage(iamge, for: .highlighted)
        
        return button
    }()
    
    let reportDoneView = ReportDoneView()
    
    //MARK: - define method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        constraints()
    }
    
    //뷰관련 셋
    func setView() {
        addsubview()
        setscrollview()
        self.view.backgroundColor = .Clutch.mainWhite
    }
    
    //addsubview
    func addsubview() {
        [scrollview, doneButton, cancelButton].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        [reportDoneView].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //스크롤 뷰관련 셋
    func setscrollview() {
        scrollview.delegate = self
        
    }
    
    func constraints() {
        let spacing:CGFloat = 16
        //스크롤 뷰 오토레이아웃
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //contentView 오토레이아웃
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.frame.height * 1.3)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(spacing)
            make.width.equalTo((self.view.frame.width - spacing * 3)/2)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
        //버튼 오토레이아웃
        doneButton.snp.makeConstraints { make in
            make.leading.equalTo(cancelButton.snp.trailing).offset(spacing)
            make.width.equalTo((self.view.frame.width - spacing * 3)/2)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
        
        
        reportDoneView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges)
        }
    }
    
    // 버튼 클릭 시 스크롤되도록 하는 메서드
    @objc func doneButtonTapped(_ sender: UIButton) {
        if let VC = navigationController?.viewControllers.first(where: {$0 is MainViewController}) {
                    navigationController?.popToViewController(VC, animated: true)
        }
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        showCustomAlert(alertType: .canCancel,
                        alertTitle: "신고 취소",
                        alertContext: "정말로 신고를 철회하시겠습니까??",
                        cancelText: "닫기",
                        confirmText: "신고취소")
    }
    
}

//MARK: - extension
extension ReportDoneViewController: CustomAlertDelegate {
    func cancel() {
        print("custom cancel Button Tapped")
    }
    
    func confirm() {
        print("custom action Button Tapped")
        // 탈퇴하기 API 호출
        let response = 200
        if response == 200 {
            canceled = true
        }
        // 정상적으로 호출되면 메시지 출력
        if canceled {
            showCustomAlert(alertType: .done,
                            alertTitle: "취소 완료",
                            alertContext: "신고 내역이 정상적으로 삭제되었습니다",
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
        if canceled {
            if let VC = navigationController?.viewControllers.first(where: {$0 is MainViewController}) {
                        navigationController?.popToViewController(VC, animated: true)
            }
        }
    }
}
