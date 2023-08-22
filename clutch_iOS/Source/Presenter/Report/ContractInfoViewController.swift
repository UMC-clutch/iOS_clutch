//
//  ContractInfoViewController.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/07/26.
//

import Foundation
import UIKit
import YPImagePicker
import Alamofire

class ContractInfoViewController: UIViewController, UIScrollViewDelegate {
    //MARK: - Properties
    lazy var completed = false
    lazy var buildingID: Int = -1
    
    lazy var livedText = ["거주하고 있어요", "거주하고 있지 않아요"]
    lazy var hasLived = false
    lazy var interveneText = ["개입했어요", "개입하지 않았어요"]
    lazy var hasIntervene = false
    lazy var dividendText = ["신청했어요", "신청하지 않았어요"]
    lazy var hasDividend = false

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
    
    lazy var livedLabel:UILabel = {
        let label = UILabel()
        label.text = "실거주 여부"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var livedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0 // 상하간격
        layout.minimumInteritemSpacing = 0 // 좌우간격
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
    //전입신고일
    lazy var transportReportDateLabel = TextInputView()
    
    lazy var transportReportDateButton:UIButton = {
        let button = UIButton()
        let iamge = UIImage(named: "btn_Calendar")
        button.setBackgroundImage(iamge, for: .normal)
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //  확정일자
    lazy var confirmationDateLabel = TextInputView()
    
    lazy var confirmationDateButton:UIButton = {
        let button = UIButton()
        let iamge = UIImage(named: "btn_Calendar")
        button.setBackgroundImage(iamge, for: .normal)
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var interveneLabel:UILabel = {
        let label = UILabel()
        label.text = "집주인의 채권 개입 여부"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var interveneCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0 // 상하간격
        layout.minimumInteritemSpacing = 0 // 좌우간격
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .Clutch.mainWhite
        
        return view
    }()
    
    lazy var dividendLabel:UILabel = {
        let label = UILabel()
        label.text = "배당신청 여부"
        label.font = .Clutch.smallMedium
        label.textColor = .Clutch.textDarkGrey
        
        return label
    }()
    
    lazy var dividendCollectionView: UICollectionView = {
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
        button.backgroundColor = .Clutch.bgGrey
        // Highlighted 상태일 때 배경색
        let iamge = image(withColor: .Clutch.mainGreen!)
        button.setBackgroundImage(iamge, for: .highlighted)
        button.isEnabled = false
        
        return button
    }()

    //MARK: - define method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        constraints()
        print(buildingID)
    }
    
    //뷰관련 셋
    func setView() {
        setNavigationBar()
        addsubview()
        setscrollview()
        setTextInputView()
        setCollectionview()
        self.view.backgroundColor = .Clutch.mainWhite
        textChange()
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

        [titleLabel, livedLabel, livedCollectionView, transportReportDateLabel, transportReportDateButton, confirmationDateLabel, confirmationDateButton, interveneLabel, interveneCollectionView, dividendLabel, dividendCollectionView, depositLabel, wonLabel, uploadLabel, imageCollectionView].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //스크롤 뷰관련 셋
    func setscrollview() {
        scrollview.delegate = self
    }
    
    func setTextInputView() {
        transportReportDateLabel.textInputLabel.text = "전입신고일"
        transportReportDateLabel.textInputTextField.isUserInteractionEnabled = false
        confirmationDateLabel.textInputLabel.text = "확정일자"
        confirmationDateLabel.textInputTextField.isUserInteractionEnabled = false
        depositLabel.textInputLabel.text = "보증금 액수"
    }
    
    func textChange() {
        transportReportDateLabel.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        confirmationDateLabel.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        depositLabel.textInputTextField.addTarget(self, action: #selector(textCheck), for: .editingChanged)
        
    }
    
    @objc func textCheck() {
        let allFieldsFilled =
        transportReportDateLabel.textInputTextField.text?.isEmpty == false &&
        confirmationDateLabel.textInputTextField.text?.isEmpty == false &&
        depositLabel.textInputTextField.text?.isEmpty == false

        let indexPaths = livedCollectionView.indexPathsForSelectedItems
        let isCellSelected = indexPaths != nil && !indexPaths!.isEmpty
        
        let indexPaths2 = dividendCollectionView.indexPathsForSelectedItems
        let isCellSelected2 = indexPaths2 != nil && !indexPaths!.isEmpty
        
        let indexPaths3 = interveneCollectionView.indexPathsForSelectedItems
        let isCellSelected3 = indexPaths3 != nil && !indexPaths!.isEmpty
        
        let check = isCellSelected && isCellSelected2 && isCellSelected3
        
        if check && allFieldsFilled {
            submitButton.backgroundColor = .Clutch.mainDarkGreen
            submitButton.setTitleColor(.Clutch.mainWhite, for: .normal)
            submitButton.isEnabled = true
        } else {
            submitButton.backgroundColor = .Clutch.bgGrey
            submitButton.isEnabled = false
        }
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
        
        livedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(top)
        }
        
        livedCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(livedLabel.snp.bottom).offset(3.5)
            make.height.equalTo(88)
        }
        
        transportReportDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(livedCollectionView.snp.bottom).offset(top)
        }
        
        transportReportDateButton.snp.makeConstraints { make in
            make.trailing.equalTo(transportReportDateLabel.snp.trailing)
            make.bottom.equalTo(transportReportDateLabel.underLine.snp.bottom).offset(-5)
            make.size.equalTo(20)
        }
        
        confirmationDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(transportReportDateLabel.underLine.snp.bottom).offset(top)
        }
        
        confirmationDateButton.snp.makeConstraints { make in
            make.trailing.equalTo(confirmationDateLabel.snp.trailing)
            make.bottom.equalTo(confirmationDateLabel.underLine.snp.bottom).offset(-5)
            make.size.equalTo(20)
        }
        
        interveneLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(confirmationDateLabel.underLine.snp.bottom).offset(top)
        }
        
        interveneCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(interveneLabel.snp.bottom).offset(3.5)
            make.height.equalTo(88)
        }
        
        dividendLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(interveneCollectionView.snp.bottom).offset(top)
        }
        
        dividendCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(dividendLabel.snp.bottom).offset(3.5)
            make.height.equalTo(88)
        }
        
        depositLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(dividendCollectionView.snp.bottom).offset(top)
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
        showCustomAlert(alertType: .canCancel,
                        alertTitle: "신고하기",
                        alertContext: "정말로 신고하시겠습니까?",
                        cancelText: "취소",
                        confirmText: "신고")
    }
    
    // 날짜 선택
    @objc func dateButtonTapped(_ sender: UIButton) {
        if sender == transportReportDateButton {
            showDatePicker(title: "전입신고일을\n선택해주세요")
        }
        else if sender == confirmationDateButton {
            showDatePicker(title: "확정일자를\n선택해주세요")
        }
    }
    
    func didSelectDate(title:String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let formattedDate = dateFormatter.string(from: date)
        if title == "전입신고일을\n선택해주세요" {
            transportReportDateLabel.textInputTextField.text = formattedDate
        }
        else if title == "확정일자를\n선택해주세요" {
            confirmationDateLabel.textInputTextField.text = formattedDate
        }
    }
    
    // collectionview 관련 설정
    func setCollectionview() {
        [livedCollectionView, interveneCollectionView, dividendCollectionView, imageCollectionView].forEach { collectionview in
            collectionview.dataSource = self
            collectionview.delegate = self
        }
        
        livedCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "residentCell")
        interveneCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "interventionCell")
        dividendCollectionView.register(CheckCell.self, forCellWithReuseIdentifier: "dividenCell")
        
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
        
        if collectionView == self.livedCollectionView {
            guard let cell1 = livedCollectionView.dequeueReusableCell(withReuseIdentifier: "residentCell", for: indexPath) as? CheckCell else {
                return UICollectionViewCell()
            }
            
            cell1.textLabel.text = livedText[indexPath.row]
            return cell1
            
        } else if collectionView == self.interveneCollectionView {
            guard let cell2 = interveneCollectionView.dequeueReusableCell(withReuseIdentifier: "interventionCell", for: indexPath) as? CheckCell else {
                return UICollectionViewCell()
            }
            
            cell2.textLabel.text = interveneText[indexPath.row]
            return cell2
            
        } else if collectionView == self.dividendCollectionView {
            guard let cell3 = dividendCollectionView.dequeueReusableCell(withReuseIdentifier: "dividenCell", for: indexPath) as? CheckCell else {
                return UICollectionViewCell()
            }
            
            cell3.textLabel.text = dividendText[indexPath.row]
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
        // 이미지 collectionView
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
        
        // 선택 collectionView
        
        // 선택 셀 활성화
        if let cell = collectionView.cellForItem(at: indexPath) as? CheckCell {
            cell.checkImageView.image = UIImage(named: "btn_selected")
        }
        // 미선택 셀 비활성화
        let index = IndexPath(item: (indexPath.row + 1) % 2, section: 0)
        if let cell = collectionView.cellForItem(at: index) as? CheckCell {
            cell.checkImageView.image = UIImage(named: "btn_deselected")
        }
        
        // bool 값 지정
        var checked = false
        switch indexPath.row {
        case 0:
            checked = true
        case 1:
            checked = false
        default:
            return
        }
        
        switch collectionView {
        case self.livedCollectionView:
            hasLived = checked
        case self.interveneCollectionView:
            hasIntervene = checked
        case self.dividendCollectionView:
            hasDividend = checked
        default:
            return
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
        print("confirm")
        requestReportContract()
    }
    
    func done() {
        if completed {
            let VC = ReportDoneViewController()
            navigationController?.pushViewController(VC, animated: true)
        }
    }

    //MARK: - Network
    func requestReportContract() {
        
        // 신고하기 API 호출
        let formData = MultipartFormData()
        
        let parameter: [String:Any] = [
            "hasLived": hasLived,
            "transportReportDate": dateForDB(inDateStr: transportReportDateLabel.textInputTextField.text ?? ""),
            "confirmationDate": dateForDB(inDateStr: confirmationDateLabel.textInputTextField.text ?? ""),
            "hasLandlordIntervene": hasIntervene,
            "hasAppliedDividend": hasDividend,
            "deposit": Int(depositLabel.textInputTextField.text ?? "0") ?? 0
        ]
        print(parameter)
        
        // JSON 데이터를 Data로 변환
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameter, options: []) {
            formData.append(jsonData, withName: "requestDto", mimeType: "application/json")
        }
        
        for image in images {
            let imageData = image.jpegData(compressionQuality: 0.8)!
//            let imageData = image.pngData()
            formData.append(imageData, withName: "files", fileName: "image\(images.firstIndex(of: image)!+1).jpg", mimeType: "image/jpeg")
        }
        
        APIManger.shared.callFormRequest(baseEndPoint: .contract, addPath: "/\(buildingID)", formData: formData) { JSON in
            // 호출 오류시 처리
            if JSON["check"].boolValue == false {
                print(JSON["information"]["message"].stringValue)
                print(JSON["error"].stringValue)
                print(JSON["path"].stringValue)
                self.showCustomAlert(alertType: .done,
                                     alertTitle: "오류 발생",
                                     alertContext: "다시 시도해주세요.",
                                     confirmText: "확인")
                return
            }
            
            // 응답 처리
            
            self.completed = true
            self.showCustomAlert(alertType: .done,
                                 alertTitle: "신고 완료",
                                 alertContext: "정상적으로 신고되었습니다.",
                                 confirmText: "확인")
        }
    }
}
