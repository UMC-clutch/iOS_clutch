//
//  ImageCell.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/28.
//

import Foundation
import UIKit

class imageCell: UICollectionViewCell {
    //MARK: - UI ProPerties
    public lazy var imageView: UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "Add_round"))
        imageview.contentMode = .scaleAspectFit
        imageview.layer.cornerRadius = 10
        imageview.backgroundColor = .Clutch.bgGrey
        
        return imageview
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_Close_round_fill"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
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
        [imageView, deleteButton].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalTo(imageView.snp.trailing).offset(-6)
            make.top.equalTo(imageView.snp.top).offset(6)
        }
    }
    
    @objc func deleteButtonTapped() {
        print(0)
    }
}
