//
//  Allergy.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
struct Allergies : Codable {
    let allergyId : Int?
    let titleAR : String?
    let titleEN : String?

    enum CodingKeys: String, CodingKey {

        case allergyId = "allergyId"
        case titleAR = "titleAR"
        case titleEN = "titleEN"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        allergyId = try values.decodeIfPresent(Int.self, forKey: .allergyId)
        titleAR = try values.decodeIfPresent(String.self, forKey: .titleAR)
        titleEN = try values.decodeIfPresent(String.self, forKey: .titleEN)
    }

}
