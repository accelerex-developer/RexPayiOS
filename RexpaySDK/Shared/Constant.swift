//
//  Constant.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import Foundation
import UIKit

class Constant {

    static func lightHaptic(){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    static var statusBarFrameHeight: CGFloat {
        if let statusBarHeight =
            
            UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height {
            print("Status bar height: \(statusBarHeight)")
            return statusBarHeight
        }
        return 0
    }
    
    static var deviceName: String {
        UIDevice.current.name
    }
    
    static var deviceCode: String {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
//
//    static var navWithStatusBarHeight: CGFloat {
//        return statusBarFrameHeight + 44 // 44 is the nabar height
//    }
    
    static var navWithStatusBarHeight2: CGFloat {
        return (UIWindow.key?.rootViewController?.navigationController?.navigationBar.bounds.height ?? 0) + statusBarFrameHeight
    }

    static let bundleIdentifier: String = "com.myapp.RexpaySDK"
}




