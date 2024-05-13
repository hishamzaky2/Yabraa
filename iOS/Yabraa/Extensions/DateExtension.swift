//
//  DateExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 17/04/2023.
//

import Foundation
extension Date {
    func fromDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
}
