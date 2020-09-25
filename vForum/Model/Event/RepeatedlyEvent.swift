//
//  RepeatedlyEvent.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
enum RepeatedlyEvent: Decodable {
    init(from decoder: Decoder) throws {
        try self.init(from: decoder)
    }
    
    case hourly
    case daily
    case weekly
    case monthly
    case _3months
    case _6months
    case yearly
    
    func toString() -> String{
        switch self {
        case .hourly:
            return "Hourly"
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        case ._3months:
            return "3 Months"
        case ._6months:
            return "6 Months"
        default:
            return "Yearly"
        }
    }
}
