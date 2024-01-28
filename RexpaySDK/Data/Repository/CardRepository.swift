//
//  CardRepository.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation

protocol CardRepositoryDelegate: BaseRepositoryDelegate {

    func chargeCard(urlString: String, config: RexpaySDKConfig, reference: String, params: [String: Any]) async throws -> Result<ChargeCardResponse?, ErrorReponse>
    func authorizeCard()
}

class CardRepository: CardRepositoryDelegate {

    private let networkService: NetowkServiceDelegate
    
    init(networkService: NetowkServiceDelegate) {
        self.networkService = networkService
    }
    
    func chargeCard(urlString: String, config: RexpaySDKConfig, reference: String, params: [String: Any]) async throws -> Result<ChargeCardResponse?, ErrorReponse> {
        do {
         
            let cardDetails: [String: Any?] = [
                "authDataVersion" : params["authDataVersion"],
                "pan" : params["pan"],
                "expiryDate" : params["expiryDate"],
                "cvv2" : params["cvv2"],
                "pin" : params["pin"]
            ]
            let bodyPayload: [String: Any?] = [
                "reference": reference,
                "amount": params["amount"],
                "customerId": config.email,
                "metadata": cardDetails
            ]
            // I need to encrypt the bodyPayload before calling the endpoint
            let response = try await networkService.execute(urlString: "\(NetworkServiceConstant.baseUrl)/cps/v1/chargeCard", method: "POST", type: ChargeCardResponse.self, bodyPayload: bodyPayload)
            switch response {
                
            case .success(let charegeCardResponse):
                return .success(charegeCardResponse)
            case .failure(let errorResponse):
                return .failure(errorResponse)
            }
        }
        catch {
            //throw error
            return .failure(ErrorReponse(message: error.localizedDescription))
        }
    }
    
    func authorizeCard() {
        
    }
}
