//
//  TransactionCompleteController.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

enum ResponseCode: String {
    case complete = "00"
    case pending = "02"
}

final class TransactionCompleteController: UIViewController {
    let transactionCompleteView = TransactionCompleteView()
    
    private var config: RexpaySDKConfig
    
    weak var coordinator: MainCoordinator?
    
    var transactionStatusResponse: TransactionStatusResponse?
    
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
        if let responseCode = transactionStatusResponse?.responseCode{
            let responseCode = ResponseCode(rawValue: responseCode)
            
            switch responseCode {
            case .complete:
                print("")
                if let amount = transactionStatusResponse?.amount {
                    transactionCompleteView.transactionCompleteContentView.contentLabel.text = "You have made a payment of NGN \(amount) We have sent a receipt to your email"
                }
            case .pending:
                print("")
                if let responseDescription = transactionStatusResponse?.responseDescription {
                    transactionCompleteView.transactionCompleteContentView.headerLabel.text = "Pending"
                    transactionCompleteView.transactionCompleteContentView.contentLabel.text = responseDescription
                }
            default:
                print("Unknow response code")
            }
        }
        
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate?.didRecieveMessage(message: "step two")
    }
    
    @objc func goBack() {
        coordinator?.goBack()
    }
    
    deinit {
        print("CardPaymentController is out from memory")
    }
}
