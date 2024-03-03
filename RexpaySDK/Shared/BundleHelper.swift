//
//  BundleHelper.swift
//  RexpaySDK
//
//  Created by Abdullah on 03/03/2024.
//

import Foundation
class BundleHelper {
    static var resolvedBundle: Bundle {
        #if SWIFT_PACKAGE
            print("it is spm")
            return Bundle.module
        #else
            print("it is not spm")
            return Bundle(for: BundleHelper.self)
        #endif
    }
}
