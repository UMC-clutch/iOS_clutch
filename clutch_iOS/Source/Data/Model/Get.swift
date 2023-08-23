//
//  Get.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/08/15.
//

import Foundation

// MARK: - GetCaculate
struct GetUser: Codable {
    let phonenumber: String
    let id: Int
    let name, email: String
}


// MARK: - GetReportInfo
struct GetReport: Codable {
    let reportStatus, reportedAt: String
    let reportId: Int
    let buildingName, collateralDate, address: String
    let dong, ho, buildingType: String
    let hasLandlordIntervene, hasAppliedDividend: Bool
    let deposit: Int
    let hasLived: Bool
    let transportReportDate, confirmationDate: String
    
    struct GetCaculate: Codable {
        let id: Int
        let buildingId: Int
        let buildingName: String
        let address: String
        let dong: String
        let ho: String
        let price: Int
        let collateralMoney: Int
        let deposit: Int
        let isDangerous: Bool
        //    let createdAd:Date
        
        enum CodingKeys: String, CodingKey {
            case id
            case buildingId = "buildingId"
            case buildingName
            case address
            case dong
            case ho
            case price
            case collateralMoney
            case deposit
            case isDangerous
        }
    }
}
