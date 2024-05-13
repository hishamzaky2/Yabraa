//
//  ValidationUserInputs.swift
//  Yabraa
//
//  Created by Hamada Ragab on 11/09/2023.
//

import Foundation
struct ValidationUserInputs : Codable {
    let email : String?
    let phoneNumber : String?
    let password : String?
    let firstName : String?
    let lastName : String?
    let birthDate : String?
    let gender : String?
    let countryCode : String?
    let idOrIqamaOrPassport : String?
    let verificationCode : String?

    enum CodingKeys: String, CodingKey {

        case email = "email"
        case phoneNumber = "phoneNumber"
        case password = "password"
        case firstName = "firstName"
        case lastName = "lastName"
        case birthDate = "birthDate"
        case gender = "gender"
        case countryCode = "countryCode"
        case idOrIqamaOrPassport = "idOrIqamaOrPassport"
        case verificationCode = "verificationCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        birthDate = try values.decodeIfPresent(String.self, forKey: .birthDate)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        idOrIqamaOrPassport = try values.decodeIfPresent(String.self, forKey: .idOrIqamaOrPassport)
        verificationCode = try values.decodeIfPresent(String.self, forKey: .verificationCode)
    }

}
