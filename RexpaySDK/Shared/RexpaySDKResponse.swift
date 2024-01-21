//
//  RexpaySDKResponse.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
public protocol RexpaySDKResponseDelegate {
    func didRecieveMessage(message: String)
}
