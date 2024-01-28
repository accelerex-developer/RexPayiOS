//
//  NetowkService.swift
//  RexpaySDK
//
//  Created by Abdullah on 24/01/2024.
//

import Foundation

protocol NetowkServiceDelegate: AnyObject {
    func execute<T: Codable>(urlString: String, method: String, type: T.Type, bodyPayload: [String: Any?]?) async throws -> Result<T?, ErrorReponse>
}

final class NetowkService: NetowkServiceDelegate {

    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func execute<T: Codable>(urlString: String, method: String, type: T.Type, bodyPayload: [String: Any?]? = nil) async throws -> Result<T?, ErrorReponse> where T : Decodable, T : Encodable {
        do {
            var urlRequest = URLRequest(url: URL(string: urlString)!)
            urlRequest.httpMethod = method
            if bodyPayload != nil {
                let bodyData = try? JSONSerialization.data(withJSONObject: bodyPayload as Any, options: [])
                urlRequest.httpBody = bodyData
            }
            
            let authData = "talk2phasahsyyahoocom:f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85".data(using: .utf8)!.base64EncodedString()
            urlRequest.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            var decodedResponse: T?
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            // Check the status code
            let statusCode = httpResponse.statusCode
            print("statusCode is \(statusCode)")
            
            let allowedStatusCode = 200...299
            if allowedStatusCode.contains(statusCode) {
                // Successful response
                decodedResponse = try JSONDecoder().decode(T.self, from: data)
                if decodedResponse == nil {
                    let errorResponse = try JSONDecoder().decode(ErrorReponse.self, from: data)
                    return .failure(errorResponse)
                }
                
            } else {
                // Handle other status codes
                let errorResponse = try JSONDecoder().decode(ErrorReponse.self, from: data)
                print("ErrorReponse is  \(errorResponse)")
                return .failure(errorResponse)
            }
            
            //return decodedResponse!
            return .success(decodedResponse)
        }
        catch {
            print("network service error is \(error.localizedDescription)")
            //throw error
            let errorResponse = ErrorReponse(message: error.localizedDescription)
            return .failure(errorResponse)
        }
    }
}
