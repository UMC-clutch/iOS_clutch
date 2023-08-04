//
//  SecondCalculateViewController.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/07/28.
//

import Foundation
import UIKit

class SecondCalculateViewController: UIViewController {
    //MARK: - UI ProPerties
    // UINavigationBar 선언("< 사기 가능성 계산")
    public lazy var navigationBar = UINavigationBar()
    
    // UILabel 선언("시세 조회를 위한/n정보를 입력해주세요")
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "사기 위험성 판단을 위해\n정보를 입력해주세요"
        label.textColor = UIColor.Clutch.textBlack
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.Clutch.headtitlebold
        
        return label
    }()
    
    // TextInputView 선언(시세 입력 칸)
    let marketPrice = TextInputView()
    
    // UILabel 선언("원")
    lazy var firstUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "원"
        label.font = UIFont.Clutch.subheadRegular
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    // TextInputView 선언(근저당액 입력 칸)
    let MortgagePrice = TextInputView()
    
    // UILabel 선언("원")
    lazy var secondUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "원"
        label.font = UIFont.Clutch.subheadRegular
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    // TextInputView 선언(지급할 전세금 입력 칸)
    let charterPrice = TextInputView()
    
    // UILabel 선언("원")
    lazy var thirdUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "원"
        label.font = UIFont.Clutch.subheadRegular
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    // UIButton 선언("완료")
    lazy var checkButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .Clutch.bgGrey
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .Clutch.subheadMedium
        btn.setTitleColor(.Clutch.textDarkGrey, for: .normal)
        btn.setTitle("완료", for: .normal)
        return btn
    }()
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Clutch.mainWhite
        self.checkButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        SetView()
        navigationBarSet()
        setData()
        Constraint()
        textChange()
    }
    
    func SetView() {
        self.view.backgroundColor = .white
        [navigationBar,textLabel, marketPrice, firstUnitLabel, MortgagePrice, secondUnitLabel, charterPrice, thirdUnitLabel, checkButton].forEach { view in
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
    
    // popVC
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // checkButton 누르면 ResultViewController() 보여주는 액션
    @objc func didTapButton() {
        let VC = ResultViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func setData() {
        marketPrice.textInputLabel.text = "시세"
        MortgagePrice.textInputLabel.text = "근저당액"
        charterPrice.textInputLabel.text = "지급할 전세금"
    }
    
    func textChange() {
        marketPrice.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        MortgagePrice.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        charterPrice.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
    }
    
    @objc func textCheck() {
        let allFieldsFilled =
        marketPrice.textInputTextField.text?.isEmpty == false &&
        MortgagePrice.textInputTextField.text?.isEmpty == false &&
        charterPrice.textInputTextField.text?.isEmpty == false
    
        print(allFieldsFilled)
        
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
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(65)
            make.leading.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(144)
            make.leading.equalToSuperview().offset(16)
        }
        
        marketPrice.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(260)
            make.leading.equalToSuperview().offset(16)
        }
        
        firstUnitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(290)
            make.leading.equalToSuperview().offset(350)
        }
        
        MortgagePrice.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(359)
            make.leading.equalToSuperview().offset(16)
        }
        
        secondUnitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(389)
            make.leading.equalToSuperview().offset(350)
        }
        
        charterPrice.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(458)
            make.leading.equalToSuperview().offset(16)
        }
        
        thirdUnitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(488)
            make.leading.equalToSuperview().offset(350)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(700)
            make.width.equalTo(360)
            make.height.equalTo(53)
            make.centerX.equalToSuperview()
        }
        
    }
    
}
