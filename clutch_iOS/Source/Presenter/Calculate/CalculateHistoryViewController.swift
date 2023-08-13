//
//  CalculateHistory.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/08/07.
//

import Foundation
import UIKit

struct Calculte: Codable {
    let id, buildingID, addressID: Int
    let buildingName, address, dong, ho: String
    let price, collateralMoney, deposit: Int
    let isDangerous: Bool
}

class CalculateHistoryViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    //MARK: - properties
    let date = ["2023년 7월 25일", "2023년 6월 04일"]
    let state = ["위험 단계", "안전 단계"]
    let address = ["서울특별시 용산구 청파로47길 100", "경기도 고양시 일산서구 일산3동"]
    let post = ["", "505동 606호"]
    
    //MARK: - UI propereties
    // UINavigationBar 선언("< 사기 가능성 조회 내역")
    public lazy var navigationBar = UINavigationBar()
    
    //스크롤을 위한 스크롤 뷰
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
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
        view.image = UIImage(named: "clutch_logo")
        
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
    
    // UITableView 선언
    lazy var tableView2 : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Clutch.mainWhite
        button.addTarget(self, action: #selector(goToClutchIntro), for: .touchUpInside)
        
        SetView()
        tableViewSet()
        navigationBarSet()
        Constraint()
    }
    //MARK: - Network
    
    func request() {
        APIManger.shared.callGetRequest(baseEndPoint: .calculate, addPath: nil) { JSON in
            let id = JSON["id"].intValue
            let buildingID = JSON["buildingID"].intValue
            let addressID = JSON["addressID"].intValue
            let buildingName = JSON["buildingName"].stringValue
            let address = JSON["address"].stringValue
            let dong = JSON["dong"].stringValue
            let ho = JSON["ho"].stringValue
            let price = JSON["price"].intValue
            let collateralMoney = JSON["collateralMoney"].intValue
            let deposit = JSON["deposit"].intValue
            let isDangerous = JSON["isDangerous"].boolValue
            
            let calculte = Calculte(id: id, buildingID: buildingID, addressID: addressID, buildingName: buildingName, address: address, dong: dong, ho: ho, price: price, collateralMoney: collateralMoney, deposit: deposit, isDangerous: isDangerous)
            
            DispatchQueue.main.async {
                
            }
        }
    }
    
    func SetView() {
        self.view.backgroundColor = .white
        
        [scrollview].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        [navigationBar, backgroundView, button, leftImageView, rightImageView, introLabel, seperateLine1, tableView1, seperateLine2, tableView2].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    func tableViewSet() {
        [tableView1, tableView2].forEach { tableView in
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.register(CalculateHistoryCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    func navigationBarSet() {
        let navigationItem = UINavigationItem()
        navigationItem.title = "사기 가능성 조회 내역"
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
    
    @objc func goToClutchIntro() {
        let clutchIntroVC = ClutchIntroViewController()
        navigationController?.pushViewController(clutchIntroVC, animated: true)
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
        
        backgroundView.snp.makeConstraints { make in
            make.height.equalTo(76)
            make.width.equalTo(361)
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(16)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(76)
            make.width.equalTo(361)
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(16)
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
            make.width.equalTo(361)
            make.height.equalTo(190)
            make.top.equalTo(seperateLine1.snp.top).offset(48)
            make.centerX.equalToSuperview()
        }
        
        seperateLine2.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(12)
            make.top.equalTo(tableView1.snp.top).offset(212)
        }
        
        tableView2.snp.makeConstraints { make in
            make.width.equalTo(361)
            make.height.equalTo(190)
            make.top.equalTo(seperateLine2.snp.top).offset(48)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CalculateHistoryCell else {
            return UITableViewCell()
        }
        
        if tableView == tableView1 {
            cell.dateLabel.text = date[0]
            cell.stateLabel.text = state[0]
            cell.addressInfoLabel.text = address[0]
            cell.postInfoLabel.text = post[0]
            
        } else if tableView == tableView2 {
            cell.dateLabel.text = date[1]
            cell.stateLabel.text = state[1]
            cell.addressInfoLabel.text = address[1]
            cell.postInfoLabel.text = post[1]
        }
        
        return cell
        
    }
    
}
