//
//  BankTransferViewModel.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import Combine

final class BankTransferViewModel {
    
    private let sharedRepository: SharedRepositoryDelegate
    private let bankRepository: BankRepositoryDelegate
    let bankTransferResponse = PassthroughSubject<BankTransferResponse?, Never>()
    let transactionStatusResponse = PassthroughSubject<TransactionStatusResponse?, Never>()
    var errResponse = PassthroughSubject<ErrorReponse, Never>()
    let createPaymentResponse = PassthroughSubject<CreatePaymentResponse?, Never>()
    
    init(sharedRepository: SharedRepositoryDelegate, bankRepository: BankRepositoryDelegate) {
        self.sharedRepository = sharedRepository
        self.bankRepository = bankRepository
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
    
    func getBankTransferDetails(bankTransferPayload: BankTransferPayload) async {
        let result = try? await bankRepository.getBankTransferDetails(bankTransferPayload: bankTransferPayload)
        switch result {
        case .success(let response):
            print("getBankTransferDetails >> \(response)")
            bankTransferResponse.send(response)
        case .failure(let error):
            print("getBankTransferDetails error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
}
