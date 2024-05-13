//
//  MyAppointments.swift
//  Yabraa
//
//  Created by Hamada Ragab on 24/07/2023.
//

import Foundation
struct MyAppointments : Codable {
    let packageNameAR : String?
    let packageNameEN : String?
    let serviceAR : String?
    let serviceEN : String?
    let visitDT : String?
    let visitTime : String?
    let price : Double?
    let userFamilyName : String?
    var status : String?
    let appointmentId : Int?
//    var visiteDate: Date?
    enum CodingKeys: String, CodingKey {

        case packageNameAR = "packageNameAR"
        case packageNameEN = "packageNameEN"
        case serviceAR = "serviceAR"
        case serviceEN = "serviceEN"
        case visitDT = "visitDT"
        case visitTime = "visitTime"
        case price = "price"
        case userFamilyName = "userFamilyName"
        case status = "status"
        case appointmentId = "appointmentId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        packageNameAR = try values.decodeIfPresent(String.self, forKey: .packageNameAR)
        packageNameEN = try values.decodeIfPresent(String.self, forKey: .packageNameEN)
        serviceAR = try values.decodeIfPresent(String.self, forKey: .serviceAR)
        serviceEN = try values.decodeIfPresent(String.self, forKey: .serviceEN)
        visitDT = try values.decodeIfPresent(String.self, forKey: .visitDT)
        visitTime = try values.decodeIfPresent(String.self, forKey: .visitTime)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        userFamilyName = try values.decodeIfPresent(String.self, forKey: .userFamilyName)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        appointmentId = try values.decodeIfPresent(Int.self, forKey: .appointmentId)
    }

}
