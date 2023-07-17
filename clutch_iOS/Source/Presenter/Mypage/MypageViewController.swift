//
//  MypageViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//

import UIKit
import SnapKit

class MypageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UI ProPerties
    // -> NavigationBar 선언("<")
//    let navigationBar = UINavigationBar()
    
    // UILabel 선언("조혜원님")
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "조혜원님" // -> 아이디 값 받아서 처리
        label.textColor = UIColor.Clutch.textBlack
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.Clutch.subtitleBold
        
        return label
    }()
    
    // UILabel 선언("내 정보 확인") -> ProfileViewController로 이동 처리
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "내 정보 확인 >"
        label.textColor = UIColor.Clutch.textDarkGrey
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.Clutch.smallMedium
        
        return label
    }()
    
    // UIView 선언(회색 구분선)
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Clutch.bgGrey
        
        return view
    }()
    
    // UILabel 선언("이용 내역")
    lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.text = "이용 내역"
        label.textColor = UIColor.Clutch.textBlack
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.Clutch.subheadBold
        
        return label
    }()
    
    // UICollectionView1 선언
    var collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        
        return view
    }()
    
    // UILabel 선언("앱 정보 및 문의")
    lazy var inquiryLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 정보 및 문의"
        label.textColor = UIColor.Clutch.textBlack
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.Clutch.subheadBold
        
        return label
    }()
    
    // UICollectionView2 선언
    var collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        
        return view
    }()
    
    // UILabel 선언("계정")
    lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "계정"
        label.textColor = UIColor.Clutch.textBlack
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.Clutch.subheadBold
        
        return label
    }()
    
    // UICollectionView3 선언
    var collectionView3: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        
        return view
    }()
    
    // MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Clutch.mainWhite
        setView()
        Constraint()
        cellRegister()
        
        // infoLabel에 UITapGestureRecognizer 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(infoLabelTapped))
        infoLabel.isUserInteractionEnabled = true
        infoLabel.addGestureRecognizer(tapGesture)
    }
    
    // infoLabel 터치 이벤트 처리
    @objc func infoLabelTapped() {
        let VC = ProfileViewController() // ProfileViewController의 인스턴스 생성
        present(VC, animated: true)
    }
    
    // openURL 메소드
    func openURL(_ url:String) {
        guard let URL = URL(string: url) else {
            return
        }
        UIApplication.shared.open(URL, options: [:], completionHandler: nil)
    }
    
    //MARK: - Set Ui
    //VC의 view 관련 설정
    func setView() {
        [nameLabel, infoLabel, underLine, historyLabel, collectionView1, inquiryLabel, collectionView2, accountLabel, collectionView3].forEach { view in
            self.view.addSubview(view)
        }
        collectionviewSet()
//        navigationBarSet()
    }
    
    // 네비게이션바 관련 설정
