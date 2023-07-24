//
//  SmallTextInputView.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/24.
//

import UIKit

class SmallTextInputView: UIView {
    //MARK: - UI ProPerties
    lazy var textInputLabel:UILabel = {
        let label = UILabel()
        label.text = "근저당액"
        label.font = UIFont.Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var textInputTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "입력하세요"
        textField.backgroundColor = .white
        textField.font = .Clutch.subheadRegular
        
        return textField
    }()
    
    lazy var underLine:UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        
        return view
    }()
    
    lazy var leftLabel:UILabel = {
        let label = UILabel()
        label.text = "동"
        label.font = UIFont.Clutch.subheadRegular
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    
    
    
    //MARK: - Define Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetView()
        Constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Set Ui
    func SetView() {
        self.backgroundColor = .white
        textInputTextField.delegate = self
        addsubview()
        
    }
    
    func addsubview() {
        [textInputLabel, textInputTextField, leftLabel, underLine].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        self.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(56)
        }
        
        textInputLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        textInputTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(textInputLabel.snp.bottom).offset(8)
            make.width.equalToSuperview()
        }
        
        leftLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalTo(underLine.snp.bottom)
        }
        
        underLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textInputTextField.snp.bottom)
            make.width.equalTo(160)
            make.height.equalTo(2) 
        }
        
    }
    
    
}


extension SmallTextInputView:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        underLine.backgroundColor = .Clutch.mainGreen
        textInputLabel.textColor = .Clutch.mainGreen
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            underLine.backgroundColor = .Clutch.bgGrey
            textInputLabel.textColor = .Clutch.textDarkGrey
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            underLine.backgroundColor = .Clutch.bgGrey
            textInputLabel.textColor = .Clutch.textDarkGrey
        }
        
        textField.resignFirstResponder()
        
        return true
    }
}

