//
//  CardRepository.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

protocol CardRepositoryDelegate: BaseRepositoryDelegate {

    func chargeCard(encryptedRequest: String) async throws -> Result<EncryptedResponse?, ErrorReponse>
    
    
    func authorizeTransaction(encryptedRequest: String) async throws -> Result<EncryptedResponse?, ErrorReponse>
    
}

class CardRepository: CardRepositoryDelegate {

    private let networkService: NetowkServiceDelegate
    private let networkServiceConfig: NetworkServiceConfig
    
    init(networkService: NetowkServiceDelegate, networkServiceConfig: NetworkServiceConfig) {
        self.networkService = networkService
        self.networkServiceConfig = networkServiceConfig
    }
    
    func chargeCard(encryptedRequest: String) async throws -> Result<EncryptedResponse?, ErrorReponse> {
        do {
            let bodyPayload: [String: Any] = [
                "encryptedRequest": encryptedRequest
            ]
            
            print("chargeCard is \(bodyPayload)")
            let response = try await networkService.execute(urlString: "\(networkServiceConfig.cpsBaseURL)/cps/v1/chargeCard", method: "POST", type: EncryptedResponse.self, bodyPayload: bodyPayload)
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
    
    func authorizeTransaction(encryptedRequest: String) async throws -> Result<EncryptedResponse?, ErrorReponse> {
        do {
            
            let bodyPayload: [String: Any] = [
                "encryptedRequest": encryptedRequest
            ]
            
            print("authorizeTransaction payload is \(bodyPayload)")
            let response = try await networkService.execute(urlString: "\(networkServiceConfig.cpsBaseURL)/cps/v1/authorizeTransaction", method: "POST", type: EncryptedResponse.self, bodyPayload: bodyPayload)
            switch response {
            case .success(let encryptedResponse):
                return .success(encryptedResponse)
            case .failure(let errorResponse):
                return .failure(errorResponse)
            }
        }
        catch {
            //throw error
            return .failure(ErrorReponse(message: error.localizedDescription))
        }
    }
}
