//
//  CustomAlertViewController.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/18.
//

import Foundation
import UIKit

// Custom Alert의 취소/확인 버튼 동작 지정
protocol CustomAlertDelegate: class {
    func cancel()   // 취소 버튼 메소드
    func confirm()  // 액션 버튼 메소드
    func done()     // 확인 버튼 메소드
}

enum AlertType {
    case canCancel  // 액션 + 취소 버튼
    case done   // 확인 버튼
}

class CustomAlertViewController: UIViewController {
    
    weak var delegate: CustomAlertDelegate?
    
    //MARK: - UI ProPerties
    lazy var alertType = AlertType.canCancel
    lazy var alertTitle = "(alertTitle)"
    lazy var alertContext = "(alertContext)"
    lazy var cancelText = "(cancelText)"
    lazy var confirmText = "(confirmText)"
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.mainWhite
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = alertTitle
        label.font = .Clutch.subtitleBold
        
        return label
    }()
    
    lazy var contextLabel: UILabel = {
        let label = UILabel()
        label.text = alertContext
        label.font = .Clutch.baseMedium
        
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(cancelText, for: .normal)
        button.titleLabel?.font = .Clutch.smallMedium
        button.setTitleColor(.Clutch.mainDarkGreen, for: .normal)
        button.backgroundColor = .Clutch.mainWhite
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Clutch.mainDarkGreen?.cgColor
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle(confirmText, for: .normal)
        button.titleLabel?.font = .Clutch.smallMedium
        button.setTitleColor(.Clutch.mainWhite, for: .normal)
        button.backgroundColor = .Clutch.mainDarkGreen
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    func setView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        self.view.addSubview(container)
        self.container.addSubview(titleLabel)
        self.container.addSubview(contextLabel)
        self.container.addSubview(actionButton)
        
        // AlertType에 따른 버튼 뷰 처리
        switch self.alertType {
        case .canCancel:
            self.container.addSubview(cancelButton)
            self.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
            
        case .done:
            cancelButton.isHidden = true
            self.actionButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        }
        
    }
    
    // 취소 버튼 메소드
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.cancel()
        }
    }
    
    // 액션 버튼 메소드
    @objc func actionButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.confirm()
        }
    }
    
    // 확인 버튼 메소드
    @objc func doneButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.done()
        }
    }
    
    func setConstraint() {
        container.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(41)
            make.trailingMargin.equalToSuperview().offset(41)
            make.height.equalTo(192)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(32)
        }
        
        contextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(76)
        }
        
        // AlertType에 따른 버튼 레이아웃 처리
        switch self.alertType {
        case .canCancel:
            cancelButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.width.equalTo(actionButton)
                make.trailing.equalTo(actionButton.snp.leading).offset(-12)
                make.height.equalTo(40)
                make.top.equalToSuperview().offset(124)
            }
            
            actionButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(40)
                make.top.equalToSuperview().offset(124)
            }
            
        case .done:
            actionButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(40)
                make.top.equalToSuperview().offset(124)
            }
        }
    }
}

// CustomAlert을 간결하게 재사용하기 위한 메소드 구현
extension CustomAlertDelegate where Self: UIViewController {
    func showCustomAlert(
        alertType: AlertType,
        alertTitle : String,
        alertContext : String,
        cancelText : String? = "취소",
        confirmText : String
    ) {
        lazy var customAlertViewController = CustomAlertViewController()
        customAlertViewController.delegate = self
        
        customAlertViewController.modalTransitionStyle = .crossDissolve
        customAlertViewController.modalPresentationStyle = .overFullScreen
        customAlertViewController.alertType = alertType
        customAlertViewController.alertTitle = alertTitle
        customAlertViewController.alertContext = alertContext
        customAlertViewController.cancelText = cancelText ?? "취소"
        customAlertViewController.confirmText = confirmText
        
        self.present(customAlertViewController, animated: true, completion: nil)
    }
}

