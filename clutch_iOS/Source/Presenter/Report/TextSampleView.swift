//
//  ReportDoneView.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/30.
//

import UIKit
import SnapKit

class TextSampleView: UIView  {
    //MARK: - UI ProPerties
    lazy var rightText:UILabel = {
        let label = UILabel()
        label.font = .Clutch.subheadMedium
        label.textColor = .Clutch.textDarkerGrey
        
        return label
    }()
    
    lazy var leftText:UILabel = {
        let label = UILabel()
        label.font = .Clutch.subheadMedium
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

    func SetView() {
        addsubview()
        self.backgroundColor = .white
        
    }
    
    func addsubview() {
        [rightText, leftText].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        self.snp.makeConstraints { make in
            make.height.equalTo(rightText.snp.height)
        }
        
        rightText.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        leftText.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

}
