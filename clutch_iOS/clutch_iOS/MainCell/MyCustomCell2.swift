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
    lazy var firstLabel:UILabel = {
        let label = UILabel()
        label.text = "클러치가 도와드릴게요"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
       
        return label
    }()
    
    lazy var secondLabel:UILabel = {
        let label = UILabel()
        label.text = "전세사기 가능성을 계산해주고, 사기 신고\n접수 시에 보증금 환급을 도와드립니다."
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 2
       
        return label
    }()
    
    lazy var thirdLabel:UILabel = {
        let label = UILabel()
        label.text = "자세히 알고 싶어요 >"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
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
        self.addSubview(thirdLabel)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.Clutch.mainDarkGreen
    }
    
    //Cell의 오토레이아웃
    func Constraint(){
        firstLabelConstraint()
        secondLabelConstraint()
        thirdLabelConstraint()
    }
    
    //testLabel의 오토레이아웃
    func firstLabelConstraint() {
        firstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    func secondLabelConstraint(){
        secondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(firstLabel.snp.bottom).offset(20)
        }
    }
    
    
    func thirdLabelConstraint(){
        thirdLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(secondLabel.snp.bottom).offset(80)
        }
    }
    

}
