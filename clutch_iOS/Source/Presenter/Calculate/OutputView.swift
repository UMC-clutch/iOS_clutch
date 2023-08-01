//
//  OutputViewController.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/07/31.
//

import Foundation
import UIKit

class OutputView: UIView {
    //MARK: - UI ProPerties
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "시세"
        label.font = UIFont.Clutch.subheadMedium
        label.textColor = .Clutch.textDarkerGrey
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var outputLabel: UILabel = {
        let label = UILabel()
        label.text = "2,000,000,000 원"
        label.font = UIFont.Clutch.subheadMedium
        label.textColor = .black
        label.textAlignment = .right
        
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
    func SetView() {
        self.backgroundColor = .white
        addsubview()
        
    }
    
    func addsubview() {
        [categoryLabel, outputLabel].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        self.snp.makeConstraints { make in
            make.width.equalTo(353)
            make.height.equalTo(23)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        outputLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
    }
    
    
}
