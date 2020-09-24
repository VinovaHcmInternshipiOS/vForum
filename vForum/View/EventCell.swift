//
//  EventCell.swift
//  vForum
//
//  Created by Phúc Lý on 9/23/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation

struct EventCell: Decodable {
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
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
    var banner: String
    var repeated: RepeatedlyEvent = .hourly
    
    func getDate(from date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getHour(from date: Date) -> Int {
        return Calendar.current.component(.hour, from: date)
    }
    
    func getMinute(from date: Date) -> Int {
        return Calendar.current.component(.minute, from: date)
    }
}
