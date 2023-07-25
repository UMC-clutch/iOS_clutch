//
//  CustomPopupViewController.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/20.
//

import Foundation
import UIKit

protocol CustomPopupDelegate {
    func getSelectedCell(selected: String)
}

class CustomPopupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: CustomPopupDelegate?
    
    //MARK: - UI ProPerties
    
    lazy var popupTitle = "(alertTitle)"
    lazy var popupList: [String] = ["cell1", "cell2", "cell3", "cell4"]
    lazy var selectedCell = ""
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .Clutch.mainWhite
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        // 삭제 버튼 이미지로 변경 필요
        button.setImage(UIImage(named: "btn_Close_round"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = popupTitle
        label.font = .Clutch.subtitleBold
        
        return label
    }()
    
    //MARK: - Define Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
        setCollectionview()
    }
    
    func setView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        
        [titleLabel, closeButton, collectionView].forEach { view
            in self.container.addSubview(view) }
        self.view.addSubview(container)
    }
    
    func setConstraint() {
        container.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailingMargin.equalToSuperview().offset(16)
            make.height.equalTo(344)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(36)
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-28)
            make.top.equalToSuperview().offset(36)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.bottom.equalToSuperview().offset(-36)
        }
    }
    
    // 닫기 버튼 동작
    @objc func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.getSelectedCell(selected: self.selectedCell)
        }
    }
    
    func setCollectionview() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        
        collectionView.register(CustomPopupCell.self, forCellWithReuseIdentifier: "CustomPopupCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomPopupCell", for: indexPath) as? CustomPopupCell else {
            return UICollectionViewCell()
        }
        
        cell.textLabel.text = popupList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width
        let height = collectionView.frame.height / 4
        let size = CGSize(width: width, height: height)
        return size
    }
    
    // cell 선택시 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<self.popupList.count {
            let index = IndexPath(item: i, section: 0)
            if let cell = collectionView.cellForItem(at: index) as? CustomPopupCell {
                cell.textLabel.textColor = .Clutch.textBlack
                cell.checkImageView.isHidden = true
            }
        }
        
        selectedCell = popupList[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomPopupCell {
            cell.textLabel.textColor = .Clutch.mainDarkGreen
            cell.checkImageView.isHidden = false
        }
    }
}

// CustomAlert을 간결하게 재사용하기 위한 메소드 구현
extension CustomPopupDelegate where Self: UIViewController {
    func showCustomPopup(
        popupTitle: String,
        popupList : [String]
    ) {
        lazy var customPopupViewController = CustomPopupViewController()
        customPopupViewController.delegate = self
        
        customPopupViewController.modalTransitionStyle = .crossDissolve
        customPopupViewController.modalPresentationStyle = .overFullScreen
        customPopupViewController.popupTitle = popupTitle
        customPopupViewController.popupList = popupList
        self.present(customPopupViewController, animated: true, completion: nil)
    }
}
