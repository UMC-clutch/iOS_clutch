//
//  BuildingPrice.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/08/15.
//

import Foundation

// MARK: - BuildingPrice
struct PostBuildingPrice: Codable {
    let buildingId, price: Int
    let buildingName, address, dong, ho: String
    let type, area: String

}

// MARK: - PostCalculate
struct PostCalculate: Codable {
    let id, buildingId, collateral, deposit: Int
    let isDangerous: Bool

}

// MARK: - PostReport
struct PostReport: Codable {
    let reportStatus, reportedAt: String
    let reportId: Int
    let buildingName, collateralDate, address, dong: String
    let ho, buildingType: String
    let has_landlord_intervene, has_applied_dividend: Bool
    let deposit: Int
    let has_lived: Bool
    let transport_report_date, confirmation_date: String
}
