//
//  ChronicDiseases.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
struct ChronicDiseases : Codable {
    let chronicDiseaseId : Int?
    let titleAR : String?
    let titleEN : String?

    enum CodingKeys: String, CodingKey {

        case chronicDiseaseId = "chronicDiseaseId"
        case titleAR = "titleAR"
        case titleEN = "titleEN"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chronicDiseaseId = try values.decodeIfPresent(Int.self, forKey: .chronicDiseaseId)
        titleAR = try values.decodeIfPresent(String.self, forKey: .titleAR)
        titleEN = try values.decodeIfPresent(String.self, forKey: .titleEN)
    }

}
