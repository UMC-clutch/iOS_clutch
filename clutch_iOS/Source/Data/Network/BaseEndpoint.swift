//
//  Endpoint.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/08/13.
//

import Foundation

enum BaseEndpoint {
    
    case auth
    case building
    case calculate
    case contract
    case report
    case user

    var requestURL:String {
        switch self {
        case.auth: return URL.makeEndPointString("/api/auth/token/kakao")
        case.building: return URL.makeEndPointString("/api/v1/buildingPrice")
        case.calculate: return URL.makeEndPointString("/api/v1/calculate")
        case.contract: return URL.makeEndPointString("/api/v1/contract")
        case.report: return URL.makeEndPointString("/api/v1/report")
        case.user: return URL.makeEndPointString("/api/v1")
            
        }
    }
}

