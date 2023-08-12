//
//  Banner3View.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/12.
//

import UIKit

class Banner1View: UIView {
    //MARK: - UI ProPerties
    lazy var bannerImageView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "img_main_banner_01")
        imageView.image = image
        
        return imageView
    }()
    
    lazy var bannerButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
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
    
    @objc
    func buttonTapped() {
        
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Set Ui
    func SetView() {
        self.layer.cornerRadius = 18
        self.addSubview(bannerImageView)
        self.addSubview(bannerButton)
    }
    
    func Constraint() { }
}
