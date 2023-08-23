//
//  CalculateViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//

import UIKit
import SnapKit

class CalculateViewController: UIViewController, UIScrollViewDelegate {
    //MARK: - Properties
    lazy var completed = false
    var buildingPrice:PostBuildingPrice?
    
    //MARK: - UI ProPerties
    // UINavigationBar 선언("< 사기 가능성 계산")
    public lazy var navigationBar = UINavigationBar()
    
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
    
    // UILabel 선언("시세 조회를 위한/n정보를 입력해주세요")
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "시세 조회를 위한\n정보를 입력해주세요"
        label.textColor = UIColor.Clutch.textBlack
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.Clutch.headtitlebold
        
        return label
    }()
    
    // UILabel 선언("건물 유형")
    lazy var selectLabel: UILabel = {
        let label = UILabel()
        label.text = "건물 유형"
        label.font = UIFont.Clutch.smallMedium
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
    // 건물명 입력
    let buildingNameInput = TextInputView()
    
    // 주소 입력란 제목 및 첫번째 줄("지번 또는 도로명 주소")
    let addressInput = TextInputView()
    
    // 주소 입력란 두번째 줄(동, 호)
    let buildingNum = SmallTextInputView()
    let unitNum = SmallTextInputView()
    
    // 평수 입력란
    let sqftInput = TextInputView()
    
    // UIButton 선언("시세 조회")
    lazy var checkButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .Clutch.bgGrey
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .Clutch.subheadMedium
        btn.setTitleColor(.Clutch.textDarkGrey, for: .normal)
        btn.setTitle("시세 조회", for: .normal)
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        btn.isEnabled = false
        return btn
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
        self.view.backgroundColor = .Clutch.mainWhite
        
        SetView()
        navigationBarSet()
        setData()
        Constraint()
        setCollectionview()
        textChange()
    }
    
    //MARK: - Network
    func requestPost() {
        
        let parameter = [
            "buildingName": buildingNameInput.textInputTextField.text ?? "",
            "address": addressInput.textInputTextField.text ?? "" ,
            "dong": buildingNum.textInputTextField.text ?? "",
            "ho": unitNum.textInputTextField.text ?? "",
            "type": "APARTMENT",
            "area": sqftInput.textInputTextField.text ?? ""
        ]
        
        APIManger.shared.callPostRequest(baseEndPoint: .building, addPath: "", parameters: parameter) { JSON in
            // 호출 오류시 처리
            if JSON["check"].boolValue == false {
                self.showCustomAlert(alertType: .done,
                                alertTitle: "오류 발생",
                                alertContext: "다시 시도해주세요.",
                                confirmText: "확인")
                return
            }
            
            let buildingID = JSON["information"]["buildingId"].intValue
            let price = JSON["information"]["price"].intValue
            let buildingName = JSON["information"]["buildingName"].stringValue
            let address = JSON["information"]["address"].stringValue
            let dong = JSON["information"]["dong"].stringValue
            let ho = JSON["information"]["ho"].stringValue
            let type = JSON["information"]["type"].stringValue
            let area = JSON["information"]["area"].stringValue
            
            
            let info = PostBuildingPrice(buildingId: buildingID, price: price, buildingName: buildingName, address: address, dong: dong, ho: ho, type: type, area: area)
            
            self.buildingPrice = info
            
            // 알림창 호출, 확인 누르면 화면전환
            self.completed = true
            self.showCustomAlert(alertType: .done,
                            alertTitle: "시세조회 완료",
                            alertContext: "정상적으로 조회되었습니다.",
                            confirmText: "확인")
        }

    }

    func SetView() {
        [navigationBar, scrollview].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        [buildingNameInput, textLabel, selectLabel, selectCollectionView, addressInput, buildingNum, unitNum, sqftInput, checkButton, exampleButton].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //스크롤 뷰관련 셋
    func setscrollview() {
        scrollview.delegate = self
    }
    
    func navigationBarSet() {
        let navigationItem = UINavigationItem()
        navigationItem.title = "사기 가능성 계산"
        let iamge = UIImage(systemName: "chevron.backward")
        let backButton = UIBarButtonItem(image:iamge, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Clutch.mainWhite // 배경색 변경
        navigationBar.shadowImage = UIImage() // 테두리 없애기
        self.navigationBar.tintColor = .black // 백버튼 색깔 변경
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // 제목 텍스트 색상
            .font: UIFont.Clutch.subheadBold
        ]
        navigationBar.titleTextAttributes = titleTextAttributes // 제목 스타일 적용
    }
    
    // -> 네비게이션뷰 만든 후 navigationController?.popViewController(animated: true)로 변경
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func checkButtonTapped() {
        print("시세조회 API 호출")
        requestPost()
    }
    
    @objc func exampleButtonTapped() {
        buildingNameInput.textInputTextField.text = "한남더힐"
        addressInput.textInputTextField.text = "서울특별시 용산구 독서당로 111"
        buildingNum.textInputTextField.text = "131"
        unitNum.textInputTextField.text = "101"
        sqftInput.textInputTextField.text = "87A"
        buildingNameInput.textIsEmpty()
        addressInput.textIsEmpty()
        buildingNum.textIsEmpty()
        unitNum.textIsEmpty()
        sqftInput.textIsEmpty()
        self.textCheck()

    }
    
    func setData() {
        
        buildingNameInput.textInputLabel.text = "건물명"
        buildingNameInput.textInputTextField.font = .Clutch.baseMedium
        buildingNameInput.textInputTextField.textColor = .Clutch.textBlack
        buildingNameInput.textInputTextField.attributedPlaceholder = NSAttributedString(string: "정확한 건물명을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
        
        addressInput.textInputLabel.text = "주소"
        addressInput.textInputTextField.font = .Clutch.baseMedium
        addressInput.textInputTextField.textColor = .Clutch.textBlack
        addressInput.textInputTextField.attributedPlaceholder = NSAttributedString(string: "도로명 주소를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
        
        sqftInput.textInputLabel.text = "평수"
        sqftInput.textInputTextField.font = .Clutch.baseMedium
        sqftInput.textInputTextField.textColor = .Clutch.textBlack
        sqftInput.textInputTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
        
        buildingNum.textInputLabel.isHidden = true
        buildingNum.textInputTextField.placeholder = ""
        buildingNum.textInputTextField.textColor = .Clutch.textBlack
        
        unitNum.textInputLabel.isHidden = true
        unitNum.textInputTextField.placeholder = ""
        unitNum.textInputTextField.textColor = .Clutch.textBlack
        unitNum.leftLabel.text = "호"
    }
    
    func textChange() {
        addressInput.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        buildingNum.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        sqftInput.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
        unitNum.textInputTextField.addTarget(self, action: #selector(textCheck), for: .allEvents)
    }
    
    @objc func textCheck() {
        let allFieldsFilled =
        addressInput.textInputTextField.text?.isEmpty == false &&
        buildingNum.textInputTextField.text?.isEmpty == false &&
        unitNum.textInputTextField.text?.isEmpty == false &&
        sqftInput.textInputTextField.text?.isEmpty == false
        
        let indexPaths = selectCollectionView.indexPathsForSelectedItems
        let isCellSelected = indexPaths != nil && !indexPaths!.isEmpty
        
        if allFieldsFilled {
            checkButton.backgroundColor = .Clutch.mainDarkGreen
            checkButton.setTitleColor(.Clutch.mainWhite, for: .normal)
            checkButton.isEnabled = true
        } else {
            checkButton.backgroundColor = .Clutch.bgGrey
            checkButton.isEnabled = false
        }
    }
    
    func Constraint() {
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
            make.height.equalTo(730)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        selectLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        selectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(selectLabel.snp.bottom).offset(3.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(132)
        }
        
        buildingNameInput.snp.makeConstraints { make in
            make.top.equalTo(selectCollectionView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addressInput.snp.makeConstraints { make in
            make.top.equalTo(buildingNameInput.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        buildingNum.snp.makeConstraints { make in
            make.top.equalTo(addressInput.snp.bottom)
            make.leading.equalToSuperview().offset(16)
        }
        
        unitNum.snp.makeConstraints { make in
            make.top.equalTo(addressInput.snp.bottom)
            make.trailing.equalTo(addressInput.snp.trailing)
        }
        
        sqftInput.snp.makeConstraints { make in
            make.top.equalTo(buildingNum.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.top.equalTo(sqftInput.underLine.snp.bottom).offset(60)
        }
        
        exampleButton.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.top)
            make.leading.equalTo(textLabel.snp.leading)
            make.width.equalTo(textLabel.snp.width)
            make.height.equalTo(textLabel.snp.height)
        }
    }
  

}

//MARK: - extension
extension CalculateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CustomAlertDelegate {
    // collectionview 관련 설정
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
                self.textCheck()
            }
        }
        
        // API 호출 위해 선택된 건물유형 저장
        selectedType = selectText[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? CheckCell {
            cell.checkImageView.image = UIImage(named: "btn_selected")
        }
    }
    
    func cancel() { return }
    
    func confirm() { return }
    
    func done() {
        if completed {
            let VC = SecondCalculateViewController()
            VC.buildingPrice = self.buildingPrice
            print(self.buildingPrice)
            
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}
