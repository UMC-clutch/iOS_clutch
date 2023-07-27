//
//  CheckCell.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/26.
//

import Foundation
import UIKit

class CheckCell: UICollectionViewCell {
    //MARK: - UI ProPerties
    public lazy var checkImageView:UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "btn_deselected"))
        
        return imageview
    }()
    
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = ""
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
    
    func SetView() {
        [checkImageView, textLabel].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        checkImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(21)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
    }
}
