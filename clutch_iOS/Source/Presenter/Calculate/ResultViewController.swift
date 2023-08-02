//
//  CalculateResult.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/07/28.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    //MARK: - UI ProPerties
    // UINavigationBar 선언("< 사기 위험성 판단")
    public lazy var navigationBar = UINavigationBar()
    
    // UIScrollView 선언(스크롤을 위한 스크롤 뷰)
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()

    // UIView 선언(스크롤 뷰 안에 들어갈 내용을 표시할 뷰)
    let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // UIView 선언(위험/안전 gif) -> 조건문에 따른 이미지 처리
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Done_round")
        
        return view
    }()
    
    // UILabel 선언("위험 단계") -> 계산 결과에 따라 조건문으로 처리
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "위험 단계"
        label.font = UIFont.Clutch.headtitlebold
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    // UILabel 선언("전세사기 위험성이 높다고 판단되었어요")
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "전세사기 위험성이 높다고 판단되었어요"
        label.font = UIFont.Clutch.baseMedium
        label.textColor = UIColor.Clutch.textDarkGrey
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    // UIView 선언(구분선)
    lazy var firstUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        
        return view
    }()
    
    // UILabel 선언("주소")
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.font = UIFont.Clutch.subheadMedium
        label.textColor = UIColor.Clutch.textDarkerGrey
        label.textAlignment = .left
        label.numberOfLines = 1
        
        return label
    }()
    
    // UILabel 선언(주소)
    lazy var addressOutputLabel: UILabel = {
        let label = UILabel()
        label.text = "경기도 고양시 일산서구 일산3동\n505동 606호" // -> 주소 데이터로 처리
        label.font = UIFont.Clutch.subheadMedium
        label.textColor = UIColor.Clutch.textDarkerGrey
        label.textAlignment = .right
        label.numberOfLines = 2
        
        return label
    }()
    
    // UIView 선언
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    // UILabel 선언("건물시세 - (근저당액 + 나의 전세금) > 0\n결과가 양수이면 안전, 음수이면 위험으로 판단해요.")
    lazy var formulaLabel: UILabel = {
        let label = UILabel()
        label.text = "건물시세 - (근저당액 + 나의 전세금) > 0\n결과가 양수이면 안전, 음수이면 위험으로 판단해요."
        label.font = UIFont.Clutch.baseMedium
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        
        // 줄 간격 설정
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        // 줄 별로 다른 글자 색깔 적용
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttribute(.foregroundColor, value: UIColor.Clutch.textDarkGrey ?? .black, range: (label.text! as NSString).range(of: "결과가 양수이면 안전, 음수이면 위험으로 판단해요."))
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        
        return label
    }()
    
