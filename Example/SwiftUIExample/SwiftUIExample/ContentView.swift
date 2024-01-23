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
            Button("Lauch RexpaySDK") {
                isRexpaySDKPresented = true
            }
            .fullScreenCover(isPresented: $isRexpaySDKPresented) {
                makeRexpaySDK()
            }
        }
        .padding()
    }
    
    func makeRexpaySDK () -> some View {
        let config = RexpaySDKConfig()
        config.email = "abc@swiftui.com"
        config.amount = 500
        
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
