//
//  CalculateViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//

import UIKit
import SnapKit

class CalculateViewController: UIViewController {
    //MARK: - UI ProPerties
    // UINavigationBar 선언("< 사기 가능성 계산")
    public lazy var navigationBar = UINavigationBar()
    
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

    func SetView() {
        self.view.backgroundColor = .white
        [navigationBar, textLabel, selectLabel, selectCollectionView, addressInput, buildingNum, unitNum, sqftInput, checkButton].forEach { view in
            self.view.addSubview(view)
        }
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
    
    // checkButton 누르면 SecondCalculateViewController() 보여주는 액션
    @objc func checkButtonTapped() {
        let VC = SecondCalculateViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func setData() {
        addressInput.textInputLabel.text = "주소"
        addressInput.textInputTextField.font = .Clutch.baseMedium
        addressInput.textInputTextField.textColor = .Clutch.textBlack
        addressInput.textInputTextField.attributedPlaceholder = NSAttributedString(string: "지번 또는 도로명 주소", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
        
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
        addressInput.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        buildingNum.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        sqftInput.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        unitNum.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
    }
    
    @objc func textCheck() {
        let allFieldsFilled =
        addressInput.textInputTextField.text?.isEmpty == false &&
        buildingNum.textInputTextField.text?.isEmpty == false &&
        unitNum.textInputTextField.text?.isEmpty == false &&
        sqftInput.textInputTextField.text?.isEmpty == false
        
        print(allFieldsFilled)
        let indexPaths = selectCollectionView.indexPathsForSelectedItems
        let isCellSelected = indexPaths != nil && !indexPaths!.isEmpty
        
        if isCellSelected && allFieldsFilled {
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
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(65)
            make.leading.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(144)
            make.leading.equalToSuperview().offset(16)
        }
        
        selectLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(260)
            make.leading.equalToSuperview().offset(16)
        }
        
        selectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(selectLabel.snp.bottom).offset(3.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(132)
        }
        
        addressInput.snp.makeConstraints { make in
            make.top.equalTo(selectCollectionView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(16)
        }
        
        buildingNum.snp.makeConstraints { make in
            make.top.equalTo(addressInput.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
        }
        
        unitNum.snp.makeConstraints { make in
            make.top.equalTo(addressInput.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(213)
        }
        
        sqftInput.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(600)
            make.leading.equalToSuperview().offset(16)
        }
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
  

}

//MARK: - extension
extension CalculateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            }
        }
        
        // API 호출 위해 선택된 건물유형 저장
        selectedType = selectText[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? CheckCell {
            cell.checkImageView.image = UIImage(named: "btn_selected")
        }
    }
    
}
