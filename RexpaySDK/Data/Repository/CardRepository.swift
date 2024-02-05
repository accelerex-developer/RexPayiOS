//
//  CardRepository.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

protocol CardRepositoryDelegate: BaseRepositoryDelegate {

    func chargeCard(encryptedRequest: String) async throws -> Result<ChargeCardResponse?, ErrorReponse>
    func authorizeCard()
}

class CardRepository: CardRepositoryDelegate {

    private let networkService: NetowkServiceDelegate
    
    init(networkService: NetowkServiceDelegate) {
        self.networkService = networkService
    }
    
    func chargeCard(encryptedRequest: String) async throws -> Result<ChargeCardResponse?, ErrorReponse> {
        do {
            let bodyPayload: [String: Any] = [
                "encryptedRequest": encryptedRequest
            ]
            
            print("chargeCard is \(bodyPayload)")
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
