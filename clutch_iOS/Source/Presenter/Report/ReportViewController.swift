//
//  ReportViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//

import UIKit
import SnapKit
import SkeletonView

class ReportViewController: UIViewController{
    //MARK: - UI ProPerties
    public lazy var navigationBar = UINavigationBar()
    
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
    
    // 체크 박스
    lazy var selectText = ["아파트/오피스텔", "다가구", "상가"]
    lazy var selectedType = ""
    
    lazy var selectCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0 // 상하간격
        layout.minimumInteritemSpacing = 0 // 좌우간격
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
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
    
    //MARK: - Set Ui
    func SetView() {
        TextInputViewSet()
        SmallTextInputViewSet()
        addsubview()
        // 체크박스, 네비게이션바
        setCollectionview()
        setNavigationBar()
        self.view.backgroundColor = .white
    }
    
    func addsubview() {
        let views:[UIView] = [navigationBar, titleLabel, buildingNameLabel, mortgageDateLabel, dateButton, addressLabel, buildingNum, unitNum, buildingTypeLabel, selectCollectionView, nextButton]
        
        views.forEach { view in
            self.view.addSubview(view)
        }
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        
        navigationItem.title = "사기 신고 접수"
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.Clutch.subheadBold
        ]
        
        let backButton = UIBarButtonItem(
            image:UIImage(named: "btn_arrow_big"),
            style: .plain, target: self,
            action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Clutch.mainWhite // 배경색 변경
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }
    
    func TextInputViewSet() {
        buildingNameLabel.textInputLabel.text = "건물명"
        mortgageDateLabel.textInputLabel.text = "근저당 설정 기준일"
        addressLabel.textInputLabel.text = "주소"
    }
    
    func SmallTextInputViewSet() {
        buildingNum.textInputLabel.isHidden = true
        unitNum.textInputLabel.isHidden = true
    }
    
    func Constraint() {
        let leading = 16
        let top = 40
        
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
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
        
        selectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(buildingTypeLabel.snp.bottom).offset(3.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(132)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        
    }
    
    @objc func backButtonTapped() {
        // 이전 view로 돌아가는 코드 필요
        print("Back Button Tapped")
    }
    
    @objc func ButtonTapped(_ sender: UIButton) {
        let VC = ReportDoneViewController()
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

extension ReportViewController: DatePickerDelegate,
                                UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func didSelectDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let formattedDate = dateFormatter.string(from: date)
        mortgageDateLabel.textInputTextField.text = formattedDate
    }
    
    func setCollectionview() {
        selectCollectionView.dataSource = self
        selectCollectionView.delegate = self
        selectCollectionView.isScrollEnabled = false
            
        selectCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "CheckCell")
    }
    
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // cell에 들어갈 data 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = selectCollectionView.dequeueReusableCell(withReuseIdentifier: "CheckCell", for: indexPath) as? CheckCell else {
            return UICollectionViewCell()
        }
        
        cell.textLabel.text = selectText[indexPath.row]
        return cell
    }
    
    // cell 크기 및 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height = collectionView.frame.height / 3
        return CGSize(width: width, height: height)
    }
    
    
    // cell 선택시 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<3 {
            let index = IndexPath(item: i, section: 0)
            if let cell = collectionView.cellForItem(at: index) as? CheckCell {
                cell.checkImageView.image = UIImage(named: "btn_deselected")
            }
        }
        
        // API 호출 위해 선택된 건물유형 저장
        selectedType = selectText[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? CheckCell {
            cell.checkImageView.image = UIImage(named: "btn_selected")
        }
    }
}

protocol DatePickerDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

