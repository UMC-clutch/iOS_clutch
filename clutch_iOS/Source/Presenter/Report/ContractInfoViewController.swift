//
//  ContractInfoViewController.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/26.
//

import Foundation
import UIKit
import YPImagePicker

class ContractInfoViewController: UIViewController, UIScrollViewDelegate {
    //MARK: - Properties
    lazy var completed = false
    
    lazy var residentText = ["거주하고 있어요", "거주하고 있지 않아요"]
    lazy var interventionText = ["개입했어요", "개입하지 않았어요"]
    lazy var dividenText = ["신청했어요", "신청하지 않았어요"]
    lazy var images: [UIImage] = []
    
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //스크롤을 위한 스크롤 뷰
    lazy var scrollview:UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    //스크롤 뷰 안에 들어갈 내용을 표시할 뷰
    lazy var contentView: UIView = {
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
        layout.minimumLineSpacing = 0 // 상하간격
        layout.minimumInteritemSpacing = 0 // 좌우간격
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
    //전입신고일
    lazy var movedInDateLabel = TextInputView()
    
    lazy var movedInDateButton:UIButton = {
        let button = UIButton()
        let iamge = UIImage(named: "btn_Calendar")
        button.setBackgroundImage(iamge, for: .normal)
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //  확정일자
    lazy var fixedDateLabel = TextInputView()
    
    lazy var fixedDateButton:UIButton = {
        let button = UIButton()
        let iamge = UIImage(named: "btn_Calendar")
        button.setBackgroundImage(iamge, for: .normal)
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var interventionLabel:UILabel = {
        let label = UILabel()
        label.text = "집주인의 채권 개입 여부"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var interventionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0 // 상하간격
        layout.minimumInteritemSpacing = 0 // 좌우간격
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
    
    lazy var dividenCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0 // 상하간격
        layout.minimumInteritemSpacing = 0 // 좌우간격
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
    //  보증금
    lazy var depositLabel = TextInputView()
    lazy var wonLabel:UILabel = {
        let label = UILabel()
        label.text = "원"
        label.font = UIFont.Clutch.subtitleRegular
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    lazy var uploadLabel:UILabel = {
        let label = UILabel()
        label.text = "계약서 파일 업로드"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
    lazy var submitButton:UIButton = {
        let button = UIButton()
        button.setTitle("제출", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .Clutch.subheadMedium
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 11
        button.backgroundColor = .Clutch.mainDarkGreen
        // Highlighted 상태일 때 배경색
        let iamge = image(withColor: .Clutch.mainGreen!)
        button.setBackgroundImage(iamge, for: .highlighted)
        
        return button
    }()

    //MARK: - define method
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
        setTextInputView()
        setCollectionview()
        self.view.backgroundColor = .Clutch.mainWhite
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        
        navigationItem.title = "사기 신고 접수"
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.Clutch.subheadBold
        ]
        
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

        [titleLabel, residentLabel, residentCollectionView, movedInDateLabel, movedInDateButton, fixedDateLabel, fixedDateButton, interventionLabel, interventionCollectionView, dividenLabel, dividenCollectionView, depositLabel, wonLabel, uploadLabel, imageCollectionView].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //스크롤 뷰관련 셋
    func setscrollview() {
        scrollview.delegate = self
    }
    
    func setTextInputView() {
        movedInDateLabel.textInputLabel.text = "전입신고일"
        fixedDateLabel.textInputLabel.text = "확정일자"
        depositLabel.textInputLabel.text = "보증금 액수"
    }
    
    func constraints() {
        let leading = 16
        let top = 44
        
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
        }
        //스크롤 뷰 오토레이아웃
        scrollview.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(submitButton.snp.top).offset(-20)
        }
        //contentView 오토레이아웃
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(1040)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalToSuperview().offset(top)
        }
        
        residentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(top)
        }
        
        residentCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(residentLabel.snp.bottom).offset(3.5)
            make.height.equalTo(88)
        }
        
        movedInDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(residentCollectionView.snp.bottom).offset(top)
        }
        
        movedInDateButton.snp.makeConstraints { make in
            make.trailing.equalTo(movedInDateLabel.snp.trailing)
            make.bottom.equalTo(movedInDateLabel.underLine.snp.bottom).offset(-5)
            make.size.equalTo(20)
        }
        
        fixedDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(movedInDateLabel.underLine.snp.bottom).offset(top)
        }
        
