//
//  Bank.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import Foundation

struct Bank: Codable {
    var name: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case code = "Code"
    }
}
