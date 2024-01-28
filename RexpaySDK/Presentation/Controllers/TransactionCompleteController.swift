//
//  TransactionCompleteController.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

final class TransactionCompleteController: UIViewController {
    let transactionCompleteView = TransactionCompleteView()
    
    private var config: RexpaySDKConfig
    
     weak var coordinator: MainCoordinator?
    
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
