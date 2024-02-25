//
//  CardPaymentController.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
import UIKit

final class CardPaymentController: MainBaseController {
    
    let cardPaymentView = CardPaymentView()
    
    private var config: RexpaySDKConfig
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: CardViewModel?
    
    var objectivePGPHelper: ObjectivePGPHelper?
    
    var params: [String: Any] = [:]
    
    var reference: String = ""
    
    init(config: RexpaySDKConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = cardPaymentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardPaymentView.cardPaymentContentView.paymentBtn.onClick(completion: weakify({ strongSelf in
            if strongSelf.isParamsValidated() {
                //strongSelf.coordinator?.showOTP()
                strongSelf.showLoader()
                Task {
                     await strongSelf.viewModel?.createPayment(config: strongSelf.config)
                }
            }
            else {
                strongSelf.showToastWithTitle("Please make sure all fields are fill correctly", type: .error)
            }
        }))
        
        cardPaymentView.leftArrowImg.onClick(completion: weakify({ strongSelf in
            strongSelf.coordinator?.goBack()
        }))
        
        cardPaymentView.onClick(completion: weakify({ strongSelf in
            strongSelf.cardPaymentView.endEditing(true)
        }))
        
     
        textFieldListener()
        responseListener()
        cardPaymentView.cardPaymentContentView.expiryDateTextField.shouldChangeCharactersInHandler = { textField,range,string in
            if string.isEmpty && range.length == 1 {
                return true  // Allow deletion
            }
            print("range.location is \(range.location)")
            print("range.string is \(string)")
            print("textField.text1 is \(textField.text)")
            //var asd = string
            // Append "/" after every 2 characters
//            if range.location == 1 || range.location == 4 {
//                print("textField.text2 is \(textField.text)")
//                if let text = textField.text {
//                    if !text.contains("/") {
//                        //string = string + "/"
//                        //textField.text = string
//                        textField.text?.append("/")
//                    }
//                }
//            }
            if string == "/" {
                    return false
                }
            if range.location == 2 {
                    textField.text?.append("/")
                }
            return true
        }
        
        updateViewWithData()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate.didRecieveMessage(message: "step two")
    }
    
    func isParamsValidated() -> Bool {
        [cardPaymentView.cardPaymentContentView.cardNumberTextField.isValidated,
         cardPaymentView.cardPaymentContentView.expiryDateTextField.isValidated,
         cardPaymentView.cardPaymentContentView.cvv2TextField.isValidated,
         cardPaymentView.cardPaymentContentView.pinTextField.isValidated].allSatisfy { $0 }
    }
    
    func textFieldListener() {
        cardPaymentView.cardPaymentContentView.cardNumberTextField.fieldDidChange = weakify({ storngSelf, input in
            storngSelf.params["pan"] = input
        })
        cardPaymentView.cardPaymentContentView.expiryDateTextField.fieldDidChange = weakify({ storngSelf, input in
            storngSelf.params["expiryDate"] = input?.replacingOccurrences(of: "/", with: "")
        })
        cardPaymentView.cardPaymentContentView.cvv2TextField.fieldDidChange = weakify({ storngSelf, input in
            storngSelf.params["cvv2"] = input
        })
        cardPaymentView.cardPaymentContentView.pinTextField.fieldDidChange = weakify({ storngSelf, input in
            storngSelf.params["pin"] = input
        })
    }
    
