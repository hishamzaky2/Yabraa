//
//  Gallery.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/05/2023.
//

import Foundation
struct Gallery : Codable {
    let galleryImages : [String]?

    enum CodingKeys: String, CodingKey {

        case galleryImages = "galleryImages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        galleryImages = try values.decodeIfPresent([String].self, forKey: .galleryImages)
    }

}
