//
//  ChargeCardResponse.swift
//  RexpaySDK
//
//  Created by Abdullah on 24/01/2024.
//


struct EncryptedResponse: Codable {
    var encryptedResponse: String?
}

struct ChargeCardDecrptedResponse: Codable {
    let paymentID, amount, transactionReference, responseCode: String?
    let responseDescription: String?

    enum CodingKeys: String, CodingKey {
        case paymentID = "paymentId"
        case amount, transactionReference, responseCode, responseDescription
    }
}
