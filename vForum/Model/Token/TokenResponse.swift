//
//  TokenResponse.swift
//  vForum
//
//  Created by Phúc Lý on 9/11/20.
//  Copyright © 2020 trucdongtxtv. All rights reserved.
//

import Foundation

struct TokenResponse: Codable {
    var statusCode: String?
    var error: String?
    var message: String?
    var data: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
    }
}
