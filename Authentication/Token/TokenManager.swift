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
    
    func updateAccessTokenIntoLocal(accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
    }
    func updateRefreshTokenIntoLocal(refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
    }
}
