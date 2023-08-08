//
//  CalculateHistoryCell.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/08/07.
//

import Foundation
import UIKit

class CalculateHistoryCell: UITableViewCell {
    //MARK: - UI ProPerties
    // UILabel 선언("2023년 7월 25일")
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "" // CalculateHistoryViewController에서 처리
        label.textColor = UIColor.Clutch.textDarkGrey
        label.numberOfLines = 1
        label.font = UIFont.Clutch.baseBold
        
        return label
    }()

    // UIButton 선언("자세히  >")
    public lazy var nextpageButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        btn.setTitle("자세히  >", for: .normal)
        btn.titleLabel?.font = .Clutch.baseBold
        btn.setTitleColor(.Clutch.textDarkGrey, for: .normal)

        return btn
    }()
    
    // UILabel 선언("위험 단계")
    public lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.text = "" // CalculateHistoryViewController에서 처리
        label.textColor = UIColor.Clutch.textBlack
        label.numberOfLines = 1
        label.font = UIFont.Clutch.subtitleBold
        
        return label
    }()
    
    // UIView 선언(구분선)
    lazy var seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        
        return view
    }()
    
    // UILabel 선언("주소")
    public lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.textColor = UIColor.Clutch.textDarkerGrey
        label.numberOfLines = 1
        label.font = UIFont.Clutch.baseMedium
        
        return label
    }()
    
    // UILabel 선언("서울특별시 용산구 청파로47길 100")
    public lazy var addressInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "" // CalculateHistoryViewController에서 처리
        label.textColor = UIColor.Clutch.textBlack
        label.numberOfLines = 1
        label.font = UIFont.Clutch.baseMedium
        label.textAlignment = .right
        
        return label
    }()

    // UILabel 선언("505동 606호")
    public lazy var postInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "" // CalculateHistoryViewController에서 처리
        label.textColor = UIColor.Clutch.textBlack
        label.numberOfLines = 1
        label.font = UIFont.Clutch.baseMedium
        label.textAlignment = .right
        
        return label
    }()
    
    //MARK: - Define Method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        SetView()
        Constraint()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func SetView() {
        [dateLabel, nextpageButton, stateLabel, seperateLine, addressLabel, addressInfoLabel, postInfoLabel].forEach { view in
            self.addSubview(view)
        }
    }

    func Constraint() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
            
        nextpageButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.top).offset(36)
            make.leading.equalToSuperview()
        }
        
        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.top).offset(48)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.top).offset(17)
            make.leading.equalToSuperview()
        }
        
        addressInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.top).offset(17)
            make.trailing.equalToSuperview()
        }
        
        postInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(addressInfoLabel.snp.top).offset(20)
            make.trailing.equalToSuperview()
        }
        
    }

}
