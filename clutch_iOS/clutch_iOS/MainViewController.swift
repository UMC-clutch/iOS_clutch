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
    var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        Constraint()
    }
    
    //VC의 view 관련 설정
    func setView() {
        view.addSubview(collectionview)
        collectionviewSet()
    }
    
    //VC의 오토레이아웃
    func Constraint() {
        collectionviewConstraint()
    }
    
    //collectionview 관련 설정
    func collectionviewSet() {
        collectionview.frame.size.width = self.view.frame.width
        collectionview.frame.size.height = self.view.frame.height
        collectionview.backgroundColor = .white
        collectionview.dataSource = self
        collectionview.delegate = self
        cellRegister()
        
    }
    
    //collectionview 오토레이아웃
    func collectionviewConstraint() {
        collectionview.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // cell 식별자 등록
    func cellRegister() {
        collectionview.register(MyCustomCell1.self, forCellWithReuseIdentifier: "CellIdentifier1")
        collectionview.register(MyCustomCell2.self, forCellWithReuseIdentifier: "CellIdentifier2")
        collectionview.register(MyCustomCell3.self, forCellWithReuseIdentifier: "CellIdentifier3")
        collectionview.register(MyCustomCell4.self, forCellWithReuseIdentifier: "CellIdentifier4")
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
        switch indexPath.item {
            //1번 cell에 대한 크기 지정, 가로는 뷰 크기와 동일 세로는 임의 지정
        case 0:
            let width = collectionview.frame.width
            let height: CGFloat = 68
            return CGSize(width: width, height: height)
            //2번 cell에 대한 크기 지정, 가로 세로 동일
        case 1:
            let width = collectionview.frame.width
            let height = width
            return CGSize(width: width, height: height)
            //3번 cell에 대한 크기 지정, 뷰의 가로 값을 2로 나눈뒤 중간 여백을 뺀 값을 가로, 세로에 할당
        default:
            let width = (collectionview.frame.width / 2 - 5)
            let height = width
            return CGSize(width: width, height: height)
        }
    }
    

}

