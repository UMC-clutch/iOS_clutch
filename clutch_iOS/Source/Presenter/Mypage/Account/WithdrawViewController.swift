//
//  WithdrawViewController.swift
//  clutch_iOS
//
//  Created by 이지웅 on 2023/07/13.
//

import Foundation
import UIKit

class WithdrawViewController: UIViewController {
    // MARK: - UI ProPerties
    let navigationBar = UINavigationBar()
    
    lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.text = "클러치를 탈퇴하기 전에\n확인해주세요"
        label.font = .Clutch.headtitlebold
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey

        return label
    }()

    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        //실제 text 사용자 이름으로 받아오기 필요
        label.text = "User Name"
        label.font = .Clutch.baseMedium
        label.textColor = .Clutch.textDarkGrey

        return label
    }()

    lazy var underLine1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Clutch.bgGrey

        return view
    }()
    
    lazy var reasonLabel: UILabel = {
        let label = UILabel()
        label.text = "탈퇴 사유"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey

        return label
    }()
    
    lazy var underLine2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Clutch.bgGrey

        return view
    }()
    
    // MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        setData()
        setView()
        setConstraint()
    }
        
    //MARK: - Set UI
    func setView() {
        [navigationBar, checkLabel, nameLabel, userNameLabel, underLine1, reasonLabel, underLine2].forEach { view in
            self.view.addSubview(view)
        }

        setNavigationBar()
        
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        let backButton = UIBarButtonItem(
            image:UIImage(systemName: "chevron.backward"),
            style: .plain, target: self,
            action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Clutch.mainWhite // 배경색 변경
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }
    
    @objc func backButtonTapped() {
        //이전 view로 돌아가는 코드 필요
        print("Back Button Tapped")
    }
    
    func setConstraint() {
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            // safe area에 맞추는 코드로 일반화 필요
            make.top.equalToSuperview().offset(56)
            make.leading.equalToSuperview()
        }
        
        checkLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(131)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(234)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(267)
        }

        underLine1.snp.makeConstraints{ make in
            make.height.equalTo(2)
            make.top.equalToSuperview().offset(293)
            make.left.equalToSuperview().offset(17)
            //오른쪽 여백이 안생김.. 해결 필요
            make.right.equalToSuperview().offset(17)
        }
        
        reasonLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(335)
        }
        
        underLine2.snp.makeConstraints{ make in
            make.height.equalTo(2)
            make.top.equalToSuperview().offset(394)
            make.left.equalToSuperview().offset(17)
            //오른쪽 여백이 안생김.. 해결 필요
            make.right.equalToSuperview().offset(17)
        }
    }
}
