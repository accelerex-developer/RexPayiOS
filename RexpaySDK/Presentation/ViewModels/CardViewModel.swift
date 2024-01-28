//
//  CardwwViewModel.swift
//  RexpaySDK
//
//  Created by Abdullah on 27/01/2024.
//

import Combine

class CardViewModel {
    
    private let paymentRepository: PaymentRepositoryDelegate
    private let cardRepository: CardRepositoryDelegate
    let createPaymentResponse = PassthroughSubject<CreatePaymentResponse?, Never>()
    var chargeCardResponse: CurrentValueSubject<ChargeCardResponse?, ErrorReponse>?
    var errResponse = PassthroughSubject<ErrorReponse, Never>()
    
    init(paymentRepository: PaymentRepositoryDelegate, cardRepository: CardRepositoryDelegate) {
        self.paymentRepository = paymentRepository
        self.cardRepository = cardRepository
    }
    
    func createPayment(config: RexpaySDKConfig) async {
        let result = try? await paymentRepository.createPayment(config: config)
        switch result {
        case .success(let response):
            print("createPayment >> \(createPayment)")
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
    
    func chargeCard(urlString: String, config: RexpaySDKConfig, reference: String, chargeCardParams: [String: Any]) async {
        let result = try? await cardRepository.chargeCard(urlString: urlString, config: config, reference: reference, params: chargeCardParams)
        
        switch result {
        case .success(let response):
            print("chargeCardResponse >> \(createPayment)")
            chargeCardResponse?.send(response)
        case .failure(let error):
            print("chargeCardResponse error >> \(error)")
            chargeCardResponse?.send(completion: .failure(error))
        case .none:
            chargeCardResponse?.send(completion: .failure(ErrorReponse(message: "An error occured")))
        }
    }
}
