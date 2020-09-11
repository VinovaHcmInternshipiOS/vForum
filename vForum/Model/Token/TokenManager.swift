//
//  TokenManager.swift
//  vForum
//
//  Created by Phúc Lý on 9/11/20.
//  Copyright © 2020 trucdongtxtv. All rights reserved.
//

import Foundation
import Alamofire

class TokenManager {
    static var shared = TokenManager()
    
    func getTokenFromLocal() -> String? {
        let token = UserDefaults.standard.object(forKey: "token") as? String
        return token
    }
    
    func isValidToken(url: String, token: String) -> Bool {
        
        let rawUrl = URL(string: url)
        
        // Un-wrap
        guard let url = rawUrl else {
            return false
        }
        
        // Defind semaphore
        let semaphore = DispatchSemaphore(value: 0)
        
        AF.request(url, method: .post, parameters: ["token": token], encoding: JSONEncoding.default, headers: nil).response {
            response in
            // valid token -> true
            
            // Invalid token
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return false
    }
    
    func getTokenFromServer(url: String, user: User) -> String? {
        // Properties
        var token: String?
        let rawUrl = URL(string: url)
        
        // Un-wrap
        guard let url = rawUrl, let email = user.email, let password = user.password else {
            return nil
        }
        
        // Define semaphore
        let semaphore = DispatchSemaphore(value: 0)
        
        // Request
        AF.request(url, method: .post, parameters: ["email": email, "password": password], encoding: JSONEncoding.default, headers: nil).response{
            response in
            // Get data from response of server
            if let data = response.data {
                do {
                    // Decode data to TokenResponse type
                    let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                    
                    token = tokenResponse.data
                    semaphore.signal() // semaphore signal
                } catch {
                    print(error)
                    semaphore.signal() // semaphore signal
                }
            }
            
        }
        
        semaphore.wait() // semaphore wait response of API
        
        return token
    }
    
    func updateTokenIntoLocal(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
}
