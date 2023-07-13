//
//  BaseViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/13.
//

import UIKit

class BaseViewController: UIView {
    //MARK: - UI ProPerties
    
    
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
        
    }
    
    func Constraint() {
        
    }

}
