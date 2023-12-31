//
//  CalculateHistory.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class CalculateHistoryViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    //MARK: - properties
    let date = ["2023년 7월 25일", "2023년 6월 04일"]
    let state = ["위험 단계", "안전 단계"]
    let address = ["서울특별시 용산구 청파로47길 100", "경기도 고양시 일산서구 일산3동"]
    let post = ["", "505동 606호"]
    
    var calculateResult:[GetReport.GetCaculate] = []
    
    //MARK: - UI propereties
    // UINavigationBar 선언("< 사기 가능성 조회 내역")
    public lazy var navigationBar = UINavigationBar()
    
    //스크롤 뷰 안에 들어갈 내용을 표시할 뷰
    let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // UIView 선언
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    // UIButton 선언(투명 버튼)
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        button.layer.cornerRadius = 12
        
        // ClutchIntroViewController
        
        return button
    }()
    
    // UIView 선언(물음표 이미지)
    lazy var leftImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Question_fill")
        
        return view
    }()
    
    // UIView 선언(">" 이미지)
    lazy var rightImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "btn_arrow_small")
        
        return view
    }()
    
    // UILabel 선언("클러치에 대해 설명드릴게요\n사기가능성을 어떻게 판단하는지 알려드려요")
    lazy var introLabel: UILabel = {
        let label = UILabel()
        label.text = "클러치에 대해 설명드릴게요\n사기가능성을 어떻게 판단하는지 알려드려요"
        label.font = UIFont.Clutch.baseMedium
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        
        // 줄 간격 설정
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        // 줄별로 다른 글자 폰트 적용
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttribute(.font, value: UIFont.Clutch.smallMedium, range: (label.text! as NSString).range(of: "사기가능성을 어떻게 판단하는지 알려드려요"))
        // 줄별로 다른 글자 색깔 적용
        attributedString.addAttribute(.foregroundColor, value: UIColor.Clutch.textDarkGrey ?? .black, range: (label.text! as NSString).range(of: "사기가능성을 어떻게 판단하는지 알려드려요"))
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        // small/medium
        // 라벨에 이미지 넣는 법
        //        let attributedString = NSMutableAttributedString(string: "")
        //        let imageAttachment = NSTextAttachment()
        //        imageAttachment.image = UIImage(named: "heart")
        //        attributedString.append(NSAttributedString(attachment: imageAttachment))
        
        return label
    }()
    
    // UIView 선언(구분선)
    lazy var seperateLine1: UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        
        return view
    }()
    
    // UITableView 선언
    lazy var tableView1 : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    // UIView 선언(구분선)
    lazy var seperateLine2: UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.bgGrey
        
        return view
    }()
    
    lazy var noResultLabel: UILabel = {
        let Label = UILabel()
        Label.font = .Clutch.smallBold
        Label.textColor = .Clutch.textDarkGrey
        
        return Label
    }()
    
    
    
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Clutch.mainWhite
        button.addTarget(self, action: #selector(goToClutchIntro), for: .touchUpInside)
        request()
        SetView()
        tableViewSet()
        navigationBarSet()
        Constraint()
    }
    //MARK: - Network
    
    func request() {
        APIManger.shared.callGetRequest(baseEndPoint: .calculate, addPath: "") { JSON in
            do {
                // JSON 데이터를 GetCaculate 배열로 디코딩합니다.
                let decoder = JSONDecoder()
                let calculateResult = try decoder.decode([GetReport.GetCaculate].self, from: JSON["information"].rawData())
                
                // 디코딩이 성공하면 배열에 데이터를 할당하고 테이블 뷰를 리로드합니다.
                self.calculateResult = calculateResult
                self.tableView1.reloadData()
                self.noResultLabelSet()
            } catch {
                print("JSON 디코딩 오류: \(error.localizedDescription)")
            }
        }
    }
    
    func SetView() {
        self.view.backgroundColor = .white
        
        [navigationBar, backgroundView, button, leftImageView, rightImageView, introLabel, seperateLine1, tableView1, noResultLabel].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    func noResultLabelSet() {
        if calculateResult.count == 0 {
            noResultLabel.text = "결과 내역이 없습니다."
        } else {
            noResultLabel.text = ""
        }
    }
    
    func tableViewSet() {
        [tableView1].forEach { tableView in
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.register(CalculateHistoryCell.self, forCellReuseIdentifier: "cell")
            tableView.rowHeight = 180
            tableView.selectionFollowsFocus = false
        }
    }
    
    func navigationBarSet() {
        let navigationItem = UINavigationItem()
        navigationItem.title = "사기 가능성 조회 내역"
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
    
    @objc func goToClutchIntro() {
        let clutchIntroVC = ClutchIntroViewController()
        navigationController?.pushViewController(clutchIntroVC, animated: true)
    }
    
    func Constraint() {
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.height.equalTo(76)
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(76)
            make.width.equalTo(361)
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(144)
            make.leading.equalToSuperview().offset(34)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(147)
            make.leading.equalToSuperview().offset(344.45)
        }
        
        introLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(135)
            make.leading.equalToSuperview().offset(70)
        }
        
        seperateLine1.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(12)
            make.top.equalTo(220)
        }
        
        tableView1.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(seperateLine1.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        noResultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculateResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CalculateHistoryCell
        else { return UITableViewCell() }
        
        let row = indexPath.row
        let reversedArray = calculateResult.reversed()
        let index = reversedArray.index(reversedArray.startIndex, offsetBy: row)
        
        let result = reversedArray[index].price - reversedArray[index].collateralMoney - reversedArray[index].deposit
        
        if result < 0 {
            cell.stateLabel.text = "위험 단계"
        } else {
            cell.stateLabel.text = "안전 단계"
        }
        
        cell.addressInfoLabel.text = reversedArray[index].address
        cell.postInfoLabel.text = reversedArray[index].dong + "동" + reversedArray[index].ho + "호"
        cell.selectionStyle = .none
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let reversedArray = calculateResult.reversed()
        let index = reversedArray.index(reversedArray.startIndex, offsetBy: row)
        
        let result = reversedArray[index].price - reversedArray[index].collateralMoney - reversedArray[index].deposit
        
        
        let VC = ResultViewController()
        let address = reversedArray[index].address
        let dong = reversedArray[index].dong
        let ho = reversedArray[index].ho
        VC.addressOutputLabel.text = "\(address)\n\(dong)동 \(ho)호"
        VC.addressOutputLabel.numberOfLines = 2
        VC.marketPriceOutput.categoryLabel.text = "시세"
        VC.marketPriceOutput.outputLabel.text = decimalPoint(reversedArray[index].price) + "원"
        
        VC.morgagePriceOutput.categoryLabel.text = "근저당액"
        VC.morgagePriceOutput.outputLabel.text = decimalPoint(reversedArray[index].collateralMoney) + "원"
        
        VC.leasePriceOutput.categoryLabel.text = "전세금"
        VC.leasePriceOutput.outputLabel.text = decimalPoint(reversedArray[index].deposit) + "원"
        
        VC.totalOutput.categoryLabel.text = "계산 결과"
        VC.totalOutput.outputLabel.text = decimalPoint(result) + "원"
        
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
            VC.completeGifImage = UIImageView(gifImage: gif, loopCount: 1) // Will loop 1 times
        } catch {
            VC.completeGifImage = UIImageView()
        }
        
        if result < 0 {
            //위험
            VC.statusLabel.text = "위험 단계"
        }
        else {
            //안전
            VC.statusLabel.text = "안전 단계"

        }
        
        VC.statusLabel.font = UIFont.Clutch.headtitlebold
        VC.statusLabel.textColor = UIColor.black
        VC.statusLabel.textAlignment = .center
        VC.statusLabel.numberOfLines = 1
        
        if result < 0 {
            //위험
            VC.textLabel.text = "전세사기 위험성이 높다고 판단되었어요"
        }
        else {
            //안전
            VC.textLabel.text = "전세사기 위험성이 낮다고 판단되었어요"
        }
        VC.textLabel.font = UIFont.Clutch.baseMedium
        VC.textLabel.textColor = UIColor.Clutch.textDarkGrey
        VC.textLabel.textAlignment = .center
        VC.textLabel.numberOfLines = 1
        
        VC.fromVC = "History"
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
}
