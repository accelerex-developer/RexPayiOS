//
//  UssdViewModel.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import Combine

final class UssdViewModel {
    
    private let sharedRepository: SharedRepositoryDelegate
    private let ussdRepository: UssdRepositoryDelegate
    let chargeByUssdResponse = PassthroughSubject<ChargeByUssdResponse?, Never>()
    let ussdDetailsResponse = PassthroughSubject<UssdDetailsResponse?, Never>()
    let transactionStatusResponse = PassthroughSubject<TransactionStatusResponse?, Never>()
    var errResponse = PassthroughSubject<ErrorReponse, Never>()
    let createPaymentResponse = PassthroughSubject<CreatePaymentResponse?, Never>()
    
    init(sharedRepository: SharedRepositoryDelegate, ussdRepository: UssdRepositoryDelegate) {
        self.sharedRepository = sharedRepository
        self.ussdRepository = ussdRepository
    }
    
    func createPayment(config: RexpaySDKConfig) async {
        let result = try? await sharedRepository.createPayment(config: config)
        switch result {
        case .success(let response):
            print("createPayment >> \(response)")
            createPaymentResponse.send(response)
        case .failure(let error):
            print("createPayment error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
    
    func getTransactionStatus(transactionReference: String) async {
        let result = try? await sharedRepository.getTransactionStatus(transactionReference: transactionReference)
        switch result {
        case .success(let response):
            print("getBankTransferStatus >> \(response)")
            transactionStatusResponse.send(response)
        case .failure(let error):
            print("getBankTransferStatus error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
    
    func chargeByUssd(chargeByUssdPayload: ChargeByUssdPayload) async {
        let result = try? await ussdRepository.chargeByUssd(chargeByUssdPayload: chargeByUssdPayload)
        switch result {
        case .success(let response):
            print("chargeByUssd >> \(response)")
            chargeByUssdResponse.send(response)
        case .failure(let error):
            print("chargeByUssd error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
    
    func getUssdDetails(transRef: String) async {
        let result = try? await ussdRepository.getUssdDetails(transRef: transRef)
        switch result {
        case .success(let response):
            print("getUssdDetails >> \(response)")
            ussdDetailsResponse.send(response)
        case .failure(let error):
            print("getUssdDetails error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
}
