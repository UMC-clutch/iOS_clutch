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
    
    // 체크표시 이미지 넣을 것인지?
    // 셀 터치하면 바로 창 닫히게 할지
//    public lazy var checkImageView: UILabel = {
//        let label = UILabel()
//        label.text = "" // MypageViewController.swift에서 처리
//        label.textColor = UIColor.Clutch.textBlack
//        label.numberOfLines = 1
//        label.font = UIFont.Clutch.baseMedium
//
//        return label
//    }()
    
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
//        [textLabel, nextpageLabel].forEach { view in
//            self.addSubview(view)
//        }
        self.addSubview(textLabel)
    }
    
    func Constraint() {
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
//        nextpageLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.trailing.equalToSuperview()
//        }
    }
}
