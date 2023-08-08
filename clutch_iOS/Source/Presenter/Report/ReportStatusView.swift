//
//  ReportStatusView.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/30.
//

import UIKit
import SwiftyGif

class ReportStatusView: UIView {
    //MARK: - Properties
    let status = 1
    
    //MARK: - UI ProPerties
    lazy var completeGifImage:UIImageView = {
        do {
            let gif = try UIImage(gifName: "report_done.gif")
            let imageview = UIImageView(gifImage: gif, loopCount: 1) // Will loop 3 times
            
            return imageview
        }
        catch {
            let imageView = UIImageView()
            let iamge = UIImage(named: "clutch_logo")
            imageView.image = iamge
    
            return imageView
        }
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "신고 접수가 완료되었어요"
        label.numberOfLines = 2
        label.font = .Clutch.headtitlebold
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    lazy var subTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "신고 접수 내용을 아래에서 확인해보세요"
        label.numberOfLines = 2
        label.font = .Clutch.baseMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var statusImage:UIImageView = {
        let imageView = UIImageView()
        let iamge = UIImage(named: "status1_3x")
        imageView.image = iamge
        
        return imageView
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
        statusImageSet()
    }
    
    func addsubview() {
        [completeGifImage, titleLabel, subTitleLabel, statusImage].forEach { view in
            self.addSubview(view)
        }
    }
    
    func statusImageSet() {
        switch status {
        case 0:
            statusImage.image = UIImage(named: "status1_3x")
        case 1:
            statusImage.image = UIImage(named: "status2_3x")
        case 2:
            statusImage.image = UIImage(named: "status3_3x")
        case 3:
            statusImage.image = UIImage(named: "status4_3x")
        default:
            statusImage.image = UIImage(named: "status1_3x")
        }
    }
    
    func Constraint() {
        
        let spacing = 8
        
        completeGifImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(completeGifImage.snp.bottom).offset(spacing * 2)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(spacing)
            make.centerX.equalToSuperview()
        }
        
        statusImage.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(spacing * 8)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(spacing * 4)
            make.trailing.equalToSuperview().offset(-spacing * 4)
            make.height.equalTo(spacing * 10)
        }
  
    }

}
