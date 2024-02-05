//
//  TransactionDetailsResponse.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//


struct TransactionStatusResponse: Codable {
    var amount: String?
    var paymentReference: String?
    var transactionDate: String?
    var currency: String?
    var fees: Double?
    var channel: String?
    var responseCode: String?
    var responseDescription: String?
}
