//
//  RegisterResponse.swift
//  vForum
//
//  Created by Phúc Lý on 9/16/20.
//  Copyright © 2020 trucdongtxtv. All rights reserved.
//

import Foundation

struct RegisterResult: Codable {
    var _id: String?
    var createdAt: Date?
    var display_name: String?
}

struct RegisterResponse: Codable {
    var success: Bool?
    var result: RegisterResult?
    var message: String?
    var code: Int8?
    var options: String?
    var error: String?
}
