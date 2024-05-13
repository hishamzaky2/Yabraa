//
//  TwoDimensionalService.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/05/2023.
//

import Foundation
struct TwoDimensionalService : Codable {
    let parentService : ParentService?
    let firstService : FirstService?
    let secondService : SecondService?

    enum CodingKeys: String, CodingKey {

        case parentService = "parentService"
        case firstService = "firstService"
        case secondService = "secondService"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        parentService = try values.decodeIfPresent(ParentService.self, forKey: .parentService)
        firstService = try values.decodeIfPresent(FirstService.self, forKey: .firstService)
        secondService = try values.decodeIfPresent(SecondService.self, forKey: .secondService)
    }

}
