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
    let logicType, type, area: String

}

// MARK: - PostCalculate
struct PostCalculate: Codable {
    let id, buildingId, collateral, deposit: Int
    let isDangerous: Bool

}

// MARK: - BuildingPrice
struct PostBuildingInfo: Codable {
    let buildingName, address, dong, ho: String
    let collateralDate: String
    let type, area: String

}

// MARK: - BuildingPrice
struct PostContractInfo: Codable {
    let buildingId: Int
    let hasLived, hasLandlordIntervene, hasAppliedDividend: Bool
    let transportReportDate, confirmationDate: String
    let deposit: Int

}
