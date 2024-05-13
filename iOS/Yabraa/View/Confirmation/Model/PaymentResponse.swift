//
//  PaymentResponse.swift
//  Yabraa
//
//  Created by Hamada Ragab on 03/07/2023.
//

import Foundation
struct PaymentResponse : Codable {
    let checkoutId : String?
    let model : Model?

    enum CodingKeys: String, CodingKey {

        case checkoutId = "checkoutId"
        case model = "model"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        checkoutId = try values.decodeIfPresent(String.self, forKey: .checkoutId)
        model = try values.decodeIfPresent(Model.self, forKey: .model)
    }

}

struct Model : Codable {
    let locationLongitude : Double?
    let locationLatitude : Double?
    let locationAltitude : Double?
    let amount : Int?
    let currency : String?
    let paymentType : String?
    let packages : [Packages]?

    enum CodingKeys: String, CodingKey {

        case locationLongitude = "locationLongitude"
        case locationLatitude = "locationLatitude"
        case locationAltitude = "locationAltitude"
        case amount = "amount"
        case currency = "currency"
        case paymentType = "paymentType"
        case packages = "packages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        locationLongitude = try values.decodeIfPresent(Double.self, forKey: .locationLongitude)
        locationLatitude = try values.decodeIfPresent(Double.self, forKey: .locationLatitude)
        locationAltitude = try values.decodeIfPresent(Double.self, forKey: .locationAltitude)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
        packages = try values.decodeIfPresent([Packages].self, forKey: .packages)
    }

}

struct PackagesData : Codable {
    let packageId : Int?
    let userFamilyId : Int?
    let notes : String?
    let price : Int?
    let dateTime : String?

    enum CodingKeys: String, CodingKey {

        case packageId = "packageId"
        case userFamilyId = "userFamilyId"
        case notes = "notes"
        case price = "price"
        case dateTime = "dateTime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        packageId = try values.decodeIfPresent(Int.self, forKey: .packageId)
        userFamilyId = try values.decodeIfPresent(Int.self, forKey: .userFamilyId)
        notes = try values.decodeIfPresent(String.self, forKey: .notes)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
    }

}
