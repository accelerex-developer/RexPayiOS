//
//  TransactionCompleteController.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import UIKit

final class TransactionCompleteController: UIViewController {
    let transactionCompleteView = TransactionCompleteView()
    
    private var config: RexpaySDKConfig
    
    weak var coordinator: MainCoordinator?
    
    var amount: String?
    var responseCode: ResponseCode?
    var responseDescription: String?
    
    init(config: RexpaySDKConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = transactionCompleteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewWithData()
        
        
        transactionCompleteView.cancelIcon.onClick(completion: weakify({ strongSelf in
            strongSelf.coordinator?.dismissAll()
        }))
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate.didRecieveMessage(message: "step two")
    }
    
    func updateViewWithData() {
        guard let responseCode = responseCode else {
            print("Unable to unwrap response code")
            return
        }
        if responseCode == .code00 {
            if let amount = amount {
                transactionCompleteView.transactionCompleteContentView.contentLabel.text = "You have made a payment of NGN \(amount) We have sent a receipt to your email"
                
                transactionCompleteView.transactionCompleteContentView.paymentStatusImageView.image = UIImage(named: "check-green", in: BundleHelper.resolvedBundle, with: nil)
            }
        }
        else if responseCode == .code02 {
            if let responseDescription = responseDescription {
                transactionCompleteView.transactionCompleteContentView.headerLabel.text = "Pending"
                transactionCompleteView.transactionCompleteContentView.contentLabel.text = responseDescription
                transactionCompleteView.transactionCompleteContentView.paymentStatusImageView.image = UIImage(named: "pending-50", in: BundleHelper.resolvedBundle, with: nil)
            }
        }
    }
    
    @objc func goBack() {
        coordinator?.goBack()
    }
    
    deinit {
        print("CardPaymentController is out from memory")
    }
}
