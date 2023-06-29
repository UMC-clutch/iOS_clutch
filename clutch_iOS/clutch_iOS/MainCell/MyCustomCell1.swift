//
//  CollectionViewCell.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/06/29.
//

import UIKit
import SnapKit

class MyCustomCell1: UICollectionViewCell {
    
    //cell 1번 서브 메세지
    lazy var firstLabel:UILabel = {
        let label = UILabel()
        label.text = "미리미리 대비하기!"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
       
        return label
    }()
    
    lazy var secondLabel:UILabel = {
        let label = UILabel()
        label.text = "계약서 작성시 살펴봐야 할 점들!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .white
       
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
        self.addSubview(firstLabel)
        self.addSubview(secondLabel)
        self.layer.cornerRadius = 10
        self.backgroundColor = .blue
    }
    
    //Cell의 오토레이아웃
    func Constraint(){
        firstLabelConstraint()
        secondLabelConstraint()
    }
    
    //testLabel의 오토레이아웃
    func firstLabelConstraint() {
        firstLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(3)
        }
    }
    
    func secondLabelConstraint() {
        secondLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalTo(firstLabel.snp.bottom).offset(10)
        }
    }
}
