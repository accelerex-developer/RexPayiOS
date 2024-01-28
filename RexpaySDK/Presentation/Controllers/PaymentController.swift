//
//  RexpayPaymentController.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
import UIKit

final class PaymentController: UIViewController {
    
    let paymentView = PaymentView()
    
    let myButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Go to next", for: .normal)
        return btn
    }()
    
    private var config: RexpaySDKConfig
    
    var coordinator: MainCoordinator?
    
    public init(config: RexpaySDKConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = paymentView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        paymentView.myButtonn.onClick(completion: weakify({ strongSelf in
            print("I'm working .....")
        }))
        
        paymentView.paymentContentView.didSelectAt = weakify({ strongSelf in
            print("I'm working .....")
            strongSelf.coordinator?.showCardPayment()
        })
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate?.didRecieveMessage(message: "PaymentController did apppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        config.delegate?.didRecieveMessage(message: "PaymentController did disappear")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc func goToNext() {
        coordinator?.showCardPayment()
    }
    
    deinit {
        print("PaymentController is out from memory")
    }
}
