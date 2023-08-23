//
//  ReportViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//

import UIKit
import SnapKit

class ReportViewController: UIViewController, UIScrollViewDelegate {
    //MARK: - properties
    lazy var selectText = ["아파트/오피스텔", "다가구", "상가"]
    lazy var selectedType = ""
    
    //MARK: - UI ProPerties
    public lazy var navigationBar = UINavigationBar()
    
    //스크롤을 위한 스크롤 뷰
    lazy var scrollview:UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    //스크롤 뷰 안에 들어갈 내용을 표시할 뷰
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
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
    let sqftInput = TextInputView()
    
    lazy var buildingTypeLabel:UILabel = {
        let label = UILabel()
        label.text = "건물 유형"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    
    // 체크 박스
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
        button.setTitleColor(.Clutch.textDarkGrey, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        
        // Highlighted 상태일 때 배경색
        let iamge = image(withColor: .Clutch.mainGreen!)
        
        button.isEnabled = false
        button.backgroundColor = .Clutch.bgGrey
        return button
    }()
    
    lazy var exampleButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("", for: .normal)
        btn.addTarget(self, action: #selector(exampleButtonTapped), for: .touchUpInside)
        btn.isEnabled = true
        return btn
    }()
    

    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        requestGet()
        SetView()
        Constraint()
        textChange()
    }
    

    func SetView() {
        TextInputViewSet()
        SmallTextInputViewSet()
        addsubview()
        setCollectionview()
        setNavigationBar()
        self.view.backgroundColor = .Clutch.mainWhite
    }
    
    func textChange() {
        buildingNameLabel.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        mortgageDateLabel.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        addressLabel.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        buildingNum.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        unitNum.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        sqftInput.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
    }
    
    @objc func textCheck() {
    
        let allFieldsFilled =
        buildingNameLabel.textInputTextField.text?.isEmpty == false &&
        mortgageDateLabel.textInputTextField.text?.isEmpty == false &&
        addressLabel.textInputTextField.text?.isEmpty == false &&
        buildingNum.textInputTextField.text?.isEmpty == false &&
        unitNum.textInputTextField.text?.isEmpty == false &&
        sqftInput.textInputTextField.text?.isEmpty == false
        
        print(allFieldsFilled)
        let indexPaths = selectCollectionView.indexPathsForSelectedItems
        let isCellSelected = indexPaths != nil && !indexPaths!.isEmpty
        
        if isCellSelected && allFieldsFilled {
            nextButton.backgroundColor = .Clutch.mainDarkGreen
            nextButton.setTitleColor(.Clutch.mainWhite, for: .normal)
            nextButton.isEnabled = true
        } else {
            nextButton.backgroundColor = .Clutch.bgGrey
            nextButton.isEnabled = false
        }
        
    }
    
