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
    func makeCardRepository() -> CardRepositoryDelegate
    func makeSharedRepository() -> SharedRepositoryDelegate
    func makeNetowkService() -> NetowkServiceDelegate
    func makeUssdRepository() -> UssdRepositoryDelegate
}

final class Dependencies: DependenciesDelegate {
    var config: RexpaySDKConfig
    
    
    //let config: RexpaySDKConfig
    
    init(config: RexpaySDKConfig) {
        self.config = config
    }
    
    func makeBankRepository() -> BankRepositoryDelegate {
        BankRepository(networkService: makeNetowkService())
    }
    
    func makeCardRepository() -> CardRepositoryDelegate {
        CardRepository(networkService: makeNetowkService())
    }
    
    func makeSharedRepository() -> SharedRepositoryDelegate {
        SharedRepository(networkService: makeNetowkService())
    }
    
    func makeUssdRepository() -> UssdRepositoryDelegate {
        UssdRepository(networkService: makeNetowkService())
    }
    
    func makeNetowkService() -> NetowkServiceDelegate {
        let networkService = NetowkService(urlSession: URLSession.shared)
        return networkService
    }
}
