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
    public var callbackUrl: String?
    public var email: String?
    public var customerName: String?
    public var delegate: RexpaySDKResponseDelegate?
}
