//
//  CollectionViewCell.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/06/29.
//

import UIKit
import SnapKit

class MyCustomCell1: UICollectionViewCell {
    
    //cell 1번 서브 메세지
    lazy var firstLabel:UILabel = {
        let label = UILabel()
        label.text = "미리미리 대비하기!"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    //cell 1번 메인 메세지
    lazy var secondLabel:UILabel = {
        let label = UILabel()
        label.text = "계약서 작성시 살펴봐야 할 점들!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    //cell 1번 bannerView
    lazy var bannerView:UIView = {
        let view = UIView()
        
        return view
    }()
    
    var customBannerViews: [UIView] = []
    var currentViewIndex = 0
    
    let view1 = Banner1View()
    let view2 = Banner2View()
    let view3 = Banner3View()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view1.frame = contentView.bounds
        view2.frame = contentView.bounds
        view3.frame = contentView.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetView()
        Constraint()
    }
    
    @objc func changeBanner() {
        // 다음 뷰로 변경
        currentViewIndex = (currentViewIndex + 1) % customBannerViews.count
        
        // 기존 뷰 제거
        bannerView.subviews.forEach { $0.removeFromSuperview() }
        
        // 새로운 뷰 추가 (페이드 애니메이션 효과 포함)
        let newBannerView = customBannerViews[currentViewIndex]
        bannerView.addSubview(newBannerView)
        newBannerView.alpha = 0.5 // 초기에 투명 상태로 설정
        
        UIView.animate(withDuration: 2.5) {
            newBannerView.alpha = 1 // 페이드 인 애니메이션
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Cell의 View 관련 설정
    func SetView(){
        self.addSubview(bannerView)
        self.layer.cornerRadius = 18
        self.backgroundColor = .Clutch.bgGrey
        customBannerViews = [view1, view2, view3]
        // 초기 뷰 설정
        bannerView.addSubview(customBannerViews[currentViewIndex])
        // 3초마다 배너 변경을 위한 타이머 설정
        Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(changeBanner), userInfo: nil, repeats: true)
    }
    
    
    //Cell의 오토레이아웃
    func Constraint(){
        bannerView.snp.makeConstraints { make in
            make.size.equalTo(self.contentView.snp.size)
            make.centerX.equalTo(self.contentView.snp.centerX)
        }
        
    }
    
}
