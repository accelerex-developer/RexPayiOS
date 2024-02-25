//
//  TransactionCompleteContentView.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

final class TransactionCompleteContentView: ScrollableView<ScrollViewContentSize>  {
    
    
    let headerLabel: Label = {
        let label = Label(text: "Payment Successful", font: .poppinsBold(size: 15), textColor: .hex1A1A1A, alignment: .center)
        return label
    }()
    
    let contentLabel: Label = {
        let label = Label(text: "You have made a payment of NGN 120,000.00. We have sent a receipt to your email.", font: .poppinsRegular(size: 15), numberOfLines: 2, textColor: .hex1A1A1A, alignment: .center)
        return label
    }()
    
    let goToDashboardLabel: Label = {
        let label = Label(text: "Go to Dashboard", font: .poppinsBold(size: 14), textColor: .hexED1C25, alignment: .center)
        return label
    }()
    
    let paymentStatusImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "check-green", in: Bundle(for: TransactionCompleteContentView.self), with: nil))
        //img.backgroundColor = .hex707070
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override func setup() {
        super.setup()
        
        container.addSubviews(paymentStatusImageView, headerLabel, contentLabel)
        paymentStatusImageView.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 50, left: 20, bottom: 0, right: 20), size: .init(height: 80))

        headerLabel.anchor(top: paymentStatusImageView.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 15, left: 20, bottom: 0, right: 20))

        contentLabel.anchor(top: headerLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))

//        goToDashboardLabel.anchor(top: contentLabel.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
}
