//
//  RexpayConfig.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation

public final class RexpaySDKConfig {
    
    /// Reference
    public var reference: String
    
    /// The amount that the customer want to pay
    public var amount: Double
    
    /// The currency that the customer want to pay with
    public var currency: String
    
    /// User ID
    public var userId: String
    
    /// If a callbackUrl is provided in the createpayment payload, you will receive transaction notifications
    public var callbackUrl: String?
    
    /// Customer email
    public var email: String
    
    /// Customer name e.d John Doe
    public var customerName: String
    
    /// Client username
    public var username: String
    
    /// Client password
    public var password: String
    
    /// The path to the rexpay public key
    public var rexpayPublicKeyPath: String
    
    /// The path to the client public key
    public var publicKeyPath: String
    
    /// The path to the client prrivate key
    public var privateKeyPath: String
    
    /// This should be provided if used when you're generating your pgp key pair
    public var passphrase: String?
    
    /// This will show all the available channels by default
    /// Feel free to make any modifications as needed.
    public var selectedChannels: [RexpayPaymentChannel]
    
    /// This serves as the communication channel
    /// between the SDK and the class (i.e UIViewController or View) that initiates the SDK.
    public var delegate: RexpaySDKResponseDelegate
    
    /// The SDK offers two environments: production and sandbox, with the default being set to sandbox.
    public var rexpayEnv: RexpayEnv
    
    public init(reference: String, amount: Double, currency: String = "NGN", userId: String, callbackUrl: String? = nil, email: String, customerName: String, username: String, password: String, rexpayPublicKeyPath: String, publicKeyPath: String, privateKeyPath: String, passphrase: String? = nil, selectedChannels: [RexpayPaymentChannel] = [.card, .ussd, .bankTransfer], delegate: RexpaySDKResponseDelegate, rexpayEnv: RexpayEnv = .sandbox) {
        self.reference = reference
        self.amount = amount
        self.currency = currency
        self.userId = userId
        self.callbackUrl = callbackUrl
        self.email = email
        self.customerName = customerName
        self.username = username
        self.password = password
        self.rexpayPublicKeyPath = rexpayPublicKeyPath
        self.publicKeyPath = publicKeyPath
        self.privateKeyPath = privateKeyPath
        self.passphrase = passphrase
        self.selectedChannels = selectedChannels
        self.delegate = delegate
        self.rexpayEnv = rexpayEnv
    }
}

public enum RexpayPaymentChannel {
  case card, ussd, bankTransfer
}

public enum RexpayEnv {
  case sandbox, production
}