    func responseListener() {
        
        viewModel?.createPaymentResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                if let reference = data?.reference {
                    strongSelf.reference = data?.reference ?? ""
                    print("the reference is \(reference)")
                    print("the data?.clientId is \(data?.clientId)")
//                    strongSelf.showLoader()
//                    Task {
//                        await strongSelf.viewModel?.chargeCard(config: strongSelf.config, reference:reference, chargeCardParams: strongSelf.params)
//                    }
                    
                    Task {
                        if let clientPublicKey = strongSelf.objectivePGPHelper?.clientPublicKey,
                            let clientId = data?.clientId {
                            
                            await strongSelf.viewModel?.insertPublicKey(clientId: clientId, publicKey: clientPublicKey)
                        }
                        
                    }
                }
            }))
            .store(in: &subscriptions)
        
        
        viewModel?.responseWithNoBody
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                strongSelf.removeLoader()
                Task {
//                    if let encryptedRequest = try await ObjectivePGPHelper.encrypt(params: strongSelf.createCardPaylod(), addSignature: false) {
//                        await strongSelf.viewModel?.chargeCard(encryptedRequest: encryptedRequest)
//                    }
                    print("na no repsonse body be this")
                    if let encryptedDataString = try await strongSelf.objectivePGPHelper?.encrypt(params: strongSelf.createCardPaylod(), addSignature: false) {
                        
                       await strongSelf.viewModel?.chargeCard(encryptedRequest: encryptedDataString)
                    }
                }
            }))
            .store(in: &subscriptions)
        
        
        viewModel?.encryptedResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                switch completion {
                case .finished:
                    print("encryptedResponse error")
                case .failure(let error):
                    print("encryptedResponse is \(error)")
                    
                }
                strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                print("encryptedResponse => \(data)")
                Task {
                    guard let encryptedResponse = data?.encryptedResponse else {
                        print("Unable to unwrap encryptedResponse")
                        return
                    }
                    let decryptedResponse = try await strongSelf.objectivePGPHelper?.decrypt(encryptedStringResponse: encryptedResponse, andVerifySignature: false, withPassphrase: strongSelf.config.passphrase, type: ChargeCardDecrptedResponse.self)
                    
                    guard let responseCode = decryptedResponse?.responseCode,
                          let responseCode =  ResponseCode(rawValue: responseCode),
                          let paymentID = decryptedResponse?.paymentID else {
                        print("Unable to unwrap responseCode or paymentID")
                        return
                    }
                    
                    
                    if responseCode == .codeT0 {
                        strongSelf.coordinator?.showOTP(paymentId: paymentID)
                    }
                    else if responseCode == .code00 {
                        guard let amount = decryptedResponse?.amount,
                              let responseCode = decryptedResponse?.responseCode else {
                            return
                        }
                        strongSelf.coordinator?.showTransactionCompleted(amount: amount, responseCode: ResponseCode(rawValue: responseCode))
                    }
                    else if responseCode == .code01 {
                        guard let responseDescription = decryptedResponse?.responseDescription
                        else {
                            return
                        }
                        strongSelf.showToastWithTitle("\(responseDescription)", type: .error)
                    }
                }
            }))
            .store(in: &subscriptions)
        
        viewModel?.errResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: weakify({ strongSelf, error in
                strongSelf.showToastWithTitle("\(error.composeErrMessage)", type: .error)
                strongSelf.removeLoader()
            }))
            .store(in: &subscriptions)
        
//        viewModel?.errorReponseTwo
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: weakify({ strongSelf, error in
//                strongSelf.showToastWithTitle("\(error.composeErrMessage)", type: .error)
//                strongSelf.removeLoader()
//            }))
//            .store(in: &subscriptions)
    }
    
    func createCardPaylod() -> [String: Any]{
        let cardDetails: [String: Any] = [
            "authDataVersion" : "1",
            "pan" : params["pan"]!,
            "expiryDate" : params["expiryDate"]!,
            "cvv2" : params["cvv2"]!,
            "pin" : params["pin"]!
        ]
        let bodyPayload: [String: Any] = [
            "reference": reference,
            "amount": config.amount,
            "customerId": config.email,
            "cardDetails": cardDetails
        ]
        print("createCardPaylod is \(bodyPayload)")
        return bodyPayload
    }
    
    func updateViewWithData() {
        let view = cardPaymentView.cardPaymentContentView
        view.nameLabel.text = config.customerName
        view.priceLabel.text = "NGN \(config.amount)"
    }
    
    deinit {
        print("CardPaymentController is out from memory")
    }
}
