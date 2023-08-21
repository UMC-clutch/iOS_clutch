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
