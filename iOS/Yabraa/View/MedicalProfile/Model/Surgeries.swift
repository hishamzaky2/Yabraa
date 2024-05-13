//
//  Surgeries.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
struct Surgeries : Codable {
    let surgeryId : Int?
    let titleAR : String?
    let titleEN : String?

    enum CodingKeys: String, CodingKey {

        case surgeryId = "surgeryId"
        case titleAR = "titleAR"
        case titleEN = "titleEN"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        surgeryId = try values.decodeIfPresent(Int.self, forKey: .surgeryId)
        titleAR = try values.decodeIfPresent(String.self, forKey: .titleAR)
        titleEN = try values.decodeIfPresent(String.self, forKey: .titleEN)
    }

}
