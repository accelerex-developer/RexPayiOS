//
//  ChargeByUssdResponse.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//


struct ChargeByUssdResponse: Codable {
    var reference: String?
    var clientId: String?
    var paymentUrl: String?
    var status: String?
    var paymentChannel: String?
    var providerResponse: String?
    var paymentUrlReference: String?
    var providerExtraInfo: String?
    var externalPaymentReference: String?
    var fees: Double?
    var currency: String?
}

struct ChargeByUssdPayload {
    var reference: String
    var clientId: String
    var amount: Double
    var currency: String = "NGN"
    var paymentChannel: String = "USSD"
    var userId: String
    var bankCode: String
    var callbackUrl: String = ""
    var paymentUrlReference: String
}
