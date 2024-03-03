//
//  ObjectivePGPHelper.swift
//  RexpaySDK
//
//  Created by Abdullah on 28/01/2024.
//


import ObjectivePGP

final class ObjectivePGPHelper {
    
    static let shared: ObjectivePGPHelper = ObjectivePGPHelper()
    
    var config: RexpaySDKConfig?
    
    private init() {}
    
    func encrypt(params: [String: Any], addSignature: Bool, passphraseForKey: ((Key) -> String?)? = nil) async throws -> String? {
        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: params, requiringSecureCoding: false)

            let data = try? JSONSerialization.data(withJSONObject: params, options: [])
            
            print("loko is \(data)")
            
//            let publicKeyData = try Data(contentsOf: URL(fileURLWithPath: getRexpayPublicKeyPath()!))
            
            let publicKeyData = try Data(contentsOf: URL(fileURLWithPath: config!.rexpayPublicKeyPath))

            
            let keys = try ObjectivePGP.readKeys(from: publicKeyData)
            print("keys is \(keys)")
            
            
            let encryptedData = try ObjectivePGP.encrypt(data!, addSignature: addSignature, using: keys, passphraseForKey: passphraseForKey)
            
            let encryptedDataString = Armor.armored(encryptedData, as: .message)
            let dddd = Armor.isArmoredData(encryptedData)
            print("encrypt2 encryptedDataString is \(encryptedDataString)")
            print("dddd  is \(dddd)")
            
//            let signature = try ObjectivePGP.sign(encryptedData, detached:false, using: [keys.first!])
//
//            try ObjectivePGP.verify(encryptedData, withSignature: signature, using: [keys.first!])
            
//            let encryptedData2 = try ObjectivePGP.sign(encryptedData, detached: true, using: [keys.first!])
            
        
            return encryptedDataString
        }
        catch {
            print("encrypt2 => \(error.localizedDescription)")
            return error.localizedDescription
        }
    }

    func decrypt<T: Codable>(encryptedStringResponse: String, andVerifySignature: Bool, passphraseForKey: ((Key?) -> String?)? = nil, withPassphrase: String? = nil, type: T.Type) async throws -> T? {
        do {
          
            let encryptedData = encryptedStringResponse.data(using: .utf8)
            
            let isArmoredData = Armor.isArmoredData(encryptedData!)
            print("decrypt2 isArmoredData is \(isArmoredData)")
            
            print("clientPrivateKey is \(config?.clientPrivateKeyPath)")
//            let privateKeyData = try Data(contentsOf: URL(fileURLWithPath: clientPrivateKey!))
            
            let privateKeyData = try Data(contentsOf: URL(fileURLWithPath: config!.clientPrivateKeyPath))
            
            var key = try ObjectivePGP.readKeys(from: privateKeyData).first
            //var decryptedKey: Key?
            
            print("keys.first?.secretKey?.isEncryptedWithPassword is \(key?.secretKey?.isEncryptedWithPassword)")
            
            if let isEncryptedWithPassword = key?.secretKey?.isEncryptedWithPassword, isEncryptedWithPassword {
                if let withPassphrase = withPassphrase {
                    key = try key?.decrypted(withPassphrase: withPassphrase)
                }
            }
            //pgptool77@@
            
            print("decrypt2 encryptedData is \(encryptedData)")
            
    
            
            let decryptedData = try ObjectivePGP.decrypt(encryptedData!, andVerifySignature: andVerifySignature, using: [key!], passphraseForKey: passphraseForKey)
            
            
            let encryptedDataString = Armor.armored(encryptedData!, as: .message)
            print("decrypt2 encryptedDataString is \(encryptedDataString)")
            
            let res = String(data: decryptedData, encoding: .utf8)
            
            print("decrypted string \(res)")
            
            var decodedResponse = try? JSONDecoder().decode(T.self, from: decryptedData)
            
            return decodedResponse
        }
        catch {
            print("decrypt2 ObjectivePGPHelper decrpt error => \(error.localizedDescription)")
            return nil
        }
    }
    
