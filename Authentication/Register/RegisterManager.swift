//
//  RegisterManager.swift
//  vForum
//
//  Created by Phúc Lý on 9/16/20.
//  Copyright © 2020 trucdongtxtv. All rights reserved.
//

import Foundation
import Alamofire

class RegisterManager {
    static var shared = RegisterManager()
    
    func register(url: String, params: [String: Any]) -> Bool {
        var result: Bool = false // Default value is false
        
        let rawUrl = URL(string: url)
        
        guard let url = rawUrl else {
            return result
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response{
            response in
            
            if let data = response.data {
                do {
                    let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
                    
                    if let success = registerResponse.success {
                        result = success
                    }
                    
                    semaphore.signal()
                } catch {
                    print(error)
                    result = false
                    semaphore.signal()
                }
            }

        }
        
        semaphore.wait()
        
        return result
    }
}
