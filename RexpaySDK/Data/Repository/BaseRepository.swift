//
//  BaseRepository.swift
//  RexpaySDK
//
//  Created by Abdullah on 24/01/2024.
//


protocol BaseRepositoryDelegate: AnyObject {}

extension BaseRepositoryDelegate {
    func createPayment(config: RexpaySDKConfig,
                       networkService: NetowkServiceDelegate) async throws -> Result<CreatePaymentResponse?, ErrorReponse> {
        
        let metadata: [String: Any?] = [
            "email": config.email,
            "customerName": config.customerName
        ]
        let bodyPayload: [String: Any?] = [
            "reference": config.reference,
            "amount": config.amount,
            "currency": config.currency,
            "metadata": metadata
        ]
        
        do {
            let response = try await networkService.execute(urlString: "", method: "", type: CreatePaymentResponse.self, bodyPayload: bodyPayload)
            switch response {
                
            case .success(let createPaymentResponse):
                return .success(createPaymentResponse)
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


