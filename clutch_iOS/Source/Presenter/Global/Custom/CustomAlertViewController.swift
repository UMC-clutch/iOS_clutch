//
//  CustomAlertViewController.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/18.
//

import Foundation
import UIKit

// Custom Alert의 취소/확인 버튼 동작 지정
protocol CustomAlertDelegate {
    func cancel()     // 취소 버튼 동작
    func confirm()   // 확인 버튼 동작
}

enum AlertType {
    case canCancel      // 확인 + 취소 버튼
    case onlyConfirm    // 확인 버튼
}

class CustomAlertViewController: UIViewController {
    
    var delegate: CustomAlertDelegate?
    
    //MARK: - UI ProPerties
    lazy var alertType = AlertType.onlyConfirm
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
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle(confirmText, for: .normal)
        button.titleLabel?.font = .Clutch.smallMedium
        button.setTitleColor(.Clutch.mainWhite, for: .normal)
        button.backgroundColor = .Clutch.mainDarkGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    func setView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.view.addSubview(container)
        self.container.addSubview(titleLabel)
        self.container.addSubview(contextLabel)
        self.container.addSubview(confirmButton)
        
        // AlertType에 따른 버튼 뷰 처리
        switch self.alertType {
        case .canCancel:
            self.container.addSubview(cancelButton)
            
        case .onlyConfirm:
            cancelButton.isHidden = true
        }
        
    }
    
    // 취소 버튼 메소드
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.cancel()
        }
    }
    
    // 확인 버튼 메소드
    @objc func confirmButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.confirm()
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
                make.width.equalTo(confirmButton)
                make.trailing.equalTo(confirmButton.snp.leading).offset(-12)
                make.height.equalTo(40)
                make.top.equalToSuperview().offset(124)
            }
            
            confirmButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(40)
                make.top.equalToSuperview().offset(124)
            }
            
        case .onlyConfirm:
            confirmButton.snp.makeConstraints { make in
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

