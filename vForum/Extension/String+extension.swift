//
//  String+extension.swift
//  vForum
//
//  Created by Phúc Lý on 9/30/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation

extension String {
    func isEmpyOrSpacing() -> Bool {
        if self.isEmpty {
            return true
        }
        for e in self {
            if e != " " {
                return false
            }
        }
        return true
    }
    
    func toDate() -> Date? {
        let df = DateFormatter()
        df.dateFormat = "d/M/yy hh:mm"
        let date = df.date(from: self)
        return date
    }
}
