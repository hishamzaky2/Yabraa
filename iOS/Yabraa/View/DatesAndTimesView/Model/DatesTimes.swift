//
//  DatesTimes.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import Foundation
struct DatesTimes : Codable {
    let year : Int?
    let monthName : String?
    let monthNumber : String?
    let monthShortName : String?
    let dayName : String?
    let dayOfMonth : String?

    enum CodingKeys: String, CodingKey {

        case year = "year"
        case monthName = "monthName"
        case monthNumber = "monthNumber"
        case monthShortName = "monthShortName"
        case dayName = "dayName"
        case dayOfMonth = "dayOfMonth"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
        monthName = try values.decodeIfPresent(String.self, forKey: .monthName)
        monthNumber = try values.decodeIfPresent(String.self, forKey: .monthNumber)
        monthShortName = try values.decodeIfPresent(String.self, forKey: .monthShortName)
        dayName = try values.decodeIfPresent(String.self, forKey: .dayName)
        dayOfMonth = try values.decodeIfPresent(String.self, forKey: .dayOfMonth)
    }

}
