//
//  datePickerViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/24.
//

import UIKit
import SnapKit

protocol DatePickerDelegate: AnyObject {
    func didSelectDate(title: String, date: Date)
}

class datePickerViewController: UIViewController {
    
    weak var delegate: DatePickerDelegate?
    
    lazy var titleText = "날짜를 선택해 주세요"
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = titleText
        label.numberOfLines = 2
        label.font = .Clutch.headtitlebold
        label.textColor = .Clutch.textBlack
        
        return label
    }()
    
    lazy var datePicker:UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.preferredDatePickerStyle = .inline
        datepicker.backgroundColor = .white
        datepicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datepicker.tintColor = UIColor.Clutch.mainGreen
        
        return datepicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(datePicker)
        Constraints()
    }
    
    func Constraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(datePicker.snp.top).offset(-30)
        }
        
        datePicker.snp.makeConstraints { make in
            make.width.equalTo(self.view.frame.width - 60)
            make.height.equalTo(self.view.frame.width - 30)
            make.center.equalToSuperview()
        }
    }
    
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        
        let selectedDate = datePicker.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        print("Selected Date: \(formattedDate)")
        delegate?.didSelectDate(title: titleText, date: selectedDate)
        dismiss(animated: true)
        
    }
    
    
}

// datePicker를 간결하게 재사용하기 위한 메소드 구현
extension DatePickerDelegate where Self: UIViewController {
    func showDatePicker(
        title: String
    ) {
        lazy var VC = datePickerViewController()
        VC.delegate = self
        
        VC.modalPresentationStyle = .overCurrentContext
        VC.modalTransitionStyle = .crossDissolve
        VC.titleText = title
        self.present(VC, animated: true, completion: nil)
    }
}
