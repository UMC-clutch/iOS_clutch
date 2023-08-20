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
