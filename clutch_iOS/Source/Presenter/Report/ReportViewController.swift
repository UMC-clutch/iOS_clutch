//
//  ReportViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//

import UIKit
import SnapKit


class ReportViewController: UIViewController{
    //MARK: - UI ProPerties
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "건물 관련 정보를\n입력해주세요"
        label.numberOfLines = 2
        label.font = .Clutch.headtitlebold
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    let buildingNameLabel = TextInputView()
    let mortgageDateLabel = TextInputView()
    
    lazy var dateButton:UIButton = {
        let button = UIButton()
        let iamge = UIImage(named: "btn_Calendar")
        button.setBackgroundImage(iamge, for: .normal)
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let addressLabel = TextInputView()
    let buildingNum = SmallTextInputView()
    let unitNum = SmallTextInputView()
    
    lazy var buildingTypeLabel:UILabel = {
        let label = UILabel()
        label.text = "건물 유형"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    let apartType = CheckContainer()
    let multiunitType = CheckContainer()
    let commercialType = CheckContainer()
    
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
    
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        SetView()
        Constraint()
    }
    
    //MARK: - Properties
    
    
    
    
    //MARK: - Set Ui
    func SetView() {
        TextInputViewSet()
        CheckContainerSet()
        SmallTextInputViewSet()
        addsubview()
        
        self.view.backgroundColor = .white
    }
    
    func addsubview() {
        let views:[UIView] = [titleLabel, buildingNameLabel, mortgageDateLabel, dateButton, addressLabel, buildingNum, unitNum, commercialType, buildingTypeLabel, apartType, multiunitType, commercialType, nextButton]
        
        views.forEach { view in
            self.view.addSubview(view)
        }
    }
    
    func TextInputViewSet() {
        buildingNameLabel.textInputLabel.text = "건물명"
        mortgageDateLabel.textInputLabel.text = "근저당 설정 기준일"
        addressLabel.textInputLabel.text = "주소"
    }
    
    func CheckContainerSet() {
        apartType.checkLabel.text = "아파트/오피스텔"
        multiunitType.checkLabel.text = "다가구"
        commercialType.checkLabel.text = "상가"
    }
    
    func SmallTextInputViewSet() {
        buildingNum.textInputLabel.isHidden = true
        unitNum.textInputLabel.isHidden = true
    }
    
    func Constraint() {
        let leading = 16
        let top = 40
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalToSuperview().offset(50)
        }
        
        buildingNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(top)
        }
        
        mortgageDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(buildingNameLabel.snp.bottom).offset(top)
        }
        
        dateButton.snp.makeConstraints { make in
            make.trailing.equalTo(mortgageDateLabel.snp.trailing)
            make.bottom.equalTo(mortgageDateLabel.underLine.snp.bottom).offset(-5)
            make.size.equalTo(20)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(mortgageDateLabel.snp.bottom).offset(top)
        }
        
        buildingNum.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(addressLabel.snp.bottom)
        }
        
        unitNum.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(addressLabel.snp.bottom)
            
        }
        
        buildingTypeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(buildingNum.snp.bottom).offset(top)
            
        }
        
        apartType.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(buildingTypeLabel.snp.bottom).offset(12)
            
        }
        
        multiunitType.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(apartType.snp.bottom).offset(20)
        }
        
        commercialType.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(multiunitType.snp.bottom).offset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(commercialType.snp.bottom).offset(40)
            make.width.equalTo(360)
            make.height.equalTo(50)
        }
        
        
    }
    
    @objc func ButtonTapped(_ sender: UIButton) {
        let VC = SampleScrollViewController()
        present(VC, animated: true)
        
    }
    
    @objc func dateButtonTapped(_ sender: UIButton) {
        let VC = datePickerViewController()
        VC.modalPresentationStyle = .overCurrentContext
        VC.modalTransitionStyle = .crossDissolve
        
        // ReportViewController를 datePickerViewController의 델리게이트로 설정합니다.
        VC.delegate = self
        
        present(VC, animated: true)
    }
    
    
}

extension ReportViewController: DatePickerDelegate {
    func didSelectDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let formattedDate = dateFormatter.string(from: date)
        mortgageDateLabel.textInputTextField.text = formattedDate
    }
}

protocol DatePickerDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

