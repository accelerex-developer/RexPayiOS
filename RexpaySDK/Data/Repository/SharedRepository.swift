//
//  PayementRepository.swift
//  RexpaySDK
//
//  Created by Abdullah on 27/01/2024.
//

protocol SharedRepositoryDelegate: AnyObject {
    
    func createPayment(config: RexpaySDKConfig) async throws -> Result<CreatePaymentResponse?, ErrorReponse>
    
    func insertPublicKey(clientId: String, publicKey: String) async throws -> Result<ResponseWithNoBody?, ErrorReponse>
    
    func getTransactionStatus(transactionReference: String) async throws -> Result<TransactionStatusResponse?, ErrorReponse>
}

class SharedRepository: SharedRepositoryDelegate {

    private let networkService: NetowkServiceDelegate
    private let networkServiceConfig: NetworkServiceConfig
    
    init(networkService: NetowkServiceDelegate, networkServiceConfig: NetworkServiceConfig) {
        self.networkService = networkService
        self.networkServiceConfig = networkServiceConfig
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
            "userId": config.userId,
            "callbackUrl": config.callbackUrl ?? ""
        ]
        print("create payment bodyPayload is \(bodyPayload)")
        do {
            let response = try await networkService.execute(urlString: "\(networkServiceConfig.pgsBaseURL)/pgs/payment/v2/createPayment", method: "POST", type: CreatePaymentResponse.self, bodyPayload: bodyPayload)
            
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
    
    func insertPublicKey(clientId: String, publicKey: String) async throws -> Result<ResponseWithNoBody?, ErrorReponse> {
       
        let bodyPayload: [String: Any] = [
            "clientId": clientId,
            "publicKey": publicKey
        ]
        print("insertPublicKey bodyPayload is \(bodyPayload)")
        do {
            let response = try await networkService.execute(urlString: "\(NetworkServiceConstant.baseUrl)/pgs/clients/v1/publicKey", method: "POST", bodyPayload: bodyPayload)
            
            switch response {
                
            case .success(let responseWithNoBody):
                return .success(responseWithNoBody)
            case .failure(let errorResponse):
                return .failure(errorResponse)
            }
        }
        catch {
            //throw error
            return .failure(ErrorReponse(message: error.localizedDescription))
        }
    }
    
    func getTransactionStatus(transactionReference: String) async throws -> Result<TransactionStatusResponse?, ErrorReponse> {
        

        let bodyPayload: [String: Any] = [
            "transactionReference": transactionReference,
        ]
        print("getTransactionStatus  bodyPayload is \(bodyPayload)")
        do {
            let response = try await networkService.execute(urlString: "\(NetworkServiceConstant.baseUrl)/cps/v1/getTransactionStatus", method: "POST", type: TransactionStatusResponse.self, bodyPayload: bodyPayload)
            
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
