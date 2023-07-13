//
//  ReportViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//

import UIKit
import SnapKit

// 스크롤 기능까지 추가 코드 정리 해야함.
class ReportViewController: UIViewController, UIScrollViewDelegate {
    
    lazy var scrollview:UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("오오오", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollview)
        scrollview.addSubview(contentView)
        self.view.addSubview(nextButton)
        self.view.backgroundColor = .Clutch.mainWhite
        scrollview.delegate = self
        constraints()
    }
    
    func constraints() {
        //        scrollview.snp.makeConstraints { make in
        //            make.top.leading.trailing.equalToSuperview()
        //            make.height.equalTo(scrollview.bounds.size.height * 3)
        //        }
        
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.frame.height * 3)
        }
        
        nextButton.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
    }
    
    @objc func ButtonTapped(_ sender: UIButton) {
        let offset = CGPoint(x: 0, y: scrollview.contentSize.height - scrollview.bounds.size.height)
        scrollview.setContentOffset(offset, animated: true)
    }
    
    
    
    
}
