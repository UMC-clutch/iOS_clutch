//
//  ContractInfoViewController.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/26.
//

import Foundation
import UIKit

class ContractInfoViewController: UIViewController, UIScrollViewDelegate {
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    lazy var residentText = ["거주하고 있어요", "거주하고 있지 않아요"]
    lazy var interventionText = ["개입했어요", "개입하지 않았어요"]
    lazy var dividenText = ["신청했어요", "신청하지 않았어요"]
    
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
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "계약 관련 정보를\n입력해주세요"
        label.numberOfLines = 2
        label.font = .Clutch.headtitlebold
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    lazy var residentLabel:UILabel = {
        let label = UILabel()
        label.text = "실거주 여부"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var residentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
    lazy var interventionLabel:UILabel = {
        let label = UILabel()
        label.text = "집주인의 채권 개입 여부"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    var interventionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
    lazy var dividenLabel:UILabel = {
        let label = UILabel()
        label.text = "배당신청 여부"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    var dividenCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
    lazy var submitButton:UIButton = {
        let button = UIButton()
        button.setTitle("제출", for: .normal)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        constraints()
    }
    //뷰관련 셋
    func setView() {
        setNavigationBar()
        addsubview()
        setscrollview()
        setCollectionview()
        self.view.backgroundColor = .Clutch.mainWhite
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
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
    
    //addsubview
    func addsubview() {
        [navigationBar, scrollview, submitButton].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        [titleLabel, residentLabel, residentCollectionView, interventionLabel, interventionCollectionView, dividenLabel, dividenCollectionView].forEach { view in
            contentView.addSubview(view)
        }
    }
    //스크롤 뷰관련 셋
    func setscrollview() {
        scrollview.delegate = self
        
    }
    
    func constraints() {
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
        }
        //스크롤 뷰 오토레이아웃
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //contentView 오토레이아웃
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.frame.height * 3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(navigationBar.snp.bottom).offset(52)
        }
        
        residentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(44)
        }
        
        residentCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(residentLabel.snp.bottom).offset(12)
            make.height.equalTo(67)
        }
        
        interventionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(residentCollectionView.snp.bottom).offset(44)
        }
        
        interventionCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(interventionLabel.snp.bottom).offset(12)
            make.height.equalTo(67)
        }
        
        dividenLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(interventionCollectionView.snp.bottom).offset(44)
        }
        
        dividenCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(dividenLabel.snp.bottom).offset(12)
            make.height.equalTo(67)
        }
        
        //버튼 오토레이아웃
        submitButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
        
        
    }
}

extension ContractInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @objc func backButtonTapped() {
        // 이전 view로 돌아가는 코드 필요
        print("Back Button Tapped")
    }
    
    // 버튼 클릭 시 스크롤되도록 하는 메서드
    @objc func ButtonTapped(_ sender: UIButton) {
        let offsetY = scrollview.contentSize.height / 10
        let contentOffset = CGPoint(x: 0, y: scrollview.contentOffset.y + offsetY)
        
        // Check if the content offset reaches the bottom of the scroll view
        if contentOffset.y >= scrollview.contentSize.height - scrollview.bounds.height {
            // Scroll to the top
            let topOffset = CGPoint(x: 0, y: 0)
            scrollview.setContentOffset(topOffset, animated: true)
        } else {
            // Scroll by 1/5 of the height
            scrollview.setContentOffset(contentOffset, animated: true)
        }
    }
    
    // collectionview 관련 설정
    func setCollectionview() {
        [residentCollectionView, interventionCollectionView, dividenCollectionView].forEach { collectionview in
            collectionview.dataSource = self
            collectionview.delegate = self
            collectionview.isScrollEnabled = false
        }
        
        residentCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "CheckCell1")
        interventionCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "CheckCell2")
        dividenCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "CheckCell3")
    }
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    // cell에 들어갈 data 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.residentCollectionView {
            guard let cell1 = residentCollectionView.dequeueReusableCell(withReuseIdentifier: "CheckCell1", for: indexPath) as? CheckCell else {
                return UICollectionViewCell()
            }
            
            cell1.textLabel.text = residentText[indexPath.row]
            return cell1
            
        } else if collectionView == self.interventionCollectionView {
            guard let cell2 = interventionCollectionView.dequeueReusableCell(withReuseIdentifier: "CheckCell2", for: indexPath) as? CheckCell else {
                return UICollectionViewCell()
            }
            
            cell2.textLabel.text = interventionText[indexPath.row]
            return cell2
            
        } else if collectionView == self.dividenCollectionView{
            guard let cell3 = dividenCollectionView.dequeueReusableCell(withReuseIdentifier: "CheckCell3", for: indexPath) as? CheckCell else {
                return UICollectionViewCell()
            }
            
            cell3.textLabel.text = dividenText[indexPath.row]
            return cell3
            
        }
        return UICollectionViewCell()
        
    }
    
    // cell 크기 및 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height = collectionView.frame.height / 2
        return CGSize(width: width, height: height)
    }
    
    
    // cell 선택시 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<2 {
            let index = IndexPath(item: i, section: 0)
            if let cell = collectionView.cellForItem(at: index) as? CheckCell {
                cell.checkImageView.image = UIImage(named: "btn_deselected")
            }
        }
        
//        selectedCell = popupList[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? CheckCell {
            cell.checkImageView.image = UIImage(named: "btn_selected")
        }
    }
    
}