    @objc func exampleButtonTapped() {
        buildingNameLabel.textInputTextField.text = "한남더힐"
        addressLabel.textInputTextField.text = "서울특별시 용산구 독서당로 111"
        buildingNum.textInputTextField.text = "131"
        unitNum.textInputTextField.text = "101"
        sqftInput.textInputTextField.text = "87A"
        
        buildingNameLabel.textIsEmpty()
        addressLabel.textIsEmpty()
        buildingNum.textIsEmpty()
        unitNum.textIsEmpty()
        sqftInput.textIsEmpty()
    }
    
 
    func addsubview() {
        [navigationBar, scrollview].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        [titleLabel, buildingNameLabel, mortgageDateLabel, dateButton, addressLabel, buildingNum, unitNum, sqftInput, buildingTypeLabel, selectCollectionView, nextButton].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //스크롤 뷰관련 셋
    func setscrollview() {
        scrollview.delegate = self
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
        buildingNameLabel.textInputTextField.font = .Clutch.baseMedium
        buildingNameLabel.textInputTextField.textColor = .Clutch.textBlack
        buildingNameLabel.textInputTextField.attributedPlaceholder = NSAttributedString(string: "정확한 건물명을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
        
        mortgageDateLabel.textInputLabel.text = "근저당 설정 기준일"
        mortgageDateLabel.textInputTextField.font = .Clutch.baseMedium
        mortgageDateLabel.textInputTextField.textColor = .Clutch.textBlack
        mortgageDateLabel.textInputTextField.attributedPlaceholder = NSAttributedString(string: "날짜를 선택해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
        mortgageDateLabel.textInputTextField.isUserInteractionEnabled = false
            
        addressLabel.textInputLabel.text = "주소"
        addressLabel.textInputTextField.font = .Clutch.baseMedium
        addressLabel.textInputTextField.textColor = .Clutch.textBlack
        addressLabel.textInputTextField.attributedPlaceholder = NSAttributedString(string: "지번 또는 도로명 주소", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
        
        sqftInput.textInputLabel.text = "평수"
        sqftInput.textInputTextField.font = .Clutch.baseMedium
        sqftInput.textInputTextField.textColor = .Clutch.textBlack
        sqftInput.textInputTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
    }
    
    func SmallTextInputViewSet() {
        buildingNum.textInputLabel.isHidden = true
        buildingNum.textInputTextField.placeholder = ""
        buildingNum.textInputTextField.textColor = .Clutch.textBlack
        
        unitNum.textInputLabel.isHidden = true
        unitNum.textInputTextField.placeholder = ""
        unitNum.textInputTextField.textColor = .Clutch.textBlack
        unitNum.leftLabel.text = "호"
    }
    
    func Constraint() {
        let leading = 16
        let top = 40
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
        }
        
        scrollview.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(880)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalToSuperview().offset(top)
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
            make.trailing.equalTo(sqftInput.snp.trailing)
            make.top.equalTo(addressLabel.snp.bottom)
        }
        
        sqftInput.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(buildingNum.snp.bottom).offset(top)
        }
        
        buildingTypeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(sqftInput.snp.bottom).offset(top)
            
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
            make.top.equalTo(selectCollectionView.snp.bottom).offset(65)
            make.height.equalTo(53)
        }
        
        exampleButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(titleLabel.snp.width)
            make.height.equalTo(titleLabel.snp.height)
        }
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func ButtonTapped(_ sender: UIButton) {
        requestReportBuilding()
    }
    
    @objc func dateButtonTapped(_ sender: UIButton) {
        showDatePicker(title: "근저당 설정일을\n선택해주세요")
    }
    
}

//MARK: - extension
extension ReportViewController: DatePickerDelegate,
                                UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CustomAlertDelegate {
    func didSelectDate(title:String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let formattedDate = dateFormatter.string(from: date)
        if title == "근저당 설정일을\n선택해주세요" {
            mortgageDateLabel.textInputTextField.text = formattedDate
            mortgageDateLabel.textIsEmpty()
        }
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
        textCheck()
    }
    
    // 오류발생 시 팝업 위한 커스텀 알림
    func cancel() {
        self.navigationController?.popViewController(animated: true)
    }
    func confirm() {
        let VC = ReportDoneViewController()
        VC.fromVC = "Main"
        navigationController?.pushViewController(VC, animated: true)
    }
    func done() { return }

    //MARK: - Network
    func requestReportBuilding() {
        
    // 신고하기 API 호출
        let parameter: [String:String] = [
              "buildingName": buildingNameLabel.textInputTextField.text ?? "",
              "address": addressLabel.textInputTextField.text ?? "" ,
              "dong": buildingNum.textInputTextField.text ?? "",
              "ho": unitNum.textInputTextField.text ?? "",
              "collateralDate": dateForDB(inDateStr: mortgageDateLabel.textInputTextField.text ?? ""),
              "type": "APARTMENT",
              "area": sqftInput.textInputTextField.text ?? ""
        ]
        print(parameter)
        APIManger.shared.callPostRequest(baseEndPoint: .report, addPath: "/building", parameters: parameter) { JSON in
            // 호출 오류시 처리
            if JSON["check"].boolValue == false {
                self.showCustomAlert(alertType: .done,
                                     alertTitle: "오류 발생",
                                     alertContext: "다시 시도해주세요.",
                                     confirmText: "확인")
                return
            }
            
            // 정상적으로 호출 시 알림 없이 다음 화면으로 전환
            let buildingID = JSON["information"]["buildingId"].intValue
            
            // 다음 호출 uri에 필요한 빌딩ID 전달
            let VC = ContractInfoViewController()
            VC.buildingID = buildingID
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func requestGet() {
        APIManger.shared.callGetRequest(baseEndPoint: .report, addPath: "/comp") { JSON in
            // 신고 내역이 없는 경우
            if !(JSON["information"].isEmpty) {
                self.showCustomAlert(alertType: .canCancel,
                                     alertTitle: "전세사기 피해 접수 완료",
                                     alertContext: "신고 내역을 조회하시겠습니까?",
                                     cancelText: "메인으로",
                                     confirmText: "조회")
                return
            }
            
            print("정상 : 신고 내역 없음")
        }
    }
}

