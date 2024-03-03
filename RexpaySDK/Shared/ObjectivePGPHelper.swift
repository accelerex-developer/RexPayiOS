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
            
            let data = try? JSONSerialization.data(withJSONObject: params, options: [])
            
            let publicKeyData = try Data(contentsOf: URL(fileURLWithPath: config!.rexpayPublicKeyPath))

            
            let keys = try ObjectivePGP.readKeys(from: publicKeyData)
            print("keys is \(keys)")
            
            let encryptedData = try ObjectivePGP.encrypt(data!, addSignature: addSignature, using: keys, passphraseForKey: passphraseForKey)
            
            let encryptedDataString = Armor.armored(encryptedData, as: .message)
            let isArmoredData = Armor.isArmoredData(encryptedData)
            
            print("encrypt encryptedDataString is \(encryptedDataString)")
            print("isArmoredData  is \(isArmoredData)")
            
            return encryptedDataString
        }
        catch {
            print("encrypt => \(error.localizedDescription)")
            return error.localizedDescription
        }
    }

    func decrypt<T: Codable>(encryptedStringResponse: String, andVerifySignature: Bool, passphraseForKey: ((Key?) -> String?)? = nil, withPassphrase: String? = nil, type: T.Type) async throws -> T? {
        do {
          
            let encryptedData = encryptedStringResponse.data(using: .utf8)
            
            let isArmoredData = Armor.isArmoredData(encryptedData!)
            
            print("decrypt isArmoredData is \(isArmoredData)")
            print("clientPrivateKey is \(config?.clientPrivateKeyPath)")
            
            let privateKeyData = try Data(contentsOf: URL(fileURLWithPath: config!.clientPrivateKeyPath))
            
            var key = try ObjectivePGP.readKeys(from: privateKeyData).first
            
            print("keys.first?.secretKey?.isEncryptedWithPassword is \(key?.secretKey?.isEncryptedWithPassword)")
            
            if let isEncryptedWithPassword = key?.secretKey?.isEncryptedWithPassword, isEncryptedWithPassword {
                if let withPassphrase = withPassphrase {
                    key = try key?.decrypted(withPassphrase: withPassphrase)
                }
            }
            
            print("decrypt encryptedData is \(encryptedData)")
            
            let decryptedData = try ObjectivePGP.decrypt(encryptedData!, andVerifySignature: andVerifySignature, using: [key!], passphraseForKey: passphraseForKey)
            
            
            let encryptedDataString = Armor.armored(encryptedData!, as: .message)
            print("decrypt encryptedDataString is \(encryptedDataString)")
            
            let res = String(data: decryptedData, encoding: .utf8)
            
            print("decrypted string \(res)")
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: decryptedData)
            
            return decodedResponse
        }
        catch {
            print("decrypt ObjectivePGPHelper decrpt error => \(error.localizedDescription)")
            return nil
        }
    }
    
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
}
