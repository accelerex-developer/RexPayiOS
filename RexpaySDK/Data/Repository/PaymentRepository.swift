//
//  PayementRepository.swift
//  RexpaySDK
//
//  Created by Abdullah on 27/01/2024.
//

protocol PaymentRepositoryDelegate: AnyObject {
    func createPayment(config: RexpaySDKConfig) async throws -> Result<CreatePaymentResponse?, ErrorReponse>
}

class PaymentRepository: PaymentRepositoryDelegate {
    
    private let networkService: NetowkServiceDelegate
    
    init(networkService: NetowkServiceDelegate) {
        self.networkService = networkService
    }
    
    func createPayment(config: RexpaySDKConfig) async throws -> Result<CreatePaymentResponse?, ErrorReponse> {
        
        let metadata: [String: Any?] = [
            "email": config.email,
            "customerName": config.customerName
        ]
        let bodyPayload: [String: Any?] = [
            "reference": config.reference,
            "amount": config.amount,
            "currency": config.currency,
            "metadata": metadata,
            "callbackUrl": config.callbackUrl ?? ""
        ]
        print("create payment bodyPayload is \(bodyPayload)")
        do {
            let response = try await networkService.execute(urlString: "\(NetworkServiceConstant.baseUrl)/pgs/payment/v2/createPaymentt", method: "POST", type: CreatePaymentResponse.self, bodyPayload: bodyPayload)
            
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
