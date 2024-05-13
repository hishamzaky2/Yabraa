//
//  PaymentStatus.swift
//  Yabraa
//
//  Created by Hamada Ragab on 01/08/2023.
//

import Foundation
struct PaymentStatus : Codable {
    let code : String?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
