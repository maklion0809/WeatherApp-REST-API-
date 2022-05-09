//
//  ConvertDate.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 04.11.2021.
//

import Foundation

class DateConverter {
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        
        return dateFormatter
    }()
    
    func dayOfWeek(dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString) ?? Date()
        guard !Calendar.current.isDateInToday(date) else  { return "Today" }
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: date)
    }
}
