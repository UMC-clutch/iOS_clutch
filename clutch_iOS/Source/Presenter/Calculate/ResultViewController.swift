//
//  CalculateResult.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/07/28.
//
/*
 let marketPrice: Int64 = 2000000000

 let numberFormatter: NumberFormatter = NumberFormatter()
 numberFormatter.numberStyle = .decimal
 let decimalMarketPrice: String = numberFormatter.string(for: marketPrice)!

 marketPriceOutput.outputLabel.text = "\(marketPrice) 원"
 
 */

import Foundation
import UIKit
import SwiftyGif

class ResultViewController: UIViewController {
    //MARK: - properties
    lazy var danger = true
    lazy var marketPrice: Int64 = 2000000000
    lazy var morgagePrice: Int64 = 2000000000
    lazy var leasePrice: Int64 = 2000000000
    lazy var depositPrice: Int64 = 200000000
    lazy var total: Int64 = -3000000
    var buildingPrice:PostBuildingPrice?
    var postCalculate:PostCalculate?
    lazy var fromVC = ""
    
    //MARK: - UI ProPerties
    // UINavigationBar 선언("< 사기 위험성 판단")
    public lazy var navigationBar = UINavigationBar()
    
    // UIScrollView 선언(스크롤을 위한 스크롤 뷰)
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()

    // UIView 선언(스크롤 뷰 안에 들어갈 내용을 표시할 뷰)
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // UIImageView 선언(위험/안전 gif) -> 조건문에 따른 이미지 처리
    lazy var completeGifImage:UIImageView = {
        
        guard let buildingprice = buildingPrice else { return UIImageView()}
        guard let postcalculate = postCalculate else { return UIImageView()}
        
        let result = buildingprice.price - postcalculate.collateral - postcalculate.deposit
        
        do {
            lazy var gif = UIImage()
            
            if result < 0 {
                //위험
                try gif.setGif("img_clutch_danger.gif")
            }
            else {
                //안전
                try gif.setGif("img_clutch_safe.gif")
            }
            let imageview = UIImageView(gifImage: gif, loopCount: 1) // Will loop 1 times
            return imageview
        }
        catch {
            let imageView = UIImageView()
            let iamge = UIImage(named: "clutch_logo")
            imageView.image = iamge
    
            return imageView
        }
    }()
    
