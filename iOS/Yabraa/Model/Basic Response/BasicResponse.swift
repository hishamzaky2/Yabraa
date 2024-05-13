//
//  BasicResponse.swift
//  Yabraa
//
//  Created by Hamada Ragab on 17/04/2023.
//

import Foundation
struct BasicResponse<T: Codable> : Codable {
    let statusCode : Int?
    let operationMessage : String?
    let data : T?
    let errorMessageEn : String?
    let errorMessageAr : String?
    let error :String?
    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case operationMessage = "operationMessage"
        case data = "data"
        case errorMessageAr = "errorMessageAr"
        case errorMessageEn = "errorMessageEn"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        operationMessage = try values.decodeIfPresent(String.self, forKey: .operationMessage)
        data = try values.decodeIfPresent(T.self, forKey: .data)
        errorMessageAr = try values.decodeIfPresent(String.self, forKey: .errorMessageAr)
        errorMessageEn = try values.decodeIfPresent(String.self, forKey: .errorMessageEn)
        error = UserDefualtUtils.isArabic() ? errorMessageAr : errorMessageEn
    }

}
