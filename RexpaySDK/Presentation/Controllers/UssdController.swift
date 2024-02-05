//
//  UssdController.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import UIKit
import Combine

final class UssdController: MainBaseController {
    
    var subscriptions: Set<AnyCancellable> = []
    
    let ussdView = UssdView()
    
    private var config: RexpaySDKConfig
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: UssdViewModel?
    
    var params: [String: Any] = [:]
    
    var reference: String = ""
    
    var transactionReference: String?
    
    var selectedBank: Bank?
    
    var chargeByUssdResponse: ChargeByUssdResponse?
    
    init(config: RexpaySDKConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = ussdView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ussdView.ussdContentView.bankContainerView.onClick(completion: weakify({ strongSelf in
            //strongSelf.showLoader()
            strongSelf.showBanks()
//            Task {
//                await strongSelf.viewModel?.createPayment(config: strongSelf.config)
//            }
        }))
//
//        bankTransferView.bankTransferContentView.paidBtn.onClick(completion: weakify({ strongSelf in
//            strongSelf.showLoader()
//            Task {
//                if let transactionReference = strongSelf.transactionReference {
//                    await strongSelf.viewModel?.getBankTransferStatus(transactionReference: transactionReference)
//                }
//            }
//        }))
        
        ussdView.leftArrowImg.onClick(completion: weakify({ strongSelf in
            strongSelf.coordinator?.goBack()
        }))
     

        responseListener()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate?.didRecieveMessage(message: "step two")
    }
    
    func showBanks() {
        
        let bankDropDownController = BankDropDownController()
        coordinator?.presentBanks(bankDropDownController: bankDropDownController)
        
        bankDropDownController.selectedBankHandler = weakify({ strongSelf, data in
            strongSelf.ussdView.ussdContentView.selectedBankLabel.text = data.name ?? "Not found"
            strongSelf.ussdView.ussdContentView.selectedBankLabel.textColor = .hex1A1A1A
            strongSelf.selectedBank = data
            strongSelf.ussdView.ussdContentView.toggleArrow()
            Task {
                await strongSelf.viewModel?.createPayment(config: strongSelf.config)
            }
        })
        
        bankDropDownController.dismisHandler = weakify({ strongSelf in
            print("i'm out oooo")
            strongSelf.ussdView.ussdContentView.toggleArrow()
        })
    }
    func responseListener() {
        
        viewModel?.createPaymentResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                strongSelf.removeLoader()
                if let reference = data?.reference {
                    strongSelf.reference = data?.reference ?? ""
                    print("the reference is \(reference)")
                    print("the data?.clientId is \(data?.clientId)")
                    
                    Task {
                        if  let customerName = strongSelf.config.customerName,
                            let reference = data?.reference,
                            let clientId = data?.clientId,
                            let paymentUrlReference = data?.paymentUrlReference,
                            let amount = strongSelf.config.amount,
                            let customerId = strongSelf.config.email,
                            let selectedBankCode = strongSelf.selectedBank?.code {
                            
                            let chargeByUssdPayload = ChargeByUssdPayload(reference: reference, clientId: clientId, amount: amount, userId: customerId, bankCode: selectedBankCode, paymentUrlReference: paymentUrlReference)
                            
                            strongSelf.showLoader()
                            await strongSelf.viewModel?.chargeByUssd(chargeByUssdPayload: chargeByUssdPayload)
                            
                        }
                    }
                }
            }))
            .store(in: &subscriptions)
        
        
        viewModel?.chargeByUssdResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                switch completion {
                case .finished:
                    print("chargeByUssdResponse error")
                case .failure(let error):
                    print("chargeByUssdResponse is \(error)")
                    
                }
                strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                print("chargeByUssdResponse => \(data)")
                strongSelf.removeLoader()
                strongSelf.ussdView.ussdContentView.showUssdCodeView()
                strongSelf.updateView(with: data)
                strongSelf.chargeByUssdResponse = data
                
            }))
            .store(in: &subscriptions)
        
        viewModel?.transactionStatusResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                switch completion {
                case .finished:
                    print("transactionStatusResponse error")
                case .failure(let error):
                    print("transactionStatusResponse is \(error)")
                    
                }
                strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                strongSelf.removeLoader()
                print("transactionDetails => \(data)")
                print("show success page")
                strongSelf.coordinator?.showTransactionCompleted(transactionStatusResponse: data)
            }))
            .store(in: &subscriptions)
        
        
        viewModel?.ussdDetailsResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                switch completion {
                case .finished:
                    print("ussdDetailsResponse error")
                case .failure(let error):
                    print("transactionDetails is \(error)")
                    
                }
                strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                strongSelf.removeLoader()
                print("ussdDetailsResponse => \(data)")
                print("show success page")
                strongSelf.removeLoader()
                if let statusMessage = data?.statusMessage {
                    strongSelf.showToastWithTitle("\(statusMessage)", type: .success)
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

    }
    
    func updateView(with data: ChargeByUssdResponse?) {
        let ussdContentView = ussdView.ussdContentView
        ussdContentView.ussdCodeLabel.text  = data?.providerResponse
        
        ussdContentView.ussdCodeLabel.onClick(completion: weakify({ strongSelf in
            if let ussdCode = strongSelf.chargeByUssdResponse?.providerResponse {
                strongSelf.dial(ussdCode: ussdCode)
            }
        }))
        
        ussdContentView.checkTransactionStatusLabel.onClick(completion: weakify({ strongSelf in
            Task {
                if let transRef = strongSelf.chargeByUssdResponse?.reference {
                    await strongSelf.viewModel?.getUssdDetails(transRef: transRef)
                }
            }
        }))
    }
    
    func dial(ussdCode: String) {
        let ussdURLString = "TEL://" + ussdCode
        //let ussdURLString = "TEL://" + "*901*000*2116#"
        
        // Convert the USSD code string into a URL
        if let ussdURL = URL(string: ussdURLString) {
            // Check if the device can open the URL (i.e., if it's capable of initiating USSD codes)
            if UIApplication.shared.canOpenURL(ussdURL) {
                // Open the phone app with the specified USSD code
                UIApplication.shared.open(ussdURL, options: [:], completionHandler: nil)
            } else {
                // Handle the case where the device can't initiate USSD codes
                print("Device cannot initiate USSD codes.")
            }
        }
    }
   
    
    deinit {
        print("UssdController is out from memory")
    }
}
