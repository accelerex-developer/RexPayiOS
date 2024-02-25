//
//  BankTransferController.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//


final class BankTransferController: MainBaseController {
    
    let bankTransferView = BankTransferView()
    
    private var config: RexpaySDKConfig
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: BankTransferViewModel?
    
    var params: [String: Any] = [:]
    
    var reference: String = ""
    
    var transactionReference: String?
    
    init(config: RexpaySDKConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = bankTransferView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bankTransferView.bankTransferContentView.getAccountDetailsBtn.onClick(completion: weakify({ strongSelf in
            strongSelf.showLoader()
            Task {
                await strongSelf.viewModel?.createPayment(config: strongSelf.config)
            }
        }))
        
        bankTransferView.bankTransferContentView.paidBtn.onClick(completion: weakify({ strongSelf in
            strongSelf.showLoader()
            Task {
                if let transactionReference = strongSelf.transactionReference {
                    await strongSelf.viewModel?.getTransactionStatus(transactionReference: transactionReference)
                }
            }
        }))
        
        bankTransferView.leftArrowImg.onClick(completion: weakify({ strongSelf in
            strongSelf.coordinator?.goBack()
        }))
     

        responseListener()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate.didRecieveMessage(message: "step two")
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
                        
                            if let reference = data?.reference {
                            
                            let bankTransferPayload = BankTransferPayload(customerName: strongSelf.config.customerName, reference: reference, amount: "\(strongSelf.config.amount)", customerId: strongSelf.config.email)
                            
                            await strongSelf.viewModel?.getBankTransferDetails(bankTransferPayload:bankTransferPayload)
                            
                        }
                        
                    }
                }
            }))
            .store(in: &subscriptions)
        
        
        viewModel?.bankTransferResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                switch completion {
                case .finished:
                    print("bankTransferResponse error")
                case .failure(let error):
                    print("bankTransferResponse is \(error)")
                    
                }
                strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                print("bankTransferResponse => \(data)")
                strongSelf.removeLoader()
                strongSelf.transactionReference = data?.transactionReference
                strongSelf.updateView(with: data)
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
                
                guard let amount = data?.amount,
                      let responseCode = data?.responseCode,
                      let responseDescription = data?.responseDescription else {
                    return
                }
                strongSelf.coordinator?.showTransactionCompleted(amount: amount, responseCode: ResponseCode(rawValue: responseCode), responseDescription: responseDescription)
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
    
    func updateView(with data: BankTransferResponse?) {
        let view = bankTransferView.bankTransferContentView
        view.showAccountDetailsView()
        view.bankNameLabel.text = "Bank: \(data?.bankName ?? "Not found")"
        view.accountNameLabel.text = "Account Name: \(data?.accountName ?? "Not found")"
        view.accountNumberLabel.text = "Account number: \(data?.accountNumber ?? "Not found")"
    }
    
    deinit {
        print("BankTransferController is out from memory")
    }
}
