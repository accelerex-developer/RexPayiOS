//
//  RexpaySDK.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
import SwiftUI

protocol RexpaySDKDelegate {
    associatedtype Content: View
    func launch(hostView: any View) -> Content
    func launch(presentingViewController: UIViewController)
}

public final class RexpaySDK: RexpaySDKDelegate {
    
    /// Use TransactHubConfig to setup your configuration
    private var config: RexpaySDKConfig
    var coordinator: MainCoordinator?
    
    public init(config: RexpaySDKConfig) {
        self.config = config
        UIFont.registerAllFonts(bundle: Bundle(identifier: Constant.bundleIdentifier)!)
    }
    
    /// This method will be use to launch the sdk in Swiftui
    /// - Parameters:
    ///   - config: RexpaySDKView
    ///   - hostView: any View
    /// - Returns: some View
    public func launch(hostView: any View) -> some View {
        RexpaySDKView(config: config, hostView: hostView)
    }
    
    /// This method will be use to launch the sdk in UIKit
    /// - Parameter presentingViewController: UIViewController
    public func launch(presentingViewController: UIViewController) {
        let dependencies = Dependencies(config: config)
         coordinator = MainCoordinator(presentingViewController: presentingViewController, controllerFactory: ControllerFactory(dependencies: dependencies))
        
        coordinator?.start()
    }
    
    deinit {
        print("RexpaySDK is out from memory")
    }
}
