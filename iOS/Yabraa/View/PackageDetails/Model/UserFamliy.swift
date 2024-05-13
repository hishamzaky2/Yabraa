//
//  UserFamliy.swift
//  Yabraa
//
//  Created by Hamada Ragab on 05/07/2023.
//

import Foundation
struct UserFamliy : Codable {
    let userFamilyId : Int?
    let name : String?
    let isOwner : Bool?
    let gender : String?
    let birthDate : String?

    enum CodingKeys: String, CodingKey {

        case userFamilyId = "userFamilyId"
        case name = "name"
        case gender = "gender"
        case birthDate = "birthDate"
        case isOwner = "isOwner"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userFamilyId = try values.decodeIfPresent(Int.self, forKey: .userFamilyId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        birthDate = try values.decodeIfPresent(String.self, forKey: .birthDate)
        isOwner = try values.decodeIfPresent(Bool.self, forKey: .isOwner)
    }

}
