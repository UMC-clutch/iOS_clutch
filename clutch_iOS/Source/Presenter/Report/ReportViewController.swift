//
//  ReportViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//

import UIKit
import SnapKit


class ReportViewController: UIViewController, UIScrollViewDelegate {
    
    //스크롤을 위한 스크롤 뷰
    lazy var scrollview:UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    //스크롤 뷰 안에 들어갈 내용을 표시할 뷰
    let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    //스크롤 기능을 탑재한 버튼
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.mainDarkGreen
        // Highlighted 상태일 때 배경색
        let iamge = image(withColor: .Clutch.mainGreen!)
        button.setBackgroundImage(iamge, for: .highlighted)

        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        constraints()
    }
    
    func setView() {
        addsubview()
        setscrollview()
        self.view.backgroundColor = .Clutch.mainWhite
    }
    
    func addsubview() {
        [scrollview, nextButton].forEach { view in
            self.view.addSubview(view)
        }
    }

    func setscrollview() {
        scrollview.delegate = self
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
    }
    
    func setcontentView() {

    }

    func constraints() {
        //스크롤 뷰 오토레이아웃
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //contentView 오토레이아웃
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.frame.height * 3)
        }
        //버튼 오토레이아웃
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
    
    // 버튼 클릭 시 스크롤되도록 하는 메서드
    @objc func ButtonTapped(_ sender: UIButton) {
        let offset = CGPoint(x: 0, y: scrollview.contentSize.height / 3 )
        scrollview.setContentOffset(offset, animated: true)
    }

}
