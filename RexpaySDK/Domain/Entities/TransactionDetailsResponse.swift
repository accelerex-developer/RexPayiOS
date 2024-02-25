//
//  TransactionDetailsResponse.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

enum ResponseCode: String {
    case code00 = "00"
    case code02 = "02"
    case codeT0 = "T0"
    case code01 = "01"
    case codeS0 = "S0" //Redirect to 3d secure
}

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
