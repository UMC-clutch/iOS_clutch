//
//  ConvertDate.swift
//  clutch_iOS
//
//  Created by Jiwoong's MacBook Air on 2023/08/21.
//

import Foundation

func dateForView(inDateStr: String) -> String {
    let inDateFormatter = DateFormatter()
    inDateFormatter.dateFormat = "yyyy-MM-dd"
    if let inDate = inDateFormatter.date(from: inDateStr) {
        let outDateFormatter = DateFormatter()
        outDateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let outDate = outDateFormatter.string(from: inDate)
        
        return outDate
    }
    else {
        print("Fail to convert the Date")
        return inDateStr
    }
}

func dateForDB(inDateStr: String) -> String {
    let inDateFormatter = DateFormatter()
    inDateFormatter.dateFormat = "yyyy년 MM월 dd일"
    if let inDate = inDateFormatter.date(from: inDateStr) {
        let outDateFormatter = DateFormatter()
        outDateFormatter.dateFormat = "yyyy-MM-dd"
        let outDate = outDateFormatter.string(from: inDate)
        
        return outDate
    }
    else {
        print("Fail to convert the Date")
        return inDateStr
    }
}
