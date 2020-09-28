//
//  GroupResponds.swift
//  vForum
//
//  Created by vinova on 28/09/2020.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
struct Group: Decodable {
    let id: String?
    let createdAt: String?
    let createdBy: String?
    let name: String?
    enum codingKey: String, CodingKey {
        case id = "_id"
        case createdAt
        case createdBy
        case name
    }
}
