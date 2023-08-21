//
//  SingleItem.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/08/20.
//

import Foundation

class singleItem {
    static let shared = singleItem()
    private init() { }
    
    var username = ""
}
