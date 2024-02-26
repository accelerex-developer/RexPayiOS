# ``RexpaySDK``

The RexpaySDK SDK simplifies payment integration for developers and businesses, offering a flexible and secure solution for seamless transactions and support for diverse payment methods.

## Overview


## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->

<p>
    <img src="https://github.com/accelerex-developer/RexPayiOS/blob/main/RexpaySDK/ReadmeFiles/landing_page.png" width="200px" height="auto" hspace="20"/>

</p>

## :rocket: Installation
More information will be out soon on this.


## :heavy_dollar_sign: Making Payments Via Switui project
To make payment, You initialize a charge object with an amount, customer email  & reference.
```
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
        
        let rexpaySDK = RexpaySDK(config: config)
    
        return rexpaySDK.launch(hostView: self)
            .edgesIgnoringSafeArea(.all)
    }
}

extension ContentView: RexpaySDKResponseDelegate {
    func didRecieveMessage(message: String) {
        print("callback mesages => \(message)")
    }
}
```
 
