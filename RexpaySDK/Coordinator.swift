//
//  Coordinator.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
    func getNavigationController() -> UINavigationController
}

final class MainCoordinator: Coordinator {
    var presentingViewController: UIViewController?
    var navigationController: UINavigationController?
    let controllerFactory: ControllerFactoryProtocol
    
    init(presentingViewController: UIViewController? = nil, controllerFactory: ControllerFactoryProtocol) {
        self.presentingViewController = presentingViewController
        self.controllerFactory = controllerFactory
    }

    func start() {
        let paymentController = controllerFactory.makePaymentController()
        paymentController.coordinator = self
        navigationController = UINavigationController(rootViewController: paymentController)
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.setNavigationBarHidden(true, animated: true)
        presentingViewController?.present(navigationController!, animated: true, completion: nil)
    }
    
    func getNavigationController() -> UINavigationController {
        let paymentController = controllerFactory.makePaymentController()
        paymentController.coordinator = self
        navigationController = UINavigationController(rootViewController: paymentController)
        navigationController?.setNavigationBarHidden(true, animated: true)
        return navigationController!
    }
    
    func showCardPayment() {
        let cardPaymentController = controllerFactory.makeCardPaymentController()
        cardPaymentController.coordinator = self
        navigationController?.pushViewController(cardPaymentController, animated: true)
    }
    
    func showBankPayment() {
        let bankTransferController = controllerFactory.makeBankTransferController()
        bankTransferController.coordinator = self
        navigationController?.pushViewController(bankTransferController, animated: true)
    }
    
    func showUssdPayment() {
        let ussdController = controllerFactory.makeUssdController()
        ussdController.coordinator = self
        navigationController?.pushViewController(ussdController, animated: true)
    }
    
    func showOTP(paymentId: String) {
        let otpController = controllerFactory.makeOTPController()
        otpController.coordinator = self
        otpController.paymentId = paymentId
        navigationController?.pushViewController(otpController, animated: true)
    }
    
    func showTransactionCompleted(amount: String, responseCode: ResponseCode?, responseDescription: String? = "") {
        let transactionCompleteController = controllerFactory.makeTransactionCompleteController()
        transactionCompleteController.coordinator = self
        transactionCompleteController.amount = amount
        transactionCompleteController.responseCode = responseCode
        transactionCompleteController.responseDescription = responseDescription
        navigationController?.pushViewController(transactionCompleteController, animated: true)
    }
    
    func presentBanks(bankDropDownController: BankDropDownController) {
        bankDropDownController.modalPresentationStyle = .overCurrentContext
        bankDropDownController.modalTransitionStyle = .coverVertical
        navigationController?.present(bankDropDownController, animated: true)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func dismissAll() {
        navigationController?.presentingViewController?.dismiss(animated: true)
        navigationController = nil
    }
    
    deinit {
        print("MainCoordinator is out from memory")
    }
}
