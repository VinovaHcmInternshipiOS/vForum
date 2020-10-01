//
//  String+extension.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/30/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        var indices: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                indices.append(range.lowerBound)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return indices
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    
    
}
extension String {
    func stringToDate8601() -> Date {
      let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
      dateFormatter.timeZone = TimeZone.current
     dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      if let date8601 = dateFormatter.date(from: self) {
        return date8601
      } else {
        return Date()
      }
    }
}

extension Date {
  func timeAgoDisplay() -> String {
    let calendar = Calendar.current
    let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
    let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
    let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
    if minuteAgo < self {
      var diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
      if diff < 0 {
        diff = 2
      }
        return diff == 1 ? "\(diff) second ago" : "\(diff) seconds ago"
    } else if hourAgo < self {
      let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
        return diff == 1 ? "\(diff) minute ago" : "\(diff) minutes ago"
    } else if dayAgo < self {
      let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
        return diff == 1 ? "\(diff) hour ago" : "\(diff) hours ago"
    } else {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd MMM yyyy"
      let stringDate = dateFormatter.string(from: self.toLocalTime())
      return stringDate
    }
  }
    
    func toLocalTime() -> Date {
      let timezone: TimeZone = TimeZone.autoupdatingCurrent
      let seconds: TimeInterval = TimeInterval(timezone.secondsFromGMT(for: self))
      return Date(timeInterval: seconds, since: self)
    }
    
    public init?(iso8601String: String) {
      // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
      let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd’T’HH:mm:ss.SSSZ"
      if let date = dateFormatter.date(from: iso8601String) {
        self = date
      } else {
        return nil
      }
    }
}
