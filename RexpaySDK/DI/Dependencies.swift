//
//  Dependencies.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation


protocol DependenciesDelegate {
    var config: RexpaySDKConfig {get set}
    func makeBankRepository() -> BankRepositoryDelegate
}

final class Dependencies: DependenciesDelegate {
    var config: RexpaySDKConfig
    
    
    //let config: RexpaySDKConfig
    
    init(config: RexpaySDKConfig) {
        self.config = config
    }
    
    func makeBankRepository() -> BankRepositoryDelegate {
        BankRepository()
    }
}
