//
//  ControllerFactory.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
protocol ControllerFactoryProtocol {
    
    func makePaymentController() -> PaymentController
    
    func makeCardPaymentController() -> CardPaymentController
    
    func makeOTPController() -> OTPController
    
    func makeTransactionCompleteController() -> TransactionCompleteController
}

final class ControllerFactory: ControllerFactoryProtocol {
    
    private let dependencies: DependenciesDelegate
    
    init(dependencies: DependenciesDelegate) {
        self.dependencies = dependencies
    }
    
    func makePaymentController() -> PaymentController {
        let vc = PaymentController(config: dependencies.config)
        return vc
    }
    
    func makeCardPaymentController() -> CardPaymentController {
        let vc = CardPaymentController(config: dependencies.config)
        return vc
    }
    
    func makeOTPController() -> OTPController {
        let vc = OTPController(config: dependencies.config)
        return vc
    }
    
    func makeTransactionCompleteController() -> TransactionCompleteController {
        let vc = TransactionCompleteController(config: dependencies.config)
        return vc
    }
}
