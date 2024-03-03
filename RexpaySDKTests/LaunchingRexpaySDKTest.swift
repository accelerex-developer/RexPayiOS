//
//  LaunchingRexpaySDKTest.swift
//  RexpaySDKTests
//
//  Created by Abdullah on 26/02/2024.
//

import XCTest
@testable import RexpaySDK
import SwiftUI

final class LaunchingRexpaySDKTest: XCTestCase {
    
    func test_should_launch_sdk_from_uikit_project() {
        //Given
//        var clientVC: AA?
//        let config = RexpaySDKConfig(
//            reference: "sman024",
//            amount: 210,
//            userId: "awoyeyetimilehin@gmail.com",
//            email: "awoyeyetimilehin@gmail.com",
//            customerName: "Victor Musa",
//            username: "talk2phasahsyyahoocom",
//            password: "f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85",
//            rexpayPublicKeyPath: "",
//            publicKeyPath: "",
//            privateKeyPath: "",
//            delegate: clientVC as? RexpaySDKResponseDelegate)
//        config.amount = 20
//        clientVC  = AA(config: config)
//        config.delegate = clientVC as! RexpaySDKResponseDelegate
        //config.delegate = clientVC as? any RexpaySDKResponseDelegate
        
        let vc = ClientUIKitVC()
        vc.startSDK()
        
        //When
//        let rexpaySDK = RexpaySDK(config: vc.makeConfig())
//        vc.rexpaySDK.launch(presentingViewController: vc)
        
        //Assert
        let topViewController = vc.rexpaySDK?.coordinator?.navigationController?.topViewController
        let isTopVC = topViewController?.isKind(of: PaymentController.classForCoder()) ?? false
        XCTAssertTrue(isTopVC)
    }
    
    func test_should_launch_sdk_from_swiftui_project() {
        //Given
        let config = RexpaySDKConfig(
            reference: "sman024",
            amount: 210,
            userId: "awoyeyetimilehin@gmail.com",
            email: "awoyeyetimilehin@gmail.com",
            customerName: "Victor Musa",
            username: "talk2phasahsyyahoocom",
            password: "f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85",
            rexpayPublicKeyPath: "",
            publicKeyPath: "",
            privateKeyPath: "",
            delegate: self)
        let rexpaySDK = RexpaySDK(config: config)
        _ = SwitUIClientView(rexpaySDK: rexpaySDK)
        
        //Assert
        let topViewController = rexpaySDK.coordinator?.navigationController?.topViewController
        let isTopVC = topViewController?.isKind(of: PaymentController.classForCoder()) ?? false
        XCTAssertTrue(isTopVC)
    }
}

class ClientUIKitVC: UIViewController {
    var rexpaySDK: RexpaySDK?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startSDK() {
        let config = RexpaySDKConfig(
            reference: "sman024",
            amount: 210,
            userId: "awoyeyetimilehin@gmail.com",
            email: "awoyeyetimilehin@gmail.com",
            customerName: "Victor Musa",
            username: "talk2phasahsyyahoocom",
            password: "f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85",
            rexpayPublicKeyPath: "",
            publicKeyPath: "",
            privateKeyPath: "",
            delegate: self)
        
        config.passphrase = "pgptool77@@"

        rexpaySDK = RexpaySDK(config: config)
        rexpaySDK?.launch(presentingViewController: self)
    }
    
    func makeConfig() -> RexpaySDKConfig {
        let config = RexpaySDKConfig(
            reference: "sman024",
            amount: 210,
            userId: "awoyeyetimilehin@gmail.com",
            email: "awoyeyetimilehin@gmail.com",
            customerName: "Victor Musa",
            username: "talk2phasahsyyahoocom",
            password: "f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85",
            rexpayPublicKeyPath: "",
            publicKeyPath: "",
            privateKeyPath: "",
            delegate: self)
        
        config.passphrase = "pgptool77@@"
        return config
    }
    
    
}

extension ClientUIKitVC: RexpaySDKResponseDelegate {
    func didRecieveMessage(message: String) {
        print("callback mesages => \(message)")
    }
}

struct SwitUIClientView: View {
    let rexpaySDK: RexpaySDK
    init(rexpaySDK: RexpaySDK) {
        self.rexpaySDK = rexpaySDK
    }
    @State var isRexpaySDKPresented = false
    var body: some View {
        
        
            Text("Swifui Project")
//        Button("Lauch RexpaySDK") {
//            isRexpaySDKPresented = true
//        }
            
            .onAppear {
                print("asdfdfdfd")
            }
            
        
    }
    func makeRexpaySDK () -> some View {
        print("asdf")
        //When
//        let config = RexpaySDKConfig()
//        config.email = "abc@swiftui.com"
//        config.amount = 500
        
        //let rexpaySDK = RexpaySDK(config: config)
        return rexpaySDK.launch(hostView: self)
            .edgesIgnoringSafeArea(.all)
    }
}

extension LaunchingRexpaySDKTest: RexpaySDKResponseDelegate {
    func didRecieveMessage(message: String) {
        print("callback mesages => \(message)")
    }
}
