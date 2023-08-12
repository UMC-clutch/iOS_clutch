//
//  loginView.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/14.
//

import UIKit

class loginView: UIView {
    //MARK: - UI ProPerties
    //로고
    lazy var logo:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "AppIcon")
        
        return view
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
        addsubview()
        self.backgroundColor = .white
    }
    
    func addsubview() {
        [logo].forEach { view
            in self.addSubview(view) }
    }
    
    func Constraint() {
        //로고 오토레이아웃
        let superviewHeight = UIScreen.main.bounds.height
    
        logo.snp.makeConstraints { make in
            make.size.equalTo(140)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(superviewHeight * 0.3)
        }
        
    }
    
}


