//
//  Nationalities.swift
//  Yabraa
//
//  Created by Hamada Ragab on 17/04/2023.
//

import Foundation
struct Nationalities : Codable {
    let nationalities : [NationalitiesData]?
    enum CodingKeys: String, CodingKey {

        case nationalities = "nationalities"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nationalities = try values.decodeIfPresent([NationalitiesData].self, forKey: .nationalities)
    }

}
