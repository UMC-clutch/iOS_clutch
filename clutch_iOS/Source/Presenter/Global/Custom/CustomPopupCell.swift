//
//  CustomPopupCell.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/25.
//

import Foundation
import UIKit

class CustomPopupCell: UICollectionViewCell {
    //MARK: - UI ProPerties
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "" // CustomPopupViewController.swift에서 처리
        label.textColor = UIColor.Clutch.textBlack
        label.numberOfLines = 1
        label.font = UIFont.Clutch.baseMedium
        
        return label
    }()
    
    lazy var checkImageView:UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "mypage"))
        imageview.isHidden = true
        
        return imageview
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
        [textLabel, checkImageView].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        checkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(textLabel)
            make.trailing.equalToSuperview()
        }
    }
}
