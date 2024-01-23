//
//  OTPController.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

final class OTPController: UIViewController {
    let otpView = OTPView()
  
    
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
        view = otpView
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        otpView.otpContenView.paymentBtn.onClick(completion: weakify({ strongSelf in
            strongSelf.coordinator?.showTransactionCompleted()
        }))
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
