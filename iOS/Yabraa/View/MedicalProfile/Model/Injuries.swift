//
//  injuries.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
struct Injuries : Codable {
    let injuryId : Int?
    let titleAR : String?
    let titleEN : String?

    enum CodingKeys: String, CodingKey {

        case injuryId = "injuryId"
        case titleAR = "titleAR"
        case titleEN = "titleEN"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        injuryId = try values.decodeIfPresent(Int.self, forKey: .injuryId)
        titleAR = try values.decodeIfPresent(String.self, forKey: .titleAR)
        titleEN = try values.decodeIfPresent(String.self, forKey: .titleEN)
    }

}
