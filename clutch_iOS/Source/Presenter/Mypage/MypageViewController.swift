//
//  MypageViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/01.
//

import UIKit
import SnapKit

class MypageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: - Properties
    lazy var logout = false
    
    // MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
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
        label.text = "내 정보 확인"
        label.textColor = UIColor.Clutch.textDarkGrey
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.Clutch.smallMedium
        
        return label
    }()
    
    //우측 화살표 이미지화
    lazy var rightArrowImageView:UIImageView =  {
        let image = UIImageView()
        image.image = UIImage(named: "btn_arrow_small")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .Clutch.textDarkGrey?
        return image
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
        request()
        
        // infoLabel에 UITapGestureRecognizer 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(infoLabelTapped))
        infoLabel.isUserInteractionEnabled = true
        infoLabel.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Network
    func request() {
        APIManger.shared.callGetRequest(baseEndPoint: .user, addPath: "/users") { JSON in
            let id = JSON["information"]["id"].stringValue
            let name = JSON["information"]["name"].stringValue
            let eamil = JSON["information"]["email"].stringValue
            let phonenumber = JSON["information"]["phonenumber"].stringValue
            
            let information = Information(id: id, name: name, email: eamil, phonenumber: phonenumber)
            
            DispatchQueue.main.async {
                self.nameLabel.text = information.name + "님"
            }
        }
    }
    
    
    
    
    // infoLabel 터치 이벤트 처리
    @objc func infoLabelTapped() {
        let VC = ProfileViewController() // ProfileViewController의 인스턴스 생성
        navigationController?.pushViewController(VC, animated: true)
    }
    
    // openURL 메소드
    func openURL(_ url:String) {
        guard let URL = URL(string: url) else {
            return
        }
        UIApplication.shared.open(URL, options: [:], completionHandler: nil)
    }
    
    //VC의 view 관련 설정
    func setView() {
        [navigationBar, nameLabel, infoLabel, rightArrowImageView, underLine, historyLabel, collectionView1, inquiryLabel, collectionView2, accountLabel, collectionView3].forEach { view in
            self.view.addSubview(view)
        }
        setNavigationBar()
        collectionviewSet()
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

    
    //VC의 오토레이아웃
    func Constraint() {
        let leading:Int = 16
        
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalToSuperview().offset(127)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.trailing.equalTo(rightArrowImageView.snp.leading)
            make.top.equalToSuperview().offset(130)
        }
        
        rightArrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(infoLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(infoLabel.snp.centerY)
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
            make.height.equalTo(80)
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
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // collectionview 관련 설정
    func collectionviewSet() {
        [collectionView1, collectionView2, collectionView3].forEach { collectionview in
            collectionview.dataSource = self
            collectionview.delegate = self
            collectionview.isScrollEnabled = false
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
        if collectionView == collectionView1 {
            switch indexPath.row {
            case 0:
                let VC = ReportDoneViewController()
                navigationController?.pushViewController(VC, animated: true)
            case 1:
                let VC = CalculateHistoryViewController()
                navigationController?.pushViewController(VC, animated: true)
            default :
                return
            }
        } else if collectionView == collectionView2 {
            switch indexPath.row {
            case 0:
                showCustomAlert(alertType: .done,
                                alertTitle: "앱 버전",
                                alertContext: "ver 1.0 Demo",
                                confirmText: "확인")
            case 1:
                let url:String = "https://www.naver.com/"
                openURL(url)
            case 2:
                let VC = InquiryViewController()
                navigationController?.pushViewController(VC, animated: true)
            default :
                return
            }
        } else if collectionView == collectionView3 {
            switch indexPath.row {
            case 0:
                showCustomAlert(alertType: .canCancel,
                                alertTitle: "로그아웃",
                                alertContext: "정말로 로그아웃 하시겠습니까?",
                                cancelText: "취소",
                                confirmText: "로그아웃")
            case 1:
                let VC = WithdrawViewController()
                navigationController?.pushViewController(VC, animated: true)
            default :
                return
            }
        } else {
            return
        }
        
    }
    
}

//MARK: - extension
extension MypageViewController: CustomAlertDelegate {
    
    func cancel() {
        print("custom cancel Button Tapped")
    }
    
    func confirm() {
        print("custom action Button Tapped")
        // 로그아웃 API 호출
        let response = "200"
        if response == "200" {
            logout = true
        }
        
        if logout {
            showCustomAlert(alertType: .done,
                            alertTitle: "로그아웃 완료",
                            alertContext: "정상적으로 로그아웃 되었습니다.",
                            confirmText: "확인")
        }
        // 오류 발생시 메시지 출력
        else {
            showCustomAlert(alertType: .done,
                            alertTitle: "오류 발생",
                            alertContext: "다시 시도해주세요.",
                            confirmText: "확인")
        }
    }
    
    func done() {
        // 로그아웃 되었으면 로그인 화면으로 pop
        if logout {
            navigationController?.popToRootViewController(animated: true)
        }
        
        
    }
    
}
