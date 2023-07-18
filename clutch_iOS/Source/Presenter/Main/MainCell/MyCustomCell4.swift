//
//  MyCustomCell14.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/06/29.
//

import UIKit
import SnapKit

class MyCustomCell4: UICollectionViewCell {
    
    //UI 테스트 용 텍스트
    lazy var testLabel:UILabel = {
        let label = UILabel()
        label.text = "전세사기 피해를 \n신고할래요"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .Clutch.textBlack
        label.numberOfLines = 2
       
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetView()
        Constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Cell의 View 관련 설정
    func SetView(){
        [testLabel].forEach { view
            in self.addSubview(view) }
        self.layer.cornerRadius = 18
        self.backgroundColor = .white
    }
    
    //Cell의 오토레이아웃
    func Constraint(){
        testLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)

        }
    }
}
