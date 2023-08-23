//
//  ReportDoneViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/30.
//

import UIKit

class ReportDoneViewController: UIViewController, UIScrollViewDelegate {
    //MARK: - Properties
    lazy var canceled = false
    var reportInfo: GetReport?
    lazy var fromVC = ""
    
    //MARK: - UI propereties
    
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
    lazy var doneButton:UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.mainDarkGreen
        // Highlighted 상태일 때 배경색
        let iamge = image(withColor: .Clutch.mainGreen!)
        button.setBackgroundImage(iamge, for: .highlighted)
        
        return button
    }()
    
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("신고 취소", for: .normal)
        button.setTitleColor(.Clutch.mainDarkGreen, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.mainWhite
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Clutch.mainDarkGreen?.cgColor
        
        return button
    }()
    
    let reportDoneView = ReportDoneView()
    
    //MARK: - define method
    override func viewDidLoad() {
        super.viewDidLoad()
        requestGet()
        setView()
        constraints()
    }
    
    //뷰관련 셋
    func setView() {
        addsubview()
        setscrollview()
        self.view.backgroundColor = .Clutch.mainWhite
    }
    
    //addsubview
    func addsubview() {
        [scrollview].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        [reportDoneView, doneButton, cancelButton].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //스크롤 뷰관련 셋
    func setscrollview() {
        scrollview.delegate = self
        
    }
    
    func constraints() {
        let spacing:CGFloat = 16
        //스크롤 뷰 오토레이아웃
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //contentView 오토레이아웃
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.frame.height * 1.4)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(spacing)
            make.width.equalTo((self.view.frame.width - spacing * 3)/2)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        //버튼 오토레이아웃
        doneButton.snp.makeConstraints { make in
            make.leading.equalTo(cancelButton.snp.trailing).offset(spacing)
            make.width.equalTo((self.view.frame.width - spacing * 3)/2)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        
        reportDoneView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges)
        }
    }
    
    // 완료버튼 화면전환 동작
    @objc func doneButtonTapped(_ sender: UIButton) {
        // 신고화면에서 불러졌으면 메인으로
        if fromVC == "Report" {
            if let VC = navigationController?.viewControllers.first(where: {$0 is MainViewController}) {
                        navigationController?.popToViewController(VC, animated: true)
            }
        }
        // 마이페이지에서 불러졌으면 뒤로
        else if fromVC == "MyPage" {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // 신고취소 버튼 동작
    @objc func cancelButtonTapped(_ sender: UIButton) {
        showCustomAlert(alertType: .canCancel,
                        alertTitle: "신고 취소",
                        alertContext: "정말로 신고를 철회하시겠습니까?",
                        cancelText: "닫기",
                        confirmText: "신고취소")
    }
    
}

//MARK: - extension
extension ReportDoneViewController: CustomAlertDelegate {
    func cancel() {
        print("custom cancel Button Tapped")
    }
    
    func confirm() {
        print("custom action Button Tapped")
        
        APIManger.shared.callDeleteRequest(baseEndPoint: .report, addPath: "/delete", parameters: nil) { JSON, status in
            // 호출 오류시 처리
            if status != 200 {
                self.showCustomAlert(alertType: .done,
                                     alertTitle: "오류 발생",
                                     alertContext: "다시 시도해주세요.",
                                     confirmText: "확인")
                return
            }
            
            // 정상 호출 완료
            self.canceled = true
            self.showCustomAlert(alertType: .done,
                            alertTitle: "취소 완료",
                            alertContext: "신고 내역이 정상적으로 삭제되었습니다",
                            confirmText: "확인")
        }
    }
    
    func done() {
        if canceled {
            // 신고화면에서 불러졌으면 메인으로
            if fromVC == "Report" {
                if let VC = navigationController?.viewControllers.first(where: {$0 is MainViewController}) {
                            navigationController?.popToViewController(VC, animated: true)
                }
            }
            // 마이페이지에서 불러졌으면 뒤로
            else if fromVC == "MyPage" {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //MARK: - Network
    func requestGet() {
        APIManger.shared.callGetRequest(baseEndPoint: .report, addPath: "/comp") { JSON in
            // 호출 오류시 처리
            if JSON["check"].boolValue == false {
                self.showCustomAlert(alertType: .done,
                                     alertTitle: "오류 발생",
                                     alertContext: "다시 시도해주세요.",
                                     confirmText: "확인")
                return
            }
            // 신고 내역이 없는 경우
            else if JSON["information"].isEmpty {
                self.showCustomAlert(alertType: .done,
                                     alertTitle: "조회 실패",
                                     alertContext: "전세사기 피해 신고 내역이 없습니다.",
                                     confirmText: "확인")
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            let reportStatus = JSON["information"]["reportStatus"].stringValue
            let reportedAt = JSON["information"]["reportedAt"].stringValue
            let reportId = JSON["information"]["reportId"].intValue
            let buildingName = JSON["information"]["buildingName"].stringValue
            let collateralDate = JSON["information"]["collateralDate"].stringValue
            let address = JSON["information"]["address"].stringValue
            let dong = JSON["information"]["dong"].stringValue
            let ho = JSON["information"]["ho"].stringValue
            let buildingType = JSON["information"]["buildingType"].stringValue
            let hasLandlordIntervene = JSON["information"]["hasLandlordIntervene"].boolValue
            let hasAppliedDividend = JSON["information"]["hasAppliedDividend"].boolValue
            let deposit = JSON["information"]["deposit"].intValue
            let hasLived = JSON["information"]["hasLived"].boolValue
            let transportReportDate = JSON["information"]["transportReportDate"].stringValue
            let confirmationDate = JSON["information"]["confirmationDate"].stringValue
            
            self.reportInfo = GetReport(reportStatus: reportStatus,
                                       reportedAt: reportedAt,
                                       reportId: reportId,
                                       buildingName: buildingName,
                                       collateralDate: collateralDate,
                                       address: address,
                                       dong: dong,
                                       ho: ho,
                                       buildingType: buildingType,
                                       hasLandlordIntervene: hasLandlordIntervene,
                                       hasAppliedDividend: hasAppliedDividend,
                                       deposit: deposit,
                                       hasLived: hasLived,
                                       transportReportDate: transportReportDate,
                                       confirmationDate: confirmationDate
            )
            
            
            DispatchQueue.main.async {
                self.reportDoneView.statusImage.status = reportStatus
                self.reportDoneView.statusImage.statusImageSet()
                
                print(1)
                let endIndex = reportedAt.index(reportedAt.startIndex, offsetBy: 10)
                let extractedDate = String(reportedAt[..<endIndex])
                self.reportDoneView.reportDate.leftText.text = dateForView(inDateStr: extractedDate)
                
                self.reportDoneView.buildingName.leftText.text = buildingName
                self.reportDoneView.mortgageSettingDate.leftText.text = dateForView(inDateStr: collateralDate)
                
                self.reportDoneView.address.leftText.numberOfLines = 2
                self.reportDoneView.address.leftText.text = "\(address)\n\(dong)동 \(ho)호"
                self.reportDoneView.address.leftText.textAlignment = .right
                
                // 추후 type별 영문 string -> 한글 조건 처리 필요
                self.reportDoneView.buildingType.leftText.text = "아파트/오피스텔"
                
                if hasLived {
                    self.reportDoneView.isResidentOccupied.leftText.text = "거주 중"
                }
                else {
                    self.reportDoneView.isResidentOccupied.leftText.text = "미거주 중"
                }
                print(2)
                self.reportDoneView.moveInReportDate.leftText.text = dateForView(inDateStr: transportReportDate)
                print(3)
                self.reportDoneView.confirmationDate.leftText.text = dateForView(inDateStr: confirmationDate)
                
                if hasLandlordIntervene {
                    self.reportDoneView.landlordLienInvolved.leftText.text = "개입"
                }
                else {
                    self.reportDoneView.landlordLienInvolved.leftText.text = "미개입"
                }
                if hasAppliedDividend {
                    self.reportDoneView.dividendApplicationStatus.leftText.text = "신청"
                }
                else {
                    self.reportDoneView.dividendApplicationStatus.leftText.text = "미신청"
                }
                // 숫자 점찍기 적용 요망
                self.reportDoneView.depositAmount.leftText.text = String(deposit)
            }
        }
    }
}
