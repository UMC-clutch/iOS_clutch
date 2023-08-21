//
//  Get.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/08/15.
//

import Foundation

// MARK: - GetCaculate
struct GetCaculate: Codable {
    let id, buildingId, addressId: Int
    let buildingName, address, dong, ho: String
    let price, collateralMoney, deposit: Int
    let isDangerous: Bool
}

struct GetUser: Codable {
    let phonenumber: String
    let id: Int
    let name, email: String
}

// MARK: - GetReportInfo
struct GetReport: Codable {
    let reportStatus, reportedAt: String
    let reportId: Int
    let buildingName, collateralDate, address, dong: String
    let ho, buildingType: String
    let has_landlord_intervene, has_applied_dividend: Bool
    let deposit: Int
    let has_lived: Bool
    let transport_report_date, confirmation_date: String
}
