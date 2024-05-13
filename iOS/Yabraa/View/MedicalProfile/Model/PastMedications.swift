//
//  PastMedications.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
struct PastMedications : Codable {
    let medicationId : Int?
    let titleAR : String?
    let titleEN : String?

    enum CodingKeys: String, CodingKey {

        case medicationId = "medicationId"
        case titleAR = "titleAR"
        case titleEN = "titleEN"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        medicationId = try values.decodeIfPresent(Int.self, forKey: .medicationId)
        titleAR = try values.decodeIfPresent(String.self, forKey: .titleAR)
        titleEN = try values.decodeIfPresent(String.self, forKey: .titleEN)
    }

}
