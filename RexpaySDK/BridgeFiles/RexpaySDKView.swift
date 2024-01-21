//
//  RexpaySDKView.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
import SwiftUI

 struct RexpaySDKView: UIViewControllerRepresentable {

    private let config: RexpaySDKConfig

    private let hostView: any View
    
    public init(config: RexpaySDKConfig, hostView: any View) {
        self.config = config
        self.hostView = hostView
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        config.delegate = hostView as? RexpaySDKResponseDelegate
        let dependencies = Dependencies(config: config)
        let coordinator = MainCoordinator(controllerFactory: ControllerFactory(dependencies: dependencies))
        let navigationController = coordinator.getNavigationController()
        return navigationController
        
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
