//
//  CheckContainer.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/21.
//

import UIKit
import SnapKit

//체크 박스
//다 만들었으니 뷰에 추가만 하면 됨

class CheckContainer: UIView {
    //MARK: - UI ProPerties
    lazy var checkButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_deselected"), for: .normal)
        button.setImage(UIImage(named: "btn_selected"), for: .selected)
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var checkLabel:UILabel = {
        let label = UILabel()
        label.text = "아파트"
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
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checkButtonTapped() {
        checkButton.isSelected.toggle()
    }
    
    func SetView() {
        self.backgroundColor = .white
        addsubview()
    }
    
    func addsubview() {
        [checkLabel, checkButton].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        self.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(24)
        }
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(20)
        }
        
        checkLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(10)
            make.top.equalToSuperview()
        }
        
    }
    
    
}
