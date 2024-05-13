//
//  oneDimensionalService.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/05/2023.
//

import Foundation
enum ServicesType: Int {
    case HomeVisit = 1
    case RemoteDoctor = 2
}
struct OneDimensionalService : Codable {
    let serviceId : Int?
    let nameAR : String?
    let nameEN : String?
    let detailsAR : String?
    let detailsEN : String?
    let imagePath : String?
    let parentServiceId : String?
    let filters : [Filters]?
    var servicesType: ServicesType?
    enum CodingKeys: String, CodingKey {

        case serviceId = "serviceId"
        case nameAR = "nameAR"
        case nameEN = "nameEN"
        case detailsAR = "detailsAR"
        case detailsEN = "detailsEN"
        case imagePath = "imagePath"
        case parentServiceId = "parentServiceId"
        case filters = "filters"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        serviceId = try values.decodeIfPresent(Int.self, forKey: .serviceId)
        nameAR = try values.decodeIfPresent(String.self, forKey: .nameAR)
        nameEN = try values.decodeIfPresent(String.self, forKey: .nameEN)
        detailsAR = try values.decodeIfPresent(String.self, forKey: .detailsAR)
        detailsEN = try values.decodeIfPresent(String.self, forKey: .detailsEN)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
        parentServiceId = try values.decodeIfPresent(String.self, forKey: .parentServiceId)
        filters = try values.decodeIfPresent([Filters].self, forKey: .filters)
        servicesType = .HomeVisit
    }
    mutating func chnageServiceType(servicesType: ServicesType) {
        self.servicesType = servicesType
    }

}
