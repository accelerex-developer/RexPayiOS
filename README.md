# ``RexpaySDK``

The RexpaySDK simplifies payment integration for developers and businesses, offering a flexible and secure solution for seamless transactions and support for diverse payment 
methods.

<p>
    <img src="https://github.com/accelerex-developer/RexPayiOS/blob/main/RexpaySDK/ReadmeFiles/landing_page.png" width="200px" height="auto" hspace="20"/>

</p>

## :rocket: Installation
More information will be out soon on this.


## :heavy_dollar_sign: Initializing the SDK

**To initialise the SDK in a SwiftUI project, check the code below.**

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
            rexpayPublicKeyPath: "path to Rexpay public key",
            publicKeyPath: "path to client public key",
            privateKeyPath: "path to client private key",
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

**To initialise the SDK in a UIKit project, check the code below.**

```
import UIKit
import RexpaySDK

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickMe(_ sender: UIButton) {
        let config = RexpaySDKConfig(
            reference: "sman024",
            amount: 210,
            userId: "awoyeyetimilehin@gmail.com",
            email: "awoyeyetimilehin@gmail.com",
            customerName: "Victor Musa",
            username: "talk2phasahsyyahoocom",
            password: "f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85",
            rexpayPublicKeyPath: "path to Rexpay public key",
            publicKeyPath: "path to client public key",
            privateKeyPath: "path to client private key",
            delegate: self)
        
        config.passphrase = "pgptool77@@"

        let rexpaySDK = RexpaySDK(config: config)
        rexpaySDK.launch(presentingViewController: self)
    }
}

extension ViewController: RexpaySDKResponseDelegate {
    func didRecieveMessage(message: String) {
        print("callback mesages => \(message)")
    }
}
```
## Description on some vital optional properties

- `passphrase:` This should be provided if used when you're generating your pgp key pair.
- `selctedChannels:` This will show all the available channels by default. Feel free to make any modifications as needed.
- `delegate:` This serves as the communication channel between the SDK and the class (i.e UIViewController or View) that initiates the SDK.
- `rexpayEnv:` The SDK offers two environments: production and sandbox, with the default being set to sandbox..
 

