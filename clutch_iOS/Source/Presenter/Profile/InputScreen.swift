//
//  InputScreen.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/07/17.
//

import Foundation
import UIKit
import SnapKit

class InputScreen: UIView {
    // MARK: - UI ProPerties
    // UILabel 선언(질문 제목)
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    // UITextField 선언(입력 내용)
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        
        return textField
    }()
    
    // UIView 선언(구분선)
    public lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Clutch.bgGrey

        return view
    }()
    
    // MARK: - Define Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        Constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Ui
    func setView() {
        [titleLabel, textField, underLine].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        underLine.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(2)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
    }
    
}
