//
//  CardRepository.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation

protocol CardRepositoryDelegate: BaseRepositoryDelegate {

    func chargeCard(encryptedRequest: String) async throws -> Result<ChargeCardResponse?, ErrorReponseTwo>
    func authorizeCard()
}

class CardRepository: CardRepositoryDelegate {

    private let networkService: NetowkServiceDelegate
    
    init(networkService: NetowkServiceDelegate) {
        self.networkService = networkService
    }
    
    func chargeCard(encryptedRequest: String) async throws -> Result<ChargeCardResponse?, ErrorReponseTwo> {
        do {
            let bodyPayload: [String: Any] = [
                "encryptedRequest": encryptedRequest
            ]
            
            print("chargeCard is \(bodyPayload)")
            let response = try await networkService.executeCall(urlString: "\(NetworkServiceConstant.baseUrl)/cps/v1/chargeCard", method: "POST", type: ChargeCardResponse.self, bodyPayload: bodyPayload)
            switch response {
                
            case .success(let charegeCardResponse):
                return .success(charegeCardResponse)
            case .failure(let errorResponse):
                return .failure(errorResponse)
            }
        }
        catch {
            //throw error
            return .failure(ErrorReponseTwo(responseMessage: error.localizedDescription))
        }
    }
    
    func authorizeCard() {
        
    }
}
