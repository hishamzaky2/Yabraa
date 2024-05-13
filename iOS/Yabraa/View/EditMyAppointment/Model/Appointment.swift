//
//  Appointment.swift
//  Yabraa
//
//  Created by Hamada Ragab on 25/07/2023.
//

import Foundation
struct Appointment : Codable {
    let appointmentId : Int?
    let userFamilyName : String?
    let locationLongitude : Double?
    let locationLatitude : Double?
    let locationAltitude : Double?
    let price : Double?
    let notes : String?
    let packageNameAR : String?
    let packageNameEN : String?
    let status : String?
    let serviceAR : String?
    let serviceEN : String?
    let visitDT : String?
    let visitTime : String?

    enum CodingKeys: String, CodingKey {

        case appointmentId = "appointmentId"
        case userFamilyName = "userFamilyName"
        case locationLongitude = "locationLongitude"
        case locationLatitude = "locationLatitude"
        case locationAltitude = "locationAltitude"
        case price = "price"
        case notes = "notes"
        case packageNameAR = "packageNameAR"
        case packageNameEN = "packageNameEN"
        case status = "status"
        case serviceAR = "serviceAR"
        case serviceEN = "serviceEN"
        case visitDT = "visitDT"
        case visitTime = "visitTime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        appointmentId = try values.decodeIfPresent(Int.self, forKey: .appointmentId)
        userFamilyName = try values.decodeIfPresent(String.self, forKey: .userFamilyName)
        locationLongitude = try values.decodeIfPresent(Double.self, forKey: .locationLongitude)
        locationLatitude = try values.decodeIfPresent(Double.self, forKey: .locationLatitude)
        locationAltitude = try values.decodeIfPresent(Double.self, forKey: .locationAltitude)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        notes = try values.decodeIfPresent(String.self, forKey: .notes)
        packageNameAR = try values.decodeIfPresent(String.self, forKey: .packageNameAR)
        packageNameEN = try values.decodeIfPresent(String.self, forKey: .packageNameEN)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        serviceAR = try values.decodeIfPresent(String.self, forKey: .serviceAR)
        serviceEN = try values.decodeIfPresent(String.self, forKey: .serviceEN)
        visitDT = try values.decodeIfPresent(String.self, forKey: .visitDT)
        visitTime = try values.decodeIfPresent(String.self, forKey: .visitTime)
    }

}
