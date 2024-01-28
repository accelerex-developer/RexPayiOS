//
//  PaymentChannelModel.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation

final class PaymentChannelModel {
    
    static func getData() -> [PaymentChannelData]{
        return [
            PaymentChannelData(leftIcon: "credit-card-payment", title: "Pay with Card", rightIcon: "right-arrow"),
            PaymentChannelData(leftIcon: "pay-with-ussd", title: "Pay with USSD", rightIcon: "right-arrow"),
            PaymentChannelData(leftIcon: "bank-building", title: "Pay with Bank", rightIcon: "right-arrow")
        ]
    }
}

struct PaymentChannelData {
    let leftIcon: String
    let title: String
    let rightIcon: String
}
