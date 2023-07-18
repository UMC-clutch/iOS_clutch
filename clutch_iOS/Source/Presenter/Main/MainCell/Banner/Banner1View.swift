//
//  Banner1View.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/12.
//

import UIKit
import SnapKit

class Banner1View: UIView {
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
        self.backgroundColor = .red
        self.layer.cornerRadius = 18
    }
    
    
    func Constraint() {

    }
    
}
