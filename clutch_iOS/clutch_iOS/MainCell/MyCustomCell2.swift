//
//  MyCustomCell2.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/06/29.
//

import UIKit
import SnapKit

class MyCustomCell2: UICollectionViewCell {
    
    //UI 테스트 용 텍스트
    lazy var testLabel:UILabel = {
        let label = UILabel()
        label.text = "테스트"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .blue
       
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
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    //Cell의 오토레이아웃
    func Constraint(){
        testLabelConstraint()
    }
    
    //testLabel의 오토레이아웃
    func testLabelConstraint() {
        testLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
