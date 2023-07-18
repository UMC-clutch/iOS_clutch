//
//  CustomAlertViewController.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/18.
//

import Foundation
import UIKit

enum AlertType {
    case onlyConfirm    // 확인 버튼
    case canCancel      // 확인 + 취소 버튼
}

class CustomAlertViewController: UIViewController {
    
    //MARK: - UI ProPerties

    var alertTitle = "(alertTitle)"
    var alertContext = "(alertContext)"
    var cancelText = "(cancelText)"
    var confirmText = "(confirmText)"
    
    lazy var container: UIView = {
        let stackview = UIView()
        stackview.backgroundColor = .Clutch.mainWhite
        stackview.layer.cornerRadius = 16
        stackview.layer.borderWidth = 1
        stackview.layer.borderColor = UIColor.black.cgColor
//        stackview.axis = .vertical
        
        return stackview
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
//
//    lazy var buttonContainer: UIStackView = {
//        let stackview = UIStackView()
//        stackview.axis = .horizontal
//        stackview.spacing = 12
//
//        return stackview
//    }()
//
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(cancelText, for: .normal)
        button.titleLabel?.font = .Clutch.smallMedium
        button.setTitleColor(.Clutch.mainDarkGreen, for: .normal)
        button.backgroundColor = .Clutch.mainWhite
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Clutch.mainDarkGreen?.cgColor
        
        return button
    }()
    
    lazy var confirmButton: UIButton = {
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
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
//        buttonContainer.addArrangedSubview(cancelButton)
//        buttonContainer.addArrangedSubview(confirmButton)
        
        [titleLabel, contextLabel, cancelButton, confirmButton].forEach { view
            in self.container.addSubview(view) }
        self.view.addSubview(container)
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
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(confirmButton)
            make.trailing.equalTo(confirmButton.snp.leading).offset(-12)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(124)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
//            make.leading.equalTo(6)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(124)
        }
        
//        buttonContainer.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.trailingMargin.equalToSuperview().offset(20)
//            make.height.equalTo(40)
//            make.top.equalToSuperview().offset(90)
//        }
    }
}
