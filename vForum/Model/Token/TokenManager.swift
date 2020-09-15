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
    
    func getAccessTokenFromLocal() -> String? {
        let accessToken = UserDefaults.standard.object(forKey: "accessToken") as? String
        return accessToken
    }
    func getRefreshTokenFromLocal() -> String? {
        let refreshToken = UserDefaults.standard.object(forKey: "refreshToken") as? String
        return refreshToken
    }
    
    func updateAccessTokenIntoLocal(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    func updateRefreshTokenIntoLocal(token: String) {
        UserDefaults.standard.set(token, forKey: "refreshToken")
    }
}
