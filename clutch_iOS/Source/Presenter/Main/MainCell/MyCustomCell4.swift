//
//  MyCustomCell14.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/06/29.
//

import UIKit
import SnapKit
import SwiftyGif

class MyCustomCell4: UICollectionViewCell {
    
    //UI 테스트 용 텍스트
    lazy var testLabel:UILabel = {
        let label = UILabel()
        label.text = "전세사기 피해를 \n신고할래요"
        label.font = UIFont.Clutch.subheadBold
        label.textColor = .Clutch.textBlack
        label.numberOfLines = 2
       
        return label
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
        [testLabel, gifImage].forEach { view
            in self.addSubview(view) }
        self.layer.cornerRadius = 18
        self.backgroundColor = .white
    }
    
    //Cell의 오토레이아웃
    func Constraint(){
        testLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(26)
            make.top.equalToSuperview().offset(28)
        }
        
        gifImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
    }
}
