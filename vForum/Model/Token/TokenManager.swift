//
//  TokenManager.swift
//  vForum
//
//  Created by Phúc Lý on 9/11/20.
//  Copyright © 2020 trucdongtxtv. All rights reserved.
//

import Foundation


class TokenManager {
    static var shared = TokenManager()
    
    func isValidToken(token: String) -> Bool {
        
        return false
    }
    
    func getTokenFromDatabase() -> String {
        
        return ""
    }
    
    func getTokenFromServer() -> String {
        
        return ""
    }
    
    func updateTokenIntoDatabase(token: String) {
        
    }
}
