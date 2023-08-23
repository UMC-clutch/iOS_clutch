//
//  CalculateView.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/21.
//

import UIKit
import SnapKit

// 텍스트 인풋
// 다 만들었으니 뷰에 추가만 하면 됨

class TextInputView: UIView {
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
    
    
    //MARK: - Define Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetView()
        Constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textIsEmpty() {
        
        guard let text = textInputTextField.text else {return}
        guard let placeholder = textInputTextField.placeholder else {return}
        
        if text.isEmpty == false  {
            underLine.backgroundColor = .Clutch.mainGreen
            textInputLabel.textColor = .Clutch.mainGreen
        }
    }
    //MARK: - Set Ui
    func SetView() {
        self.backgroundColor = .white
        textInputTextField.delegate = self
        addsubview()
        
    }
    
    func addsubview() {
        [textInputLabel, textInputTextField, underLine].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        self.snp.makeConstraints { make in
            make.width.equalTo(360)
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
        
        underLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textInputTextField.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(2) // underLine 뷰의 높이를 고정 값인 2로 설정
        }
        
    }
    
    
}

//MARK: - extension
extension TextInputView:UITextFieldDelegate {
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

