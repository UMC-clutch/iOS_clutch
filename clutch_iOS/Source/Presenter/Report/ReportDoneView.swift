//
//  TextSampleView.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/30.
//

import UIKit

class ReportDoneView: UIView {
    //MARK: - Properties
    let rightText = ["신고 날짜", "건물명", "근저당 설정 기준일", "주소", "건물유형", "실거주 여부", "전입 신고일", "확정일자", "집주인 채권 개입 여부", "배당 신청 여부", "보증금 액수"]
    let leftText = ["sample"]
    
    //MARK: - UI ProPerties
    lazy var statusImage = ReportStatusView()
    
    lazy var reportDate = TextSampleView()
    
    lazy var underLine:UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        
        return view
    }()
    
    lazy var buildingName = TextSampleView()
    lazy var mortgageSettingDate = TextSampleView()
    lazy var address = TextSampleView()
    lazy var buildingType = TextSampleView()

    lazy var underLine2:UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        
        return view
    }()
    
    lazy var isResidentOccupied = TextSampleView()
    lazy var moveInReportDate = TextSampleView()
    lazy var confirmationDate = TextSampleView()
    lazy var landlordLienInvolved = TextSampleView()
    lazy var dividendApplicationStatus = TextSampleView()
    lazy var depositAmount = TextSampleView()
    
    //MARK: - Define Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetView()
        Constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func labelTextSet() {
        [reportDate, buildingName, mortgageSettingDate, address, buildingType,isResidentOccupied, moveInReportDate, confirmationDate, landlordLienInvolved, dividendApplicationStatus, depositAmount].enumerated().forEach { index, label in
            if index < rightText.count {
                label.rightText.text = rightText[index]
                label.leftText.text = leftText[0]
            }
        }
    }

    func SetView() {
        addsubview()
        labelTextSet()
        self.backgroundColor = .white
    }
    
    func addsubview() {
        [statusImage, reportDate, underLine, buildingName, mortgageSettingDate, address, buildingType, underLine2, isResidentOccupied, moveInReportDate, confirmationDate, landlordLienInvolved, dividendApplicationStatus,depositAmount].forEach { view in
            self.addSubview(view)
        }
    }
    
    func Constraint() {
        let sideInterval = 16
        let verticalinterval = 32
        let underlineHeight = 8
        
        statusImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
            make.height.equalTo(300)
        }
        
        reportDate.snp.makeConstraints { make in
            make.top.equalTo(statusImage.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        underLine.snp.makeConstraints { make in
            make.top.equalTo(reportDate.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
            make.height.equalTo(underlineHeight)
        }
        
        buildingName.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        mortgageSettingDate.snp.makeConstraints { make in
            make.top.equalTo(buildingName.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        address.snp.makeConstraints { make in
            make.top.equalTo(mortgageSettingDate.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        buildingType.snp.makeConstraints { make in
            make.top.equalTo(address.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        underLine2.snp.makeConstraints { make in
            make.top.equalTo(buildingType.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
            make.height.equalTo(underlineHeight)
        }
        
        isResidentOccupied.snp.makeConstraints { make in
            make.top.equalTo(underLine2.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        moveInReportDate.snp.makeConstraints { make in
            make.top.equalTo(isResidentOccupied.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        confirmationDate.snp.makeConstraints { make in
            make.top.equalTo(moveInReportDate.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        landlordLienInvolved.snp.makeConstraints { make in
            make.top.equalTo(confirmationDate.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        dividendApplicationStatus.snp.makeConstraints { make in
            make.top.equalTo(landlordLienInvolved.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        depositAmount.snp.makeConstraints { make in
            make.top.equalTo(dividendApplicationStatus.snp.bottom).offset(verticalinterval)
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
    }

}


