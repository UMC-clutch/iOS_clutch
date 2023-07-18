//
//  AccountCell.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/07/13.
//

import Foundation
import UIKit

class AccountCell: UICollectionViewCell {
    //MARK: - UI ProPerties
    // UILabel 선언("전세사기 피해 신고 내역")
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "" // MypageViewController.swift에서 처리
        label.textColor = UIColor.Clutch.textBlack
        label.numberOfLines = 1
        label.font = UIFont.Clutch.baseMedium
        
        return label
    }()
    
    // UILabel 선언(">")
    public lazy var nextpageLabel: UILabel = {
        let label = UILabel()
        label.text = "" // MypageViewController.swift에서 처리
        label.textColor = UIColor.Clutch.textBlack
        label.numberOfLines = 1
        label.font = UIFont.Clutch.baseMedium

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
    
    //MARK: - Properties
    
    //MARK: - Set Ui
    // CVC의 view 관련 설정(라벨 추가)
    func SetView() {
        [textLabel, nextpageLabel].forEach { view in
            self.addSubview(view)
        }
    }
    
    // CVC의 오토레이아웃
    func Constraint() {
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
            
        nextpageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }

}

