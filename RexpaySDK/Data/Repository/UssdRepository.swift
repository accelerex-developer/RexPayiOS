//
//  UssdRepository.swift
//  RexpaySDK
//
//  Created by Abdullah on 24/01/2024.
//

protocol UssdRepositoryDelegate {
    func chargeByUssd(chargeByUssdPayload: ChargeByUssdPayload) async throws -> Result<ChargeByUssdResponse?, ErrorReponse>
    
    func getUssdDetails(transRef: String) async throws -> Result<UssdDetailsResponse?, ErrorReponse>
}

final class UssdRepository: UssdRepositoryDelegate {
    
    private let networkService: NetowkServiceDelegate
    
    init(networkService: NetowkServiceDelegate) {
        self.networkService = networkService
    }
    
    func chargeByUssd(chargeByUssdPayload: ChargeByUssdPayload) async throws -> Result<ChargeByUssdResponse?, ErrorReponse> {
        let bodyPayload: [String: Any] = [
            "reference": "\(chargeByUssdPayload.reference)",
            "userId": chargeByUssdPayload.userId,
            "clientId": chargeByUssdPayload.clientId,
            "bankCode": chargeByUssdPayload.bankCode,
            "amount": chargeByUssdPayload.amount,
            "currency": chargeByUssdPayload.currency,
            "callbackUrl": chargeByUssdPayload.callbackUrl,
            "paymentChannel": chargeByUssdPayload.paymentChannel
        ]
        print("chargeByUssd  bodyPayload is \(bodyPayload)")
        do {
            let response = try await networkService.execute(urlString: "\(NetworkServiceConstant.baseUrl)/pgs/payment/v1/makePayment", method: "POST", type: ChargeByUssdResponse.self, bodyPayload: bodyPayload)
            
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
    
    func getUssdDetails(transRef: String) async throws -> Result<UssdDetailsResponse?, ErrorReponse> {
    
        do {
            let response = try await networkService.execute(urlString: "\(NetworkServiceConstant.baseUrl)/pgs/payment/v1/getPaymentDetails/\(transRef)", method: "GET", type: UssdDetailsResponse.self, bodyPayload: [:])
            
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