//    static func getRexpayPublicKeyPath() -> String? {
//        let bundle = Bundle(for: ObjectivePGPHelper.self)
//        let path =  bundle.path(forResource: "Rexpay-PublicKey", ofType: "asc")
//        print("getRexpayPublicKeyPath is \(path)")
//        return path
//    }
    
    func getRexpayPublicKeyPath() -> String? {
       let bundle = Bundle(for: ObjectivePGPHelper.self)
       if let publicKeyPath = bundle.path(forResource: "Rexpay-PublicKey", ofType: "asc") {
           print("publicKeyPath is \(publicKeyPath)")
           // Check if the file exists before returning the path
           if FileManager.default.fileExists(atPath: publicKeyPath) {
               print("Public Key file exist.")
               return publicKeyPath
           } else {
               print("Public Key file does not exist.")
           }
       } else {
           print("Public Key file not found in the bundle.")
       }
       return nil
    }
    
//    var clientPublicKey: String? {
//        let bundle = Bundle(for: ObjectivePGPHelper.self)
//        if let publicKeyPath = bundle.path(forResource: "Client-pub", ofType: "asc") {
//            // Check if the file exists before returning the path
//            if FileManager.default.fileExists(atPath: publicKeyPath) {
//                print("Client public Key file exist.")
//                let publicKeyData = try? Data(contentsOf: URL(fileURLWithPath: publicKeyPath))
//
//                let keys = try? ObjectivePGP.readKeys(from: publicKeyData!).first?.export()
//                let armoredKey = Armor.armored(keys!, as: .publicKey) // This is used to get the PGP format in string
//                print("armoredKey is \(armoredKey)")
//
//                return armoredKey
//            } else {
//                print("ClientPublic Key file does not exist.")
//            }
//        } else {
//            print("Client Public Key file not found in the bundle.")
//        }
//        return nil
//    }
    
    var clientPublicKey: String? {
        do {
            guard let clientPublicKeyPath = config?.clientPublicKeyPath else {
                print("ClientPublic Key file does not exist.")
                return nil
            }
            if FileManager.default.fileExists(atPath: clientPublicKeyPath) {
                print("Client public Key file exist.")
                let clientPublicKeyData = try Data(contentsOf: URL(fileURLWithPath: clientPublicKeyPath))
                
                let keys = try? ObjectivePGP.readKeys(from: clientPublicKeyData).first?.export()
                let armoredKey = Armor.armored(keys!, as: .publicKey) // This is used to get the PGP format in string
                print("armoredKey is \(armoredKey)")
                
                return armoredKey
            } else {
                print("ClientPublic Key file does not exist.")
            }
        }
        catch {
            print("RexpaySDK error => \(error.localizedDescription)")
        }
        return nil
    }
    
    var clientPrivateKey: String? {
        let bundle = Bundle(for: ObjectivePGPHelper.self)
        if let privateKeyPath = bundle.path(forResource: "Client-sec", ofType: "asc") {
            // Check if the file exists before returning the path
            if FileManager.default.fileExists(atPath: privateKeyPath) {
                print("Client private Key file exist.")
                let privateeyDataa = try? Data(contentsOf: URL(fileURLWithPath: privateKeyPath))
                
                let keys = try? ObjectivePGP.readKeys(from: privateeyDataa!).first?.export()
                
                let armoredKey = Armor.armored(keys!, as: .message) // This is used to get the PGP format in string
                print(" Client armoredKey is \(armoredKey)")
                let armoredKey2 = Armor.armored(keys!, as: .secretKey)
                
                print(" Client armoredKey2 is \(armoredKey2)")
                
                
                return privateKeyPath
            } else {
                print("Client private Key file does not exist.")
            }
        } else {
            print("Client private Key file not found in the bundle.")
        }
        return nil
    }
}
