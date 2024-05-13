//
//  UserInfo.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/07/2023.
//

import Foundation
struct UserInfo : Codable {
    let firstName : String?
    let lastName : String?
    let birthDate : String?
    let gender : String?
    let idOrPassport : String?
    let crateDateTime : String?
    let countryCode : String?
    let countryNameAr : String?
    let countryNameEn : String?
    let nationalityEn : String?
    let nationalityAr : String?
    let userName : String?
    let email : String?
    let phoneNumber : String?

    enum CodingKeys: String, CodingKey {

        case firstName = "firstName"
        case lastName = "lastName"
        case birthDate = "birthDate"
        case gender = "gender"
        case idOrPassport = "idOrPassport"
        case crateDateTime = "crateDateTime"
        case countryCode = "countryCode"
        case countryNameAr = "countryNameAr"
        case countryNameEn = "countryNameEn"
        case nationalityEn = "nationalityEn"
        case nationalityAr = "nationalityAr"
        case userName = "userName"
        case email = "email"
        case phoneNumber = "phoneNumber"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        birthDate = try values.decodeIfPresent(String.self, forKey: .birthDate)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        idOrPassport = try values.decodeIfPresent(String.self, forKey: .idOrPassport)
        crateDateTime = try values.decodeIfPresent(String.self, forKey: .crateDateTime)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        countryNameAr = try values.decodeIfPresent(String.self, forKey: .countryNameAr)
        countryNameEn = try values.decodeIfPresent(String.self, forKey: .countryNameEn)
        nationalityEn = try values.decodeIfPresent(String.self, forKey: .nationalityEn)
        nationalityAr = try values.decodeIfPresent(String.self, forKey: .nationalityAr)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
    }

}
