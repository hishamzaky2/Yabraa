//
//  Filters.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/05/2023.
//

import Foundation
struct Filters : Codable {
    let filterId : Int?
    let nameAR : String?
    let nameEN : String?
    let serviceId : Int?
    let parentServiceId : Int?
    let packages : [Packages]?
    var isSelected = false
    enum CodingKeys: String, CodingKey {

        case filterId = "filterId"
        case nameAR = "nameAR"
        case nameEN = "nameEN"
        case serviceId = "serviceId"
        case parentServiceId = "parentServiceId"
        case packages = "packages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        filterId = try values.decodeIfPresent(Int.self, forKey: .filterId)
        nameAR = try values.decodeIfPresent(String.self, forKey: .nameAR)
        nameEN = try values.decodeIfPresent(String.self, forKey: .nameEN)
        serviceId = try values.decodeIfPresent(Int.self, forKey: .serviceId)
        parentServiceId = try values.decodeIfPresent(Int.self, forKey: .parentServiceId)
        packages = try values.decodeIfPresent([Packages].self, forKey: .packages)
    }

}
