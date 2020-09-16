//
//  LoginResponse.swift
//  vForum
//
//  Created by Phúc Lý on 9/16/20.
//  Copyright © 2020 trucdongtxtv. All rights reserved.
//

import Foundation

struct LoginResult: Codable {
    var userId: String?
    var accessToken: String?
    var refreshToken: String?
}

struct LoginResponse: Codable {
    var success: Bool?
    var result: LoginResult?
    var message: String?
    var code: Int?
    var options: String?
    var error: String?
}
