//
//  datePickerViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/24.
//

import UIKit
import SnapKit

class datePickerViewController: UIViewController {
    
    weak var delegate: DatePickerDelegate?
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "근저당 설정일을\n선택해주세요"
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
        delegate?.didSelectDate(selectedDate)
        dismiss(animated: true)
        
    }
    
    
}
