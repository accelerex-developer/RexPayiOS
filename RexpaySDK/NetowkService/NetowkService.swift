//
//  NetowkService.swift
//  RexpaySDK
//
//  Created by Abdullah on 24/01/2024.
//

import Foundation

protocol NetowkServiceDelegate: AnyObject {
    func execute<T: Codable>(urlString: String, method: String, type: T.Type, bodyPayload: [String: Any?]?) async throws -> Result<T?, ErrorReponse>
    
    func executeCall<T: Codable>(urlString: String, method: String, type: T.Type, bodyPayload: [String: Any?]?) async throws -> Result<T?, ErrorReponseTwo>
    
    func execute(urlString: String, method: String, bodyPayload: [String: Any?]?) async throws -> Result<ResponseWithNoBody, ErrorReponse>
}

final class NetowkService: NetowkServiceDelegate {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    fileprivate func handleError(_ errorResponse: inout ErrorReponse?, _ data: Data) {
        if errorResponse?.message == nil || errorResponse?.error == nil {
            let errorReponseTwo = try? JSONDecoder().decode(ErrorReponseTwo.self, from: data)
            errorResponse?.message = errorReponseTwo?.responseMessage
            errorResponse?.error = errorReponseTwo?.responseStatus
            if let responseCode =  errorReponseTwo?.responseCode,
               let responseCodeInt = Int(responseCode) {
                errorResponse?.status = responseCodeInt
            }
        }
    }
    
    func execute<T: Codable>(urlString: String, method: String, type: T.Type, bodyPayload: [String: Any?]? = nil) async throws -> Result<T?, ErrorReponse> where T : Decodable, T : Encodable {
        do {
            print("full url => \(urlString)")
            var urlRequest = URLRequest(url: URL(string: urlString)!)
            urlRequest.httpMethod = method
            if bodyPayload != nil && bodyPayload?.isNotEmpty ?? false {
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
                let res = String(data: data, encoding: .utf8) // For debugging
                print("debugging res => \(res)")
                decodedResponse = try? JSONDecoder().decode(T.self, from: data)
                if decodedResponse == nil {
                    var errorResponse = try? JSONDecoder().decode(ErrorReponse.self, from: data)
                    handleError(&errorResponse, data)
                    return .failure(errorResponse ?? ErrorReponse(message: "Unknow error occured"))
                }
                
            } else {
                // Handle other status codes
                let res = String(data: data, encoding: .utf8)
                print("string res is \(res)")
                var errorResponse = try? JSONDecoder().decode(ErrorReponse.self, from: data)
                print("lala is \(errorResponse)")
                handleError(&errorResponse, data)
                
                print("ErrorReponse is  \(errorResponse)")
                return .failure(errorResponse ?? ErrorReponse(message: "Unknow error occured"))
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
    
    func executeCall<T: Codable>(urlString: String, method: String, type: T.Type, bodyPayload: [String: Any?]? = nil) async throws -> Result<T?, ErrorReponseTwo> where T : Decodable, T : Encodable {
        do {
            var urlRequest = URLRequest(url: URL(string: urlString)!)
            urlRequest.httpMethod = method
            if bodyPayload != nil && bodyPayload?.isNotEmpty ?? false {
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
                    let errorResponse = try JSONDecoder().decode(ErrorReponseTwo.self, from: data)
                    return .failure(errorResponse)
                }
                
            } else {
                // Handle other status codes
                let res = String(data: data, encoding: .utf8)
                print("string res is \(res)")
                let errorResponse = try JSONDecoder().decode(ErrorReponseTwo.self, from: data)
                print("ErrorReponseTwo is  \(errorResponse)")
                return .failure(errorResponse)
            }
            
            //return decodedResponse!
            return .success(decodedResponse)
        }
        catch {
            print("network service error is \(error.localizedDescription)")
            //throw error
            let errorResponse = ErrorReponseTwo(responseMessage: error.localizedDescription)
            return .failure(errorResponse)
        }
    }
    
    func execute(urlString: String, method: String, bodyPayload: [String: Any?]?) async throws -> Result<ResponseWithNoBody, ErrorReponse> {
        do {
            var urlRequest = URLRequest(url: URL(string: urlString)!)
            urlRequest.httpMethod = method
            if bodyPayload != nil && bodyPayload?.isNotEmpty ?? false {
                let bodyData = try? JSONSerialization.data(withJSONObject: bodyPayload as Any, options: [])
                urlRequest.httpBody = bodyData
            }
            
            let authData = "talk2phasahsyyahoocom:f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85".data(using: .utf8)!.base64EncodedString()
            urlRequest.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            // Check the status code
            let statusCode = httpResponse.statusCode
            print("statusCode is \(statusCode)")
            
            let allowedStatusCode = 200...299
            if allowedStatusCode.contains(statusCode) {
                // Successful response
                return .success(ResponseWithNoBody())
                
            } else {
                // Handle other status codes
                let errorResponse = try JSONDecoder().decode(ErrorReponse.self, from: data)
                print("ErrorReponse is  \(errorResponse)")
                return .failure(errorResponse)
            }
        }
        catch {
            print("network2 service error is \(error.localizedDescription)")
            //throw error
            let errorResponse = ErrorReponse(message: error.localizedDescription)
            return .failure(errorResponse)
        }
    }
}
