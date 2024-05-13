//
//  Packages.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/05/2023.
//

import Foundation
struct Packages : Codable {
    let packageId : Int?
    let nameAR : String?
    let nameEN : String?
    let subTitleAR : String?
    let subTitleEN : String?
    let detailsAR : String?
    let detailsEN : String?
    let instructionAR : String?
    let instructionEN : String?
    let price : Int?
    let imagePath : String?
    let serviceId : Int?
    let filterId : Int?
    var isSelected : Bool?
    var date = ""
    var time = ""
    var patientName  = ""
    var packageDescription = ""
    var userId: Int?
    var serverDate = ""
    enum CodingKeys: String, CodingKey {

        case packageId = "packageId"
        case nameAR = "nameAR"
        case nameEN = "nameEN"
        case subTitleAR = "subTitleAR"
        case subTitleEN = "subTitleEN"
        case detailsAR = "detailsAR"
        case detailsEN = "detailsEN"
        case instructionAR = "instructionAR"
        case instructionEN = "instructionEN"
        case price = "price"
        case imagePath = "imagePath"
        case serviceId = "serviceId"
        case filterId = "filterId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        packageId = try values.decodeIfPresent(Int.self, forKey: .packageId)
        nameAR = try values.decodeIfPresent(String.self, forKey: .nameAR)
        nameEN = try values.decodeIfPresent(String.self, forKey: .nameEN)
        subTitleAR = try values.decodeIfPresent(String.self, forKey: .subTitleAR)
        subTitleEN = try values.decodeIfPresent(String.self, forKey: .subTitleEN)
        detailsAR = try values.decodeIfPresent(String.self, forKey: .detailsAR)
        detailsEN = try values.decodeIfPresent(String.self, forKey: .detailsEN)
        instructionAR = try values.decodeIfPresent(String.self, forKey: .instructionAR)
        instructionEN = try values.decodeIfPresent(String.self, forKey: .instructionEN)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
        serviceId = try values.decodeIfPresent(Int.self, forKey: .serviceId)
        filterId = try values.decodeIfPresent(Int.self, forKey: .filterId)
        isSelected = false
    }

}
