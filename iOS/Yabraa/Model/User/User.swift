//
//  User.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/04/2023.
//

import Foundation
struct User : Codable {
    let message : String?
    let isAuthenticated : Bool?
    let username : String?
    let email : String?
    let token : String?
    let expiresOn : String?
    let phoneNumber : String?
    let phoneNumberConfirmed : Bool?
    let firstName: String?
    let lastName: String?
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case isAuthenticated = "isAuthenticated"
        case username = "username"
        case email = "email"
        case token = "token"
        case expiresOn = "expiresOn"
        case phoneNumber = "phoneNumber"
        case phoneNumberConfirmed = "phoneNumberConfirmed"
        case firstName,lastName
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        isAuthenticated = try values.decodeIfPresent(Bool.self, forKey: .isAuthenticated)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        expiresOn = try values.decodeIfPresent(String.self, forKey: .expiresOn)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        phoneNumberConfirmed = try values.decodeIfPresent(Bool.self, forKey: .phoneNumberConfirmed)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
    }

}
