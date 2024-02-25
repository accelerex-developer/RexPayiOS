//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Abdullah on 21/01/2024.
//

import SwiftUI
import RexpaySDK

struct ContentView: View {
    
    @State var isRexpaySDKPresented = false
    
    var body: some View {
        VStack {
            Text("Swifui Project")
                .padding(.bottom, 20)
            Button("Launch RexpaySDK") {
                isRexpaySDKPresented = true
            }
            .fullScreenCover(isPresented: $isRexpaySDKPresented) {
                makeRexpaySDK()
            }
        }
        .padding()
    }
        
    
    func makeRexpaySDK () -> some View {
//        let config = RexpaySDKConfig()
//        config.username = "talk2phasahsyyahoocom"
//        config.password = "f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85"
//        config.reference = "sman021"
//        config.amount = 200
//        config.currency = "NGN"
//        config.userId =  "awoyeyetimilehin@gmail.com"
//        config.email = "awoyeyetimilehin@gmail.com"
//        config.customerName = "Victor Musa"
//        config.selectedChannels = [.card, .ussd]
//        config.rexpayEnv = .sandbox
//        let rexpaySDK = RexpaySDK(config: config)
        
        let config = RexpaySDKConfig(reference: "sman024", amount: 210, userId: "awoyeyetimilehin@gmail.com", email: "awoyeyetimilehin@gmail.com", customerName: "Victor Musa", username: "talk2phasahsyyahoocom", password: "f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85", rexpayPublicKeyPath: "", publicKeyPath: "", privateKeyPath: "", delegate: self)
        config.passphrase = "pgptool77@@"
        let rexpaySDK = RexpaySDK(config: config)
    
        return rexpaySDK.launch(hostView: self)
            .edgesIgnoringSafeArea(.all)
    }
}

extension ContentView: RexpaySDKResponseDelegate {
    func didRecieveMessage(message: String) {
        print("swiftui => \(message)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
