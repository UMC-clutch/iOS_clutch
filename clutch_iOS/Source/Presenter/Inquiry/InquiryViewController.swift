//
//  InquiryViewController.swift
//  clutch_iOS
//
//  Created by 현종혁 on 2023/07/18.
//

import Foundation
import UIKit
import SnapKit
//import DropDown

class InquiryViewController: UIViewController {
    // MARK: - UI ProPerties
    // UINavigationBar 선언("< 문의하기")
    public lazy var navigationBar = UINavigationBar()
    
    // 인스턴스에 InputScreen() 할당
    let nameInput = InputScreen()
    let categoryInput = InputScreen()
    let inquiryInput = InputScreen()

    // 드롭다운 메뉴
//    public lazy var dropDown: DropDown = {
//        let dropDown = DropDown()
//        dropDown.dataSource = ["문의 유형1", "문의 유형2", "문의 유형3", "문의 유형4"]
//        dropDown.show()
//        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
//        dropDown.width = 150
//        dropDown.textColor = UIColor.black
//        dropDown.selectedTextColor = UIColor.red
//        dropDown.textFont = UIFont.systemFont(ofSize: 20)
//        dropDown.backgroundColor = UIColor.white
//        dropDown.cellHeight = 50
//        dropDown.cornerRadius = 10
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("선택한 아이템 : \(item)")
//            print("인덱스 : \(index)")
//        }
//
//        return dropDown
//    }()
    
    // 텍스트뷰
    public lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.font = UIFont.Clutch.baseMedium
        textView.textColor = UIColor.Clutch.textDarkGrey
        textView.backgroundColor = UIColor.Clutch.bgGrey
//        textView.textInputView.backgroundColor = UIColor.Clutch.bgGrey
        textView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainerInset = .init(top: 18, left: 23, bottom: 18, right: 23)
        textView.scrollIndicatorInsets = .init(top: 18, left: 10, bottom: 18, right: 23)
        
        return textView
    }()
    
    // UIButton 선언("문의하기")
    lazy var checkButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .Clutch.bgGrey
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .Clutch.subheadMedium
        btn.setTitleColor(.Clutch.textDarkGrey, for: .normal)
        btn.setTitle("문의하기", for: .normal)
        return btn
    }()
    
    // MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setData()
        setView()
        Constraint()
    }
    
    //MARK: - Set Ui
    func setView() {
        [navigationBar, nameInput.titleLabel, nameInput.textLabel, nameInput.underLine, categoryInput.titleLabel, categoryInput.underLine, inquiryInput.titleLabel, textView, checkButton].forEach { view in
            self.view.addSubview(view)
        }
        navigationBarSet()
    }
    
    func setData() {
        nameInput.titleLabel.text = "이메일"
        nameInput.textLabel.text = "email@example.com"
        
        categoryInput.titleLabel.text = "문의 유형"
        categoryInput.textLabel.text = "카테고리를 선택해주세요"
        
        inquiryInput.titleLabel.text = "문의 내용"
        inquiryInput.textLabel.text = "내용을 적어주세요"
    }
    
    func navigationBarSet() {
        let navigationItem = UINavigationItem()
        navigationItem.title = "문의하기"
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
    
    // -> 네비게이션뷰 만든 후 navigationController?.popViewController(animated: true)로 변경
    @objc func backButtonTapped() {
        present(MypageViewController(), animated: true)
    }
    
    func Constraint() {
        navigationBar.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(65)
            make.leading.equalToSuperview()
        }
        
        nameInput.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(142)
        }
        
        nameInput.textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(171)
        }
        
        nameInput.underLine.snp.makeConstraints{ make in
            make.width.equalTo(360)
            make.height.equalTo(2)
            make.top.equalToSuperview().offset(197)
            make.centerX.equalToSuperview()
        }
        
        categoryInput.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(239)
        }
        
//        dropDown.snp.makeConstraints { make in
//            make.width.equalTo(360)
//            make.height.equalTo(24)
//            make.leading.equalToSuperview().offset(16)
//            make.top.equalToSuperview().offset(268)
//            make.centerX.equalToSuperview()
//        }
      
        categoryInput.underLine.snp.makeConstraints{ make in
            make.width.equalTo(360)
            make.height.equalTo(2)
            make.top.equalToSuperview().offset(298)
            make.centerX.equalToSuperview()
        }
        
        inquiryInput.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(340)
        }
        
        textView.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(200)
            make.top.equalToSuperview().offset(369)
            make.centerX.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(700)
            make.centerX.equalToSuperview()
            make.width.equalTo(361)
            make.height.equalTo(53)
        }
        
    }
}
