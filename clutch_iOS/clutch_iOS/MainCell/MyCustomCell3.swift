//
//  MyCustomCell3.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/06/29.
//

import UIKit
import SnapKit

class MyCustomCell3: UICollectionViewCell {
    
    //UI 테스트 용 텍스트
    lazy var testLabel:UILabel = {
        let label = UILabel()
        label.text = "사기 가능성을 \n계산하고 싶어요"
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
        self.addSubview(testLabel)
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
    }
    
    //Cell의 오토레이아웃
    func Constraint(){
        testLabelConstraint()
    }
    
    //testLabel의 오토레이아웃
    func testLabelConstraint() {
        testLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

}
