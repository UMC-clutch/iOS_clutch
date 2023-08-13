//
//  Ext + URL.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/08/13.
//

import Foundation

extension URL {
    static let baseURL = "https://www.clutch.p-e.kr"
    
    static func makeEndPointString(_ endpoint:String) -> String {
        return baseURL + endpoint
    }
}
