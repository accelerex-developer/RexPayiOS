//
//  NetworkServiceConstant.swift
//  RexpaySDK
//
//  Created by Abdullah on 27/01/2024.
//

import Foundation

class NetworkServiceConstant {
    
    static var baseUrl = "https://pgs-sandbox.globalaccelerex.com/api"
}

class NetworkServiceConfig {
    
    var rexpayEnv: RexpayEnv
    
    var pgsBaseURL: String {
        switch rexpayEnv {
        case .sandbox:
            return "https://pgs-sandbox.globalaccelerex.com/api"
        case .production:
            return "https://pgs.globalaccelerex.com/api"
        }
    }
    var cpsBaseURL: String {
        switch rexpayEnv {
        case .sandbox:
            return "https://pgs-sandbox.globalaccelerex.com/api"
        case .production:
            return "https://cps.globalaccelerex.com/api"
        }
    }
    
    init(rexpayEnv: RexpayEnv) {
        self.rexpayEnv = rexpayEnv
    }
    //static var baseUrl = "https://pgs-sandbox.globalaccelerex.com/api"
}
