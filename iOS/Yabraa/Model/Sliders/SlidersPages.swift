//
//  SlidersPages.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/04/2023.
// SlidersPages

import Foundation
struct SlidersPages : Codable {
    let id : Int?
    let title : String?
    let subTitle : String?
    let path : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case subTitle = "subTitle"
        case path = "path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        subTitle = try values.decodeIfPresent(String.self, forKey: .subTitle)
        path = try values.decodeIfPresent(String.self, forKey: .path)
    }

}
