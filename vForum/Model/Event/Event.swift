//
//  Event.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation

struct Event: Decodable {
    var _id: Int
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
    var banner: String
    var repeated: RepeatedlyEvent = .hourly
    
    func getDate(from date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
    
    func getHour(from date: Date) -> Int {
        return Calendar.current.component(.hour, from: date)
    }
    
    func getMinute(from date: Date) -> Int {
        return Calendar.current.component(.minute, from: date)
    }
}
