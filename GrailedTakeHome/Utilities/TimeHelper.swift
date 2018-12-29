//
//  TimeHelper.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//

import UIKit
import PromiseKit

public class TimeHelper: NSObject {

    public class func dateStringFor(date: Date) -> String {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.string(from: date)
    }

    public class func timeIntervalFor(timeString: String) -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormatter.date(from: timeString) {
            return date.timeIntervalSince1970 * 1000
        }
        return 0.0
    }

    public class func stringFromTimeInterval(interval: TimeInterval) -> String {
        let timeInterval = NSInteger(interval * 1000)

        let milliseconds = Int((timeInterval % 1) * 1000)

        let seconds = timeInterval % 60
        let minutes = (timeInterval / 60) % 60
        let hours = (timeInterval / 3600)

        return String(NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d", hours, minutes, seconds, milliseconds))
    }

    // Assuming format "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    public class func timeSinceStringFor(timeString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormatter.date(from: timeString) {
            let components = Calendar.current.dateComponents([.year, .day, .hour, .minute, .second], from: date, to: Date())
            if let year = components.year, let day = components.day, let hour = components.hour, let minute = components.minute, let second = components.second {
                if year > 0 {
                    return "\(year)y"
                }
                if day > 0 {
                    return "\(day)d"
                }
                if hour > 0 {
                    return "\(hour)h"
                }
                if minute > 0 {
                    return "\(minute)m"
                }
                if second > 0 {
                    return "\(second)s"
                }
            }
        }
        return "now"
    }

    public class func timeSinceString(timeString: String) -> Promise<String> {
        return Promise { fulfill, _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

            if let date = dateFormatter.date(from: timeString) {
                let components = Calendar.current.dateComponents([.year, .day, .hour, .minute, .second], from: date, to: Date())
                if let year = components.year, let day = components.day, let hour = components.hour, let minute = components.minute, let second = components.second {
                    if year > 0 {
                        fulfill("\(year)y")
                        return
                    }
                    if day > 0 {
                        fulfill("\(day)d")
                        return
                    }
                    if hour > 0 {
                        fulfill("\(hour)h")
                        return
                    }
                    if minute > 0 {
                        fulfill("\(minute)m")
                        return
                    }
                    if second > 0 {
                        fulfill("\(second)s")
                        return
                    }
                }
            }
            fulfill("now")
        }
    }

    public class func displayTimeFor(timeString: String, longForm: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormatter.date(from: timeString) {

            // Show month/day/year if from a different month
            if Calendar.current.component(.month, from: date) != Calendar.current.component(.month, from: Date()) {
                let currentYear = Calendar.current.component(.year, from: date)
                let currentMonth = Calendar.current.component(.month, from: date)
                let currentDay = Calendar.current.component(.day, from: date)

                if longForm {
                    return "\(DateFormatter().shortMonthSymbols[currentMonth - 1]) \(currentDay), \(String(currentYear.description.suffix(2)))"
                } else {
                    return "\(currentMonth)/\(currentDay)/\(String(currentYear.description.suffix(2)))"
                }
            }

            // Show month/day if from a different day
            if Calendar.current.component(.day, from: date) != Calendar.current.component(.day, from: Date()) {
                let currentMonth = Calendar.current.component(.month, from: date)
                let currentDay = Calendar.current.component(.day, from: date)

                if longForm {
                    return "\(DateFormatter().shortMonthSymbols[currentMonth - 1]) \(currentDay) at \(clockTimeFor(date: date))"
                } else {
                    return "\(DateFormatter().shortMonthSymbols[currentMonth - 1]) \(currentDay)"
                }
            }

            return clockTimeFor(date: date, longForm: longForm)
        }
        return "now"
    }

    class func clockTimeFor(date: Date, longForm: Bool = false) -> String {
        // Show time if same day
        let currentHour = Calendar.current.component(.hour, from: date)
        let currentMinute = Calendar.current.component(.minute, from: date)

        var minuteString = "\(currentMinute.description)"
        if currentMinute < 10 { minuteString = "0" + minuteString }

        var base12Hour = currentHour - ((currentHour / 12) > 0 ? 12 : 0)
        if base12Hour == 0 { base12Hour = 12 }

        if currentHour / 12 > 0 { // PM
            if longForm {
                return "Today at \(base12Hour):\(minuteString)pm"
            } else {
                return "\(base12Hour):\(minuteString)pm"
            }
        } else {
            if longForm {
                return "Today at \(base12Hour):\(minuteString)am"
            } else {
                return "\(base12Hour):\(minuteString)am"
            }
        }
    }
}
