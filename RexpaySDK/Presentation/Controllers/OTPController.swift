//
//  OTPController.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

final class OTPController: MainBaseController {
    
    let otpView = OTPView()
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: CardViewModel?
    
    var paymentId: String?
    
    var objectivePGPHelper: ObjectivePGPHelper?
    
    private var config: RexpaySDKConfig
    
    init(config: RexpaySDKConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = otpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpView.otpContenView.paymentBtn.onClick(completion: weakify({ strongSelf in
            strongSelf.showLoader()
            guard let otp = strongSelf.otpView.otpContenView.otpTextField.text, !otp.isEmpty, let paymentId = strongSelf.paymentId else {
                print("unable to retrieve the otp or paymentId")
                return
            }
            Task {
                let payload = strongSelf.createAuthourizeCardPaylod(otp: otp, paymentId: paymentId)
                
                guard let encryptedDataString = try await strongSelf.objectivePGPHelper?.encrypt(params:payload, addSignature: false) else {
                    print("unable to encrypt the authourize card payload")
                    return
                }
                
                await strongSelf.viewModel?.authorizeTransaction(encryptedRequest: encryptedDataString)
            }
        }))
        
        otpView.onClick(completion: weakify({ strongSelf in
            strongSelf.otpView.endEditing(true)
        }))
        
        updateViewWithData()
        handleResponse()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate.didRecieveMessage(message: "step two")
    }
    
    func updateViewWithData() {
        let view = otpView.otpContenView
        view.nameLabel.text = config.customerName
        view.priceLabel.text = "NGN \(config.amount)"
    }
    
    func handleResponse() {
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
                strongSelf.removeLoader()
                print("encryptedResponse => \(data)")
                Task {
                    guard let encryptedResponse = data?.encryptedResponse else {
                        print("Unable to unwrap encryptedResponse")
                        return
                    }
                    let decryptedResponse = try await strongSelf.objectivePGPHelper?.decrypt(encryptedStringResponse: encryptedResponse, andVerifySignature: false, withPassphrase: strongSelf.config.passphrase, type: ChargeCardDecrptedResponse.self)
                    
                    guard let responseCode = decryptedResponse?.responseCode,
                          let responseCode =  ResponseCode(rawValue: responseCode) else {
                        print("Unable to unwrap responseCode")
                        return
                    }
                    
                    if responseCode == .code00 {
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
    
    func createAuthourizeCardPaylod(otp: String, paymentId: String) -> [String: Any]{
        let bodyPayload: [String: Any] = [
            "otp": otp,
            "paymentId": paymentId
        ]
        print("createAuthourizeCardPaylod is \(bodyPayload)")
        return bodyPayload
    }
    
    
    @objc func goBack() {
        coordinator?.goBack()
    }
    
    deinit {
        print("OTPController is out from memory")
    }
}
