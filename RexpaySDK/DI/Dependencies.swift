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
    func makeNetworkServiceConfig() -> NetworkServiceConfig
    func makeObjectivePGPHelper() -> ObjectivePGPHelper
}

final class Dependencies: DependenciesDelegate {
    var config: RexpaySDKConfig
    
    
    //let config: RexpaySDKConfig
    
    init(config: RexpaySDKConfig) {
        self.config = config
    }
    
    func makeNetworkServiceConfig() -> NetworkServiceConfig {
        NetworkServiceConfig(rexpayEnv: config.rexpayEnv)
    }
    
    func makeBankRepository() -> BankRepositoryDelegate {
        BankRepository(networkService: makeNetowkService(), networkServiceConfig: makeNetworkServiceConfig())
    }
    
    func makeCardRepository() -> CardRepositoryDelegate {
        CardRepository(networkService: makeNetowkService(),networkServiceConfig: makeNetworkServiceConfig())
    }
    
    func makeSharedRepository() -> SharedRepositoryDelegate {
        SharedRepository(networkService: makeNetowkService(), networkServiceConfig: makeNetworkServiceConfig())
    }
    
    func makeUssdRepository() -> UssdRepositoryDelegate {
        UssdRepository(networkService: makeNetowkService(), networkServiceConfig: makeNetworkServiceConfig())
    }
    
    func makeObjectivePGPHelper() -> ObjectivePGPHelper {
        ObjectivePGPHelper.shared
    }
    
    func makeNetowkService() -> NetowkServiceDelegate {
        let networkService = NetowkService(urlSession: URLSession.shared, rexpayConfig: config)
        return networkService
    }
}
