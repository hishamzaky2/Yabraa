//
//  Payments.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/08/2023.
//

import Foundation
struct Payments : Codable {
    let result : [ResultData]?
    enum CodingKeys: String, CodingKey {

        case result = "result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResultData].self, forKey: .result)
    }
}

struct Items : Codable {
    let packageNameAR : String?
    let packageNameEN : String?
    let serviceAR : String?
    let serviceEN : String?
    let visitDT : String?
    let price : Double?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case packageNameAR = "packageNameAR"
        case packageNameEN = "packageNameEN"
        case serviceAR = "serviceAR"
        case serviceEN = "serviceEN"
        case visitDT = "visitDT"
        case price = "price"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        packageNameAR = try values.decodeIfPresent(String.self, forKey: .packageNameAR)
        packageNameEN = try values.decodeIfPresent(String.self, forKey: .packageNameEN)
        serviceAR = try values.decodeIfPresent(String.self, forKey: .serviceAR)
        serviceEN = try values.decodeIfPresent(String.self, forKey: .serviceEN)
        visitDT = try values.decodeIfPresent(String.self, forKey: .visitDT)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ResultData : Codable {
    let date : String?
    let items : [Items]?

    enum CodingKeys: String, CodingKey {

        case date = "date"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
    }

}
