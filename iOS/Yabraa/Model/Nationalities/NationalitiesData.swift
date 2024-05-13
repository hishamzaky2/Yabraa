//
//  NationalitiesData.swift
//  Yabraa
//
//  Created by Hamada Ragab on 17/04/2023.
//

import Foundation
struct NationalitiesData : Codable {
    let countryCode : String?
    let countryEnNationality : String?
    let countryArNationality : String?

    enum CodingKeys: String, CodingKey {

        case countryCode = "countryCode"
        case countryEnNationality = "countryEnNationality"
        case countryArNationality = "countryArNationality"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        countryEnNationality = try values.decodeIfPresent(String.self, forKey: .countryEnNationality)
        countryArNationality = try values.decodeIfPresent(String.self, forKey: .countryArNationality)
    }

}
