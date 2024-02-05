//
//  BankTransferResponse.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import Foundation

struct BankTransferResponse: Codable {
    var amount: String?
    var transactionReference: String?
    var accountNumber: String?
    var accountName: String?
    var bankName: String?
    var responseCode: String?
    var responseDescription: String?
}

struct BankTransferPayload {
    var customerName: String
    var reference: String
    var amount: String
    var customerId: String
}