//    // UITextView 선언("건물시세 - (근저당액 + 나의 전세금) > 0\n결과가 양수이면 안전, 음수이면 위험으로 판단해요.")
//    lazy var formulaView: UITextView = {
//        let view = UITextView()
//        view.text = "건물시세 - (근저당액 + 나의 전세금) > 0\n결과가 양수이면 안전, 음수이면 위험으로 판단해요."
//        view.textColor = .black
//        view.font = .Clutch.baseMedium
//        view.backgroundColor = .Clutch.bgGrey
//        view.layer.cornerRadius = 12
//        view.isScrollEnabled = false
//        view.isUserInteractionEnabled = false
//
//        let attributedString = NSMutableAttributedString(string: view.text)
//        attributedString.addAttribute(.foregroundColor, value: UIColor.Clutch.textDarkerGrey ?? .black, range: (view.text as NSString).range(of: "결과가 양수이면 안전, 음수이면 위험으로 판단해요."))
//        view.attributedText = attributedString
//
//        return view
//    }()
    
    // OutputView() 선언(시세, 근저당액, 전세금, 보증금 액수)
    let marketPriceOutput = OutputView()
    let morgagePriceOutput = OutputView()
    let leasePriceOutput = OutputView()
    let depositPriceOutput = OutputView()
    
    // UIView 선언(구분선)
    lazy var secondUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        
        return view
    }()
    
    // OutputView() 선언(계산 결과)
    let totalOutput = OutputView()
    
    // UIButton 선언("확인")
    lazy var checkButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .Clutch.bgGrey
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .Clutch.subheadMedium
        btn.setTitleColor(.Clutch.textDarkGrey, for: .normal)
        btn.setTitle("확인", for: .normal)
        return btn
    }()
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Clutch.mainWhite
        self.checkButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        SetView()
        OutputViewSet()
        navigationBarSet()
        
        Constraint()
    }
    
    //MARK: - Properties
    
    //MARK: - Set Ui
    func SetView() {
        self.view.backgroundColor = .white
        
        [scrollview, checkButton].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        [navigationBar, imageView, statusLabel, textLabel, firstUnderLine, addressLabel, addressOutputLabel, backgroundView, formulaLabel, marketPriceOutput, morgagePriceOutput, leasePriceOutput, depositPriceOutput, secondUnderLine, totalOutput, ].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    func OutputViewSet() {
        marketPriceOutput.categoryLabel.text = "시세"
        marketPriceOutput.outputLabel.text = "2,000,000,000 원"
        
        morgagePriceOutput.categoryLabel.text = "근저당액"
        morgagePriceOutput.outputLabel.text = "2,000,000,000 원"
        
        leasePriceOutput.categoryLabel.text = "전세금"
        leasePriceOutput.outputLabel.text = "2,000,000,000 원"
        
        depositPriceOutput.categoryLabel.text = "보증금 액수"
        depositPriceOutput.outputLabel.text = "200,000,000 원"
        
        totalOutput.categoryLabel.text = "계산 결과"
        totalOutput.outputLabel.text = "-3,000,000 원"
    }
    
    func navigationBarSet() {
        let navigationItem = UINavigationItem()
        navigationItem.title = "사기 위험성 판단"
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
        present(SecondCalculateViewController(), animated: true)
    }
    
    // checkButton 누르면 MainViewController() 보여주는 액션
    @objc func didTapButton() {
        let secondVC = MainViewController()
        self.present(secondVC, animated: true, completion: nil)
    }
    
    func Constraint() {
        navigationBar.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(65)
            make.leading.equalToSuperview()
        }
        
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.frame.height * 1.2)
        }
        
        checkButton.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(97)
            make.width.equalTo(91)
            make.top.equalToSuperview().offset(127)
            make.leading.equalToSuperview().offset(151)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(245)
            make.leading.equalToSuperview().offset(149)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(289)
            make.leading.equalToSuperview().offset(76)
        }
        
        firstUnderLine.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(357)
            make.width.equalToSuperview()
            make.height.equalTo(8)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(409)
            make.leading.equalToSuperview().offset(20)
        }
        
        addressOutputLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(409)
            make.leading.equalToSuperview().offset(152)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.height.equalTo(86
            )
            make.width.equalTo(361)
            make.top.equalToSuperview().offset(499)
            make.leading.equalToSuperview().offset(16)
        }
        
        formulaLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(518)
            make.leading.equalToSuperview().offset(38)
        }
        
        marketPriceOutput.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(629)
            make.centerX.equalToSuperview()
        }
        
        morgagePriceOutput.snp.makeConstraints { make in
            make.top.equalTo(marketPriceOutput.snp.top).offset(55)
            make.centerX.equalToSuperview()
        }
        
        leasePriceOutput.snp.makeConstraints { make in
            make.top.equalTo(morgagePriceOutput.snp.top).offset(55)
            make.centerX.equalToSuperview()
        }
        
        depositPriceOutput.snp.makeConstraints { make in
            make.top.equalTo(leasePriceOutput.snp.top).offset(55)
            make.centerX.equalToSuperview()
        }
        
        secondUnderLine.snp.makeConstraints { make in
            make.top.equalTo(depositPriceOutput.snp.top).offset(55)
            make.width.equalToSuperview()
            make.height.equalTo(2)
        }
        
        totalOutput.snp.makeConstraints { make in
            make.top.equalTo(secondUnderLine.snp.top).offset(35)
            make.centerX.equalToSuperview()
        }
        
    }
    
}