//    func navigationBarSet() {
//        let navigationItem = UINavigationItem()
//        let backButton = UIBarButtonItem(image:UIImage(named: "mypage"), style: .plain, target: self, action: #selector(myPageButtonTapped))
//        navigationItem.leftBarButtonItem = backButton
//        navigationBar.setItems([navigationItem], animated: false) // 이부분 다시 공부 -> 다시 공부
//        navigationBar.barTintColor = .Clutch.bgGrey // 배경색 변경
//        navigationBar.shadowImage = UIImage() //테두리 없애기 -> 다시 공부
//    }
//
    
    //VC의 오토레이아웃
    func Constraint() {
        let leading:Int = 16
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalToSuperview().offset(127)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(289)
            make.top.equalToSuperview().offset(130)
        }
        
        underLine.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(8)
            make.top.equalToSuperview().offset(191)
            make.centerX.equalToSuperview()
        }
        
        historyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalToSuperview().offset(231)
        }
        
        collectionView1.snp.makeConstraints { make in
            make.width.equalTo(361)
            make.height.equalTo(70)
            make.leading.equalTo(leading)
            make.top.equalTo(270)
        }
        
        inquiryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalToSuperview().offset(410)
        }
        
        collectionView2.snp.makeConstraints { make in
            make.width.equalTo(361)
            make.height.equalTo(120)
            make.leading.equalTo(leading)
            make.top.equalTo(449)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalToSuperview().offset(639)
        }
        
        collectionView3.snp.makeConstraints { make in
            make.width.equalTo(361)
            make.height.equalTo(70)
            make.leading.equalTo(leading)
            make.top.equalTo(678)
        }
    }
    
    // collectionview 관련 설정
    func collectionviewSet() {
        [collectionView1, collectionView2, collectionView3].forEach { collectionview in
            collectionview.dataSource = self
            collectionview.delegate = self
        }
    }
    
    // cell 등록
    func cellRegister() {
        collectionView1.register(HistoryCell.self, forCellWithReuseIdentifier: "HistoryCell")
        collectionView2.register(InfoCell.self, forCellWithReuseIdentifier: "InfoCell")
        collectionView3.register(AccountCell.self, forCellWithReuseIdentifier: "AccountCell")
    }
    
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            return 2
        } else if collectionView == collectionView2 {
            return 3
        } else if collectionView == collectionView3 {
            return 2
        }
        return 0
    }
    
    // cell에 들어갈 data 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let historyCellText = ["전세사기 피해 신고 내역", "전세 사기 가능성 계산 내역"]
        let infoCellText = ["앱 버전", "약관 및 정책", "문의하기"]
        let accountCellText = ["로그아웃", "탈퇴하기"]
        
        if collectionView == self.collectionView1 {
            guard let cell1 = collectionView1.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
                return UICollectionViewCell()
            }
            
            cell1.textLabel.text = historyCellText[indexPath.row]
            return cell1
            
        } else if collectionView == self.collectionView2 {
            guard let cell2 = collectionView2.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as? InfoCell else {
                return UICollectionViewCell()
            }
            
            cell2.textLabel.text = infoCellText[indexPath.row]
            return cell2
            
        } else if collectionView == self.collectionView3{
            guard let cell3 = collectionView3.dequeueReusableCell(withReuseIdentifier: "AccountCell", for: indexPath) as? AccountCell else {
                return UICollectionViewCell()
            }
            
            cell3.textLabel.text = accountCellText[indexPath.row]
            return cell3
            
        }
        return UICollectionViewCell()
        
    }
    
    // cell 크기 및 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case collectionView1:
            let width: CGFloat = collectionView1.frame.width
            let height = collectionView1.frame.height / 2
            let size = CGSize(width: width, height: height)
            return size
        case collectionView2:
            let width: CGFloat = collectionView2.frame.width
            let height = collectionView1.frame.height / 2
            let size = CGSize(width: width, height: height)
            return size
        case collectionView3:
            let width: CGFloat = collectionView3.frame.width
            let height = collectionView1.frame.height / 2
            let size = CGSize(width: width, height: height)
            return size
        default:
            return CGSize.zero
        }
    }
    
    
    // -> cell 액션 이벤트(눌렀을 때 페이지 이동)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CalculateViewController()
        
        if collectionView == collectionView1 {
            switch indexPath.row {
            case 0:
                present(vc, animated: true) // "전세사기 피해 신고 내역" 페이지로 이동
            case 1:
                present(vc, animated: true) // "전세사기 가능성 계산 내역" 페이지로 이동
            default :
                return
            }
        } else if collectionView == collectionView2 {
            switch indexPath.row {
            case 0:
                present(vc, animated: true) // "앱 버전" 페이지로 이동
            case 1:
                let url:String = "https://www.naver.com/"
                openURL(url)
            case 2:
                present(vc, animated: true) // "문의하기" 페이지로 이동
            default :
                return
            }
        } else if collectionView == collectionView3 {
            switch indexPath.row {
            case 0:
                present(vc, animated: true) // "로그아웃" 페이지로 이동
            case 1:
                present(vc, animated: true) // "탈퇴하기" 페이지로 이동
            default :
                return
            }
        } else {
            return
        }
        
    }
    
}
