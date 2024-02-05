//
//  UssdDetailsResponse.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import Foundation

struct UssdDetailsResponse: Codable {
    var referenceId: String?
    var clientId: String?
    var userId: String?
    var amount: Double?
    var fees: Double?
    var currency: String?
    var createdAt: String?
    var channel: String?
    var status: String?
    var statusMessage: String?
    var providerReference: String?
    var provider: String?
    var providerInitiated: Bool?
    var providerResponse: String?
    var paymentUrl: String?
    var clientName: String?
    var metadata: UssdDetailsMetadata?
}

struct UssdDetailsMetadata: Codable {
    var customerName: String?
    var email: String?
}
