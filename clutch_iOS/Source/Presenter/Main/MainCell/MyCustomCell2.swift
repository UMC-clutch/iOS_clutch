//
//  MyCustomCell2.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/06/29.
//

import UIKit
import SnapKit
import SwiftyGif

class MyCustomCell2: UICollectionViewCell {
    
    //UI 테스트 용 텍스트
    lazy var firstLabel:UILabel = {
        let label = UILabel()
        label.text = "클러치가 도와드릴게요"
        label.font = UIFont.Clutch.headtitlebold
        label.textColor = .white
       
        return label
    }()
    
    lazy var secondLabel:UILabel = {
        let label = UILabel()
        label.text = "전세사기 가능성을 계산해주고, 사기 신고\n접수 시에 보증금 환급을 도와드립니다."
        label.font = UIFont.Clutch.baseMedium
        label.textColor = .white
        label.numberOfLines = 2
       
        return label
    }()
    
    lazy var thirdLabel:UILabel = {
        let label = UILabel()
        label.text = "자세히 알고 싶어요"
        label.font = UIFont.Clutch.smallMedium
        label.textColor = .white
    
        return label
    }()
    
    lazy var rightArrowImageView:UIImageView =  {
        let image = UIImageView()
        image.image = UIImage(named: "btn_arrow_small")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        return image
    }()
    
    lazy var gifImage:UIImageView = {
        do {
            let gif = try UIImage(gifName: "report_done.gif")
            let imageview = UIImageView(gifImage: gif, loopCount: -1) // Will loop forever
            
            return imageview
        }
        catch {
            let imageView = UIImageView()
            let iamge = UIImage(named: "clutch_logo")
            imageView.image = iamge

            return imageView
        }
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
        [firstLabel, secondLabel, thirdLabel, rightArrowImageView, gifImage].forEach { view
            in self.addSubview(view) }
        self.layer.cornerRadius = 18
        self.backgroundColor = UIColor.Clutch.mainDarkGreen
    }
    
    //Cell의 오토레이아웃
    func Constraint(){
       
        firstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(firstLabel.snp.bottom).offset(20)
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        rightArrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(thirdLabel.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
            make.centerY.equalTo(thirdLabel.snp.centerY)
            make.size.equalTo(thirdLabel.snp.height)
        }
        
        gifImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
    }
}
