//
//  CreatePayment.swift
//  RexpaySDK
//
//  Created by Abdullah on 24/01/2024.
//


struct CreatePaymentResponse: Codable {
    var reference: String?
    var clientId: String?
    var paymentUrl: String?
    var status: String?
    var paymentChannel: String?
    var paymentUrlReference: String?
    var externalPaymentReference: String?
    var fees: String?
    var currency: String?
}