        fixedDateButton.snp.makeConstraints { make in
            make.trailing.equalTo(fixedDateLabel.snp.trailing)
            make.bottom.equalTo(fixedDateLabel.underLine.snp.bottom).offset(-5)
            make.size.equalTo(20)
        }
        
        interventionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(fixedDateLabel.underLine.snp.bottom).offset(top)
        }
        
        interventionCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(interventionLabel.snp.bottom).offset(3.5)
            make.height.equalTo(88)
        }
        
        dividenLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(interventionCollectionView.snp.bottom).offset(top)
        }
        
        dividenCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(dividenLabel.snp.bottom).offset(3.5)
            make.height.equalTo(88)
        }
        
        depositLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(dividenCollectionView.snp.bottom).offset(top)
        }
        
        wonLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-leading)
            make.centerY.equalTo(depositLabel.textInputTextField)
        }
        
        uploadLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(depositLabel.underLine.snp.bottom).offset(top)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(uploadLabel.snp.bottom).offset(4)
            make.height.equalTo(100)
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        
    }
}

//MARK: - extension
extension ContractInfoViewController: DatePickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageDelegate, CustomAlertDelegate {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // 버튼 클릭 시 신고 API 호출
    @objc func submitButtonTapped(_ sender: UIButton) {
        
        // 호출 후
        lazy var response = 200
        if response == 200 {
            completed = true
        }
        
        if completed {
            showCustomAlert(alertType: .canCancel,
                            alertTitle: "신고하기",
                            alertContext: "정말로 신고하시겠습니까?",
                            cancelText: "취소",
                            confirmText: "신고")
        }
    }
    
    // 날짜 선택
    @objc func dateButtonTapped(_ sender: UIButton) {
        if sender == movedInDateButton {
            showDatePicker(title: "전입신고일을\n선택해주세요")
        }
        else if sender == fixedDateButton {
            showDatePicker(title: "확정일자를\n선택해주세요")
        }
    }
    
    func didSelectDate(title:String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let formattedDate = dateFormatter.string(from: date)
        if title == "전입신고일을\n선택해주세요" {
            movedInDateLabel.textInputTextField.text = formattedDate
        }
        else if title == "확정일자를\n선택해주세요" {
            fixedDateLabel.textInputTextField.text = formattedDate
        }
    }
    
