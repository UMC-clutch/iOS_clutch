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

    lazy var selectLabel: UILabel = {
        let label = UILabel()
        label.text = "건물 유형"
        label.font = UIFont.Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    // -> 체크 한개씩만 가능하도록 변경
    // 체크 박스(아파트/오피스텔, 다가구, 상가)
    let checkBox1 = CheckContainer()
    let checkBox2 = CheckContainer()
    let checkBox3 = CheckContainer()
    
    // 주소 입력란 제목 및 첫번째 줄
    let addressInput = TextInputView()
    
    // -> 입력되고 있을 때 "주소" 초록 글씨로 변경
    // -> 입력되는 폰트만 subheadRegular 으로 변경
    // 주소 입력란 두번째 줄("상세주소(예: 층수, 동, 호)")
    lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.font = .Clutch.baseMedium
        textField.textColor = .Clutch.textBlack
        textField.attributedPlaceholder = NSAttributedString(string: "상세주소(예: 층수, 동, 호)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
        
        return textField
    }()
    
    // -> 입력되고 있을 때 초록색으로 변경
    // UIView 선언(회색 구분선)
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Clutch.bgGrey
        
        return view
    }()
    
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
    }
    
    //MARK: - Properties
    
    
    //MARK: - Set Ui
    func SetView() {
        self.view.backgroundColor = .white
        [navigationBar, textLabel, selectLabel, checkBox1, checkBox2, checkBox3, addressInput, addressTextField, underLine, sqftInput, checkButton].forEach { view in
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
        present(MypageViewController(), animated: true)
    }
    
    func setData() {
        checkBox1.checkLabel.text = "아파트/오피스텔"
        checkBox2.checkLabel.text = "다가구"
        checkBox3.checkLabel.text = "상가"
        
        addressInput.textInputLabel.text = "주소"
        addressInput.textInputTextField.font = .Clutch.baseMedium
        addressInput.textInputTextField.textColor = .Clutch.textBlack
        addressInput.textInputTextField.attributedPlaceholder = NSAttributedString(string: "지번 또는 도로명 주소", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
        
        sqftInput.textInputLabel.text = "평수"
        sqftInput.textInputTextField.font = .Clutch.baseMedium
        sqftInput.textInputTextField.textColor = .Clutch.textBlack
        sqftInput.textInputTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Clutch.mainGrey ?? .black])
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
        
        checkBox1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(296)
            make.leading.equalToSuperview().offset(16)
        }
        
        checkBox2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(339)
            make.leading.equalToSuperview().offset(16)
        }
        
        checkBox3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(383)
            make.leading.equalToSuperview().offset(16)
        }
        
        addressInput.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(453)
            make.leading.equalToSuperview().offset(16)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(539)
            make.leading.equalToSuperview().offset(16)
        }

        underLine.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(565)
            make.width.equalToSuperview()
            make.height.equalTo(2)
            make.centerX.equalToSuperview()
        }

        
        sqftInput.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(611)
            make.leading.equalToSuperview().offset(16)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(700)
            make.centerX.equalToSuperview()
            make.width.equalTo(361)
            make.height.equalTo(53)
        }
    }
  

}
