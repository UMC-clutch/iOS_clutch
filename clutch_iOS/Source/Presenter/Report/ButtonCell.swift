//
//  ButtonCell.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/28.
//

import Foundation
import UIKit

class ButtonCell: UICollectionViewCell {
    //MARK: - UI ProPerties
    lazy var view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .Clutch.bgGrey
        
        return view
    }()
    public lazy var imageView: UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "Add_round"))
        
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
        [view, imageView].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(56)
        }
    }
}
