//
//  BankRepository.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

protocol BankRepositoryDelegate {
    func getBankTransferDetails(bankTransferPayload: BankTransferPayload) async throws -> Result<BankTransferResponse?, ErrorReponse>
}

final class BankRepository: BankRepositoryDelegate {
    
    private let networkService: NetowkServiceDelegate
    private let networkServiceConfig: NetworkServiceConfig
    
    init(networkService: NetowkServiceDelegate, networkServiceConfig: NetworkServiceConfig) {
        self.networkService = networkService
        self.networkServiceConfig = networkServiceConfig
    }
    
    func getBankTransferDetails(bankTransferPayload: BankTransferPayload) async throws -> Result<BankTransferResponse?, ErrorReponse> {
        do {
            let bodyPayload: [String: Any] = [
                "customerName": bankTransferPayload.customerName,
                "reference": bankTransferPayload.reference,
                "amount": bankTransferPayload.amount,
                "customerId": bankTransferPayload.customerId
            ]
            
            print("getBankTransferDetails payload is \(bodyPayload)")
            let response = try await networkService.execute(urlString: "\(networkServiceConfig.cpsBaseURL)/cps/v1/initiateBankTransfer", method: "POST", type: BankTransferResponse.self, bodyPayload: bodyPayload)
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
}
