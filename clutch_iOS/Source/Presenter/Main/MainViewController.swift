//
//  ViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/06/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //UICollectionView 선언
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    
    //navigationBar 선언
    let navigationBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        Constraint()
    }
    
    //VC의 view 관련 설정
    func setView() {
        view.backgroundColor = .Clutch.bgGrey //배경색
        
        //addsubview
        [navigationBar, collectionview].forEach { view
            in self.view.addSubview(view) }

        navigationBarSet()
        collectionviewSet()
    }
    
    //VC의 오토레이아웃
    func Constraint() {
        //collectionView 오토레이아웃
        collectionview.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(self.view.frame.width - 20)
        }
        //navigationBar 오토레이아웃
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        
    }
    
    //collectionview 관련 설정
    func collectionviewSet() {
        collectionview.backgroundColor = .Clutch.bgGrey
        collectionview.dataSource = self
        collectionview.delegate = self
        cellRegister()
        
    }
    
    // 네비게이션바 관련 설정
    func navigationBarSet() {
        let navigationItem = UINavigationItem()
        
        // 우측 마이페이지 버튼
        let setRightImage = UIImage(named: "mypage")?.withRenderingMode(.alwaysOriginal) // 이미지 오리지널 색상 적용
        let setRightButton = UIBarButtonItem(image: setRightImage, style: .plain, target: self, action: #selector(myPageButtonTapped))
        
        // 좌측 로고
        let setLeftImage = UIImage(named: "clutch_logo")?.withRenderingMode(.alwaysOriginal) // 이미지 오리지널 색상 적용
        let setLeftButton = UIBarButtonItem(image: setLeftImage, style: .plain, target: self, action: nil)
                
        // 각 버튼 할당
        navigationItem.rightBarButtonItem = setRightButton
        navigationItem.leftBarButtonItem = setLeftButton
//        navigationItem.title
        navigationBar.setItems([navigationItem], animated: false) // 이부분 다시 공부 -> 다시 공부
        navigationBar.barTintColor = .Clutch.bgGrey // 배경색 변경
        navigationBar.shadowImage = UIImage() //테두리 없애기 -> 다시 공부
        
    }
    
    //setRightButton(마이페이지) 버튼 클릭시 액션
    @objc func myPageButtonTapped() {
        present(MypageViewController(), animated: true)
    }
    
    //cell 등록
    func cellRegister() {
        let cellIdentifiers = [
            "CellIdentifier1": MyCustomCell1.self,
            "CellIdentifier2": MyCustomCell2.self,
            "CellIdentifier3": MyCustomCell3.self,
            "CellIdentifier4": MyCustomCell4.self
        ]

        cellIdentifiers.forEach { identifier, cellClass in
            collectionview.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        //각 인덱스에 대한 cell 등록
        switch indexPath.item {
        case 0:
            cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CellIdentifier1", for: indexPath) as! MyCustomCell1
            
            return cell
            
        case 1:
            cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CellIdentifier2", for: indexPath) as! MyCustomCell2
            return cell
            
        case 2:
            cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CellIdentifier3", for: indexPath) as! MyCustomCell3
            return cell
            
        case 3:
            cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CellIdentifier4", for: indexPath) as! MyCustomCell4
            
            return cell
            
        default:
            fatalError("Invalid cell index")
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        switch indexPath.item {
            //1번 cell에 대한 크기 지정, 가로는 뷰 크기와 동일 세로는 임의 지정
        case 0:
            let width = collectionview.frame.width
            let height: CGFloat = 68
            return CGSize(width: width, height: height)
            //2번 cell에 대한 크기 지정, 가로 세로 동일
        case 1:
            let width = collectionview.frame.width
            let height: CGFloat = 226
            return CGSize(width: width, height: height)
            //3번 cell에 대한 크기 지정, 뷰의 가로 값을 2로 나눈뒤 중간 여백을 뺀 값을 가로, 세로에 할당
        default:
            let width = (collectionview.frame.width / 2 - 5)
            let height = width
            return CGSize(width: width, height: height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        // 셀 클릭에 대한 액션
        case 0:
            break
        case 1:
            present(ClutchIntroViewController(), animated: true)
            break
        case 2:
            present(CalculateViewController(), animated: true)
            break
        case 3:
            present(ReportViewController(), animated: true)
            break
        default:
            break
        }
    }
    
}
