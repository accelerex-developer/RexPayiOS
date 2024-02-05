//
//  RexpayConfig.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
public final class RexpaySDKConfig {
    public init() {}
    public var reference: String?
    public var amount: Double?
    public var currency: String?
    public var userId: String?
    
    /// If a callbackUrl is provided in the createpayment payload, you will receive transaction notifications
    public var callbackUrl: String?
    public var email: String?
    public var customerName: String?
    public var publicKeyPath: String?
    public var privateKeyPath: String?
    public var allowedChannels: [RexpayPaymentChannel]? = [.card, .ussd, .bankTransfer]
    public var delegate: RexpaySDKResponseDelegate?
}
public enum RexpayPaymentChannel {
  case card, ussd, bankTransfer
}
