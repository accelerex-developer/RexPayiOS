//
//  CardwwViewModel.swift
//  RexpaySDK
//
//  Created by Abdullah on 27/01/2024.
//

import Combine

final class CardViewModel {
    
    private let sharedRepository: SharedRepositoryDelegate
    private let cardRepository: CardRepositoryDelegate
    let responseWithNoBody = PassthroughSubject<ResponseWithNoBody?, Never>()
    let createPaymentResponse = PassthroughSubject<CreatePaymentResponse?, Never>()
    let encryptedResponse = PassthroughSubject<EncryptedResponse?, Never>()
    var errResponse = PassthroughSubject<ErrorReponse, Never>()
    //var errorReponseTwo = PassthroughSubject<ErrorReponseTwo, Never>()
    let transactionStatusResponse = PassthroughSubject<TransactionStatusResponse?, Never>()
    
    init(sharedRepository: SharedRepositoryDelegate, cardRepository: CardRepositoryDelegate) {
        self.sharedRepository = sharedRepository
        self.cardRepository = cardRepository
    }
    
    func createPayment(config: RexpaySDKConfig) async {
        let result = try? await sharedRepository.createPayment(config: config)
        switch result {
        case .success(let response):
            print("createPayment >> \(response)")
            createPaymentResponse.send(response)
        case .failure(let error):
            print("createPayment error >> \(error)")
            //createPaymentResponse.send(completion: .failure(error))
            errResponse.send(error)
            //createPaymentResponse?.send
        case .none:
//            createPaymentResponse.send(completion: .failure(ErrorReponse(message: "An error occured")))
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
    
    
    func insertPublicKey(clientId: String, publicKey: String) async {
        let result = try? await sharedRepository.insertPublicKey(clientId: clientId, publicKey: publicKey)
        switch result {
        case .success(let response):
            print("insertPublicKey >> \(response)")
            responseWithNoBody.send(response)
        case .failure(let error):
            print("responseWithNoBody error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
    
    func chargeCard(encryptedRequest: String) async {
        let result = try? await cardRepository.chargeCard(encryptedRequest: encryptedRequest)
        
        switch result {
        case .success(let response):
            print("chargeCardResponse >> \(response)")
            encryptedResponse.send(response)
        case .failure(let error):
            print("chargeCardResponse error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
    
    func authorizeTransaction(encryptedRequest: String) async {
        let result = try? await cardRepository.authorizeTransaction(encryptedRequest: encryptedRequest)
        switch result {
        case .success(let response):
            print("authorizeTransaction >> \(response)")
            encryptedResponse.send(response)
        case .failure(let error):
            print("authorizeTransaction error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
    
    func getTransactionStatus(transactionReference: String) async {
        let result = try? await sharedRepository.getTransactionStatus(transactionReference: transactionReference)
        switch result {
        case .success(let response):
            print("getTransactionStatus >> \(response)")
            transactionStatusResponse.send(response)
        case .failure(let error):
            print("getTransactionStatus error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
}
