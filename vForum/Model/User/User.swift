//
//  User.swift
//  vForum
//
//  Created by Phúc Lý on 9/11/20.
//  Copyright © 2020 trucdongtxtv. All rights reserved.
//

import Foundation

struct User: Codable {
    var _id: String?
    var statusCode: String?
    var createdAt: Date?
    var updatedAt: Date?
    var email: String?
    var password: String?
    var display_name: String?
    var gender: String?
    var role: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "statuscode"
    }
}
