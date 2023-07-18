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

        [titleLabel, contextLabel, cancelButton, confirmButton].forEach { view
            in self.container.addSubview(view) }
        self.view.addSubview(container)
    }
    
    @objc func cancelButtonTapped() {
        //취소 버튼 이벤트 처리
        print("Cancel Button Tapped")
    }
    
    @objc func confirmButtonTapped() {
        //확인 버튼 이벤트 처리
        print("Confirm Button Tapped")
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
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(124)
        }
    }
}
