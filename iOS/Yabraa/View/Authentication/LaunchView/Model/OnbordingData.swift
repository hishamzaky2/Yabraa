//
//  OnbordingData.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/02/2023.
//

import Foundation
struct OnbordingData:Codable {
    let id : Int?
    let titleEn : String?
    let subTitleEn : String?
    let titleAr : String?
    let subTitleAr : String?
    let path : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case titleEn = "titleEn"
        case subTitleEn = "subTitleEn"
        case titleAr = "titleAr"
        case subTitleAr = "subTitleAr"
        case path = "path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        subTitleEn = try values.decodeIfPresent(String.self, forKey: .subTitleEn)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        subTitleAr = try values.decodeIfPresent(String.self, forKey: .subTitleAr)
        path = try values.decodeIfPresent(String.self, forKey: .path)
    }

}