    // UILabel 선언("위험 단계") -> 계산 결과에 따라 조건문으로 처리
    lazy var statusLabel: UILabel = {
        guard let buildingprice = buildingPrice else { return UILabel()}
        guard let postcalculate = postCalculate else { return UILabel()}
        
        let result = buildingprice.price - postcalculate.collateral - postcalculate.deposit
        
        let label = UILabel()
        if result < 0 {
            //위험
            label.text = "위험 단계"
        }
        else {
            //안전
            label.text = "안전 단계"
        }
        label.font = UIFont.Clutch.headtitlebold
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    // UILabel 선언("전세사기 위험성이 높다고 판단되었어요")
    lazy var textLabel: UILabel = {
        guard let buildingprice = buildingPrice else { return UILabel()}
        guard let postcalculate = postCalculate else { return UILabel()}
        
        let result = buildingprice.price - postcalculate.collateral - postcalculate.deposit
        
        let label = UILabel()
        if result < 0 {
            //위험
            label.text = "전세사기 위험성이 높다고 판단되었어요"
        }
        else {
            //안전
            label.text = "전세사기 위험성이 낮다고 판단되었어요"
        }
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
        let address = buildingPrice?.address ?? ""
        let dong = buildingPrice?.dong ?? ""
        let ho = buildingPrice?.ho ?? ""
        label.text = "\(address)\n\(dong)동 \(ho)호"
        label.font = UIFont.Clutch.subheadMedium
        label.textColor = UIColor.Clutch.textBlack
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
        
        // 줄별로 다른 글자 색깔 적용
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttribute(.foregroundColor, value: UIColor.Clutch.textDarkGrey ?? .black, range: (label.text! as NSString).range(of: "결과가 양수이면 안전, 음수이면 위험으로 판단해요."))
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        
        return label
    }()
    
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
        btn.backgroundColor = .Clutch.mainDarkGreen
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .Clutch.subheadMedium
        btn.setTitleColor(.Clutch.mainWhite, for: .normal)
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

    func SetView() {
        self.view.backgroundColor = .white
        
        [navigationBar, scrollview].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        
        [completeGifImage, statusLabel, textLabel, firstUnderLine, addressLabel, addressOutputLabel, backgroundView, formulaLabel, marketPriceOutput, morgagePriceOutput, leasePriceOutput, secondUnderLine, totalOutput, checkButton].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    func OutputViewSet() {
        
        guard let buildingprice = buildingPrice else { return}
        guard let postcalculate = postCalculate else { return}
        
        marketPriceOutput.categoryLabel.text = "시세"
        marketPriceOutput.outputLabel.text = decimalPoint(buildingprice.price) + "원"
        
        morgagePriceOutput.categoryLabel.text = "근저당액"
        morgagePriceOutput.outputLabel.text = decimalPoint(postcalculate.collateral) + "원"
        
        leasePriceOutput.categoryLabel.text = "전세금"
        leasePriceOutput.outputLabel.text = decimalPoint(postcalculate.deposit) + "원"
        
//        depositPriceOutput.categoryLabel.text = "보증금 액수"
//        depositPriceOutput.outputLabel.text = "\(decimalPoint(depositPrice)) 원"
        
        totalOutput.categoryLabel.text = "계산 결과"
        
        let result = buildingprice.price - postcalculate.collateral - postcalculate.deposit
        
        print(result)
        totalOutput.outputLabel.text = "\(decimalPoint(result)) 원"
    }
    
    func navigationBarSet() {
        let navigationItem = UINavigationItem()
        navigationItem.title = "사기 위험성 판단"
        let iamge = UIImage(systemName: "chevron.backward")
        let backButton = UIBarButtonItem(image: UIImage(named: "btn_arrow_big"), style: .plain, target: self, action: #selector(backButtonTapped))
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
    
    // checkButton 누르면 MainViewController() 보여주는 액션
    @objc func didTapButton() {
        // 계산내역에서 불러졌으면 뒤로
        if fromVC == "History" {
            navigationController?.popViewController(animated: true)
        }
        // 아니면 메인으로
        else {
            if let VC = navigationController?.viewControllers.first(where: {$0 is MainViewController}) {
                        navigationController?.popToViewController(VC, animated: true)
            }
        }
    }
    
    func Constraint() {
        let top = 44
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
        
        completeGifImage.snp.makeConstraints { make in
            make.height.equalTo(125)
            make.width.equalTo(125)
            make.top.equalToSuperview().offset(top)
            make.centerX.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(completeGifImage.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(149)
            make.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(76)
            make.centerX.equalToSuperview()
        }
        
        firstUnderLine.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(top)
            make.width.equalToSuperview()
            make.height.equalTo(8)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(firstUnderLine.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(20)
        }
        
        addressOutputLabel.snp.makeConstraints { make in
            make.top.equalTo(firstUnderLine.snp.bottom).offset(top)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.height.equalTo(86)
            make.top.equalTo(addressOutputLabel.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        formulaLabel.snp.makeConstraints { make in
//            make.top.equalTo(backgroundView.snp.top).offset(19)
//            make.leading.equalTo(backgroundView.snp.leading).offset(22)
            make.centerX.equalTo(backgroundView)
            make.centerY.equalTo(backgroundView)
        }
        
        marketPriceOutput.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom).offset(top)
            make.centerX.equalToSuperview()
        }
        
        morgagePriceOutput.snp.makeConstraints { make in
            make.top.equalTo(marketPriceOutput.snp.top).offset(top)
            make.centerX.equalToSuperview()
        }
        
        leasePriceOutput.snp.makeConstraints { make in
            make.top.equalTo(morgagePriceOutput.snp.top).offset(top)
            make.centerX.equalToSuperview()
        }
        
        secondUnderLine.snp.makeConstraints { make in
            make.top.equalTo(leasePriceOutput.snp.top).offset(top)
            make.width.equalToSuperview()
            make.height.equalTo(2)
        }
        
        totalOutput.snp.makeConstraints { make in
            make.top.equalTo(secondUnderLine.snp.top).offset(top)
            make.centerX.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.top.equalTo(totalOutput.snp.bottom).offset(60)
        }
        
    }
    
}

