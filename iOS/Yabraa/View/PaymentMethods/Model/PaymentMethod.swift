//
//  PaymentMethod.swift
//  Yabraa
//
//  Created by Hamada Ragab on 03/08/2023.
//

import Foundation
struct PaymentMethod {
    let shownName: String
    let name: String
    let image: String
    let paymentMethodId: Int
    init(shownName: String, name: String,image: String,paymentMethodId: Int) {
        self.shownName = shownName
        self.name = name
        self.image = image
        self.paymentMethodId = paymentMethodId
    }
}
struct PaymentMethodResponse: Codable {
    let result : [PaymentMethodData]?
    enum CodingKeys: String, CodingKey {
        case result = "result"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([PaymentMethodData].self, forKey: .result)
    }
}
struct PaymentMethodData : Codable {
    let paymentMethodId : Int?
    let name : String?
    enum CodingKeys: String, CodingKey {
        
        case paymentMethodId = "paymentMethodId"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        paymentMethodId = try values.decodeIfPresent(Int.self, forKey: .paymentMethodId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
