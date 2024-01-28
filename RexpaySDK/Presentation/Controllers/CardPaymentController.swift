//
//  CardPaymentController.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
import UIKit
import Combine

final class CardPaymentController: MainBaseController {
    
    var subscriptions: Set<AnyCancellable> = []
    
    let cardPaymentView = CardPaymentView()
    
    private var config: RexpaySDKConfig
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: CardViewModel?
    
    var params: [String: Any] = [:]
    
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
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate?.didRecieveMessage(message: "step two")
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
            storngSelf.params["expiryDate"] = input
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
                    print("the reference is \(reference)")
//                    strongSelf.showLoader()
//                    Task {
//                        await strongSelf.viewModel?.chargeCard(config: strongSelf.config, reference:reference, chargeCardParams: strongSelf.params)
//                    }
                }
            }))
            .store(in: &subscriptions)
        
        viewModel?.chargeCardResponse?
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                switch completion {
                case .finished:
                    print("chargeCardResponse error")
                case .failure(let error):
                    print("chargeCardResponse is \(error)")
                    
                }
                strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                
            }))
            .store(in: &subscriptions)
        
        viewModel?.errResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: weakify({ strongSelf, error in
                strongSelf.showToastWithTitle("\(error.composeErrMessage)", type: .error)
                strongSelf.removeLoader()
            }))
            .store(in: &subscriptions)
    }
    
    deinit {
        print("CardPaymentController is out from memory")
    }
}