    // collectionview 관련 설정
    func setCollectionview() {
        [residentCollectionView, interventionCollectionView, dividenCollectionView, imageCollectionView].forEach { collectionview in
            collectionview.dataSource = self
            collectionview.delegate = self
        }
        
        residentCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "residentCell")
        interventionCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "interventionCell")
        dividenCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "dividenCell")
        
        imageCollectionView.register(ButtonCell.self, forCellWithReuseIdentifier: "buttonCell")
        imageCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: "imageCell")
    }
    
    // section 수 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == imageCollectionView { return 2}
        else { return 1}
    }
    
    // section 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == imageCollectionView {
            let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            return sectionInsets
        }
        else {
            let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return sectionInsets
            
        }
    }
    
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
            if section == 0 { return 1 }
            else { return images.count }
        }
        else { return 2 }
    }
    
    // cell에 들어갈 data 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.residentCollectionView {
            guard let cell1 = residentCollectionView.dequeueReusableCell(withReuseIdentifier: "residentCell", for: indexPath) as? CheckCell else {
                return UICollectionViewCell()
            }
            
            cell1.textLabel.text = residentText[indexPath.row]
            return cell1
            
        } else if collectionView == self.interventionCollectionView {
            guard let cell2 = interventionCollectionView.dequeueReusableCell(withReuseIdentifier: "interventionCell", for: indexPath) as? CheckCell else {
                return UICollectionViewCell()
            }
            
            cell2.textLabel.text = interventionText[indexPath.row]
            return cell2
            
        } else if collectionView == self.dividenCollectionView {
            guard let cell3 = dividenCollectionView.dequeueReusableCell(withReuseIdentifier: "dividenCell", for: indexPath) as? CheckCell else {
                return UICollectionViewCell()
            }
            
            cell3.textLabel.text = dividenText[indexPath.row]
            return cell3
            
        } else if collectionView == self.imageCollectionView {
            if indexPath.section == 0 {
                guard let cell4 = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as? ButtonCell else { return UICollectionViewCell()
                }
                return cell4
            }
            else {
                guard let cell5 = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else { return UICollectionViewCell()
                }
                // 이미지 처리
//                cell5.imageView.image = UIImage(named: "btn_login_kakao")
                cell5.imageView.image = images[indexPath.row]
                cell5.delegate = self
                
                return cell5
            }
        }
        return UICollectionViewCell()
        
    }
    
    // cell 크기 및 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCollectionView {
            return CGSize(width: 100, height: 98)
        }
        else {
            let width: CGFloat = collectionView.frame.width
            let height = collectionView.frame.height / 2
            return CGSize(width: width, height: height)
        }
    }
    
    
    // cell 선택시 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imageCollectionView && indexPath.section == 0 {
            // 이미지 추가
            if images.count >= 10 {
                let alert = UIAlertController(
                    title: "이미지는 최대 10개까지 등록할 수 있습니다.",
                    message: nil,
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
                return
            }
            
            var config = YPImagePickerConfiguration()
            config.library.maxNumberOfItems = 10 - images.count
            config.library.mediaType = .photo
            config.showsPhotoFilters = false
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                
                if cancelled {
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                
                // 여러 이미지를 넣어주기 위해 하나씩 넣어주는 반복문
                for item in items {
                    switch item {
                    // 이미지만 받기때문에 photo case만 처리
                    case .photo(let p):
                        // 이미지를 해당하는 이미지 배열에 넣어주는 code
                        self.images.append(p.image)
                        
                    default:
                        print("")
                        
                    }
                    
                }
                picker.dismiss(animated: true) {
                    self.imageCollectionView.reloadData()
                }
            }
                
                // picker뷰 present
            present(picker, animated: true, completion: .none)
            return
        }
        else {
            // 나머지 버튼 모두 선택해제
            for i in 0..<2 {
                let index = IndexPath(item: i, section: 0)
                if let cell = collectionView.cellForItem(at: index) as? CheckCell {
                    cell.checkImageView.image = UIImage(named: "btn_deselected")
                }
            }
            
            // 선택된 정보 저장
    //        selectedCell = popupList[indexPath.row]
            if let cell = collectionView.cellForItem(at: indexPath) as? CheckCell {
                cell.checkImageView.image = UIImage(named: "btn_selected")
            }
        }
    }
    
    func deleteImage(cell: UICollectionViewCell) {
        // 해당 index 이미지 삭제
        guard let i = imageCollectionView.indexPath(for: cell)?.row else { return }
        
        // "이미지 삭제할까요?" 알림 띄울지? 커스텀 알림은 예외처리 좀 들어가야 함.
        images.remove(at: i)
        imageCollectionView.reloadData()
    }
    
    func cancel() {
        print("custom cancel Button Tapped")
    }
    
    func confirm() {
        print("custom action Button Tapped")
        // 신고하기 API 호출
        let response = "200"
        // 정상적으로 호출되면 메시지 출력, 창 닫기
        if response == "200" {
            showCustomAlert(alertType: .done,
                            alertTitle: "신고 완료",
                            alertContext: "정상적으로 신고되었습니다.",
                            confirmText: "확인")
            // 창 닫는 코드
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
        if completed {
            let VC = ReportDoneViewController()
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}
