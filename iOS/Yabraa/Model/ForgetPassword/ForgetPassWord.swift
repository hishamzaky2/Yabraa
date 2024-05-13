//
//  ForgetPassWordModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/05/2023.
//

import Foundation
struct ForgetPassWord : Codable {
    let phoneNumber : String?
    let token : String?
    let verificationCode : String?

    enum CodingKeys: String, CodingKey {

        case phoneNumber = "phoneNumber"
        case token = "token"
        case verificationCode = "verificationCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        verificationCode = try values.decodeIfPresent(String.self, forKey: .verificationCode)
    }

}

