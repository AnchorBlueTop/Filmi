//
//  DateFormatterUtil.swift
//  Filmi
//
//  Created by Harshil Patel on 8/11/23.
//

import Foundation

// Used for formatting the release date. Distinct file for possible reusability.
struct DateFormatterUtil {
   
    // Converts date String to full date format.
    static func formattedDateFromString(dateString: String, withFormat format: String = "YYYY-MM-DD") -> String? {
        
        // Parsing input string into DateFormatter
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format
        
        // Converting input string to Date.
        if let date = inputFormatter.date(from: dateString) {
            
            // Format the Outputted dateString object.
            let outputFormatter = DateFormatter()
            
            // daySuffix method is called to get the correct suffix for the day of month.
            // Weekday -> EEEE, d -> Day of Month, MMMM -> Month, YYYY -> Year
            outputFormatter.dateFormat = "EEEE d'\(daySuffix(from: date))' MMMM YYYY"
            return outputFormatter.string(from: date)
        }
        
        // Otherwise if conversation fails, return nil.
        return nil
    }
    
    // Adding cases for day of the month.
    static func daySuffix(from date: Date) -> String {
        
        // Get the current user's calendar.
        let calendar = Calendar.current
        
        // Extract day component from the date.
        let dayOfMonth = calendar.component(.day, from: date)
        
        // Determine correct suffix.
        switch dayOfMonth {
        case 1, 21, 31: return "st" // 1st, 21st, 31st
        case 2, 22: return "nd"     // 2nd, 22nd
        case 3, 23: return "rd"     // 3rd, 23rd
        default: return "th"        // 4th, 5th, etc.
        }
    }
    
}
