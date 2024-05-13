//
//  ServicesDetails.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/05/2023.
//

import Foundation
struct ServicesDetails : Codable {
    let oneDimensionalService : [OneDimensionalService]?
    let twoDimensionalService : [TwoDimensionalService]?

    enum CodingKeys: String, CodingKey {

        case oneDimensionalService = "oneDimensionalService"
        case twoDimensionalService = "twoDimensionalService"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        oneDimensionalService = try values.decodeIfPresent([OneDimensionalService].self, forKey: .oneDimensionalService)
        twoDimensionalService = try values.decodeIfPresent([TwoDimensionalService].self, forKey: .twoDimensionalService)
    }

}
