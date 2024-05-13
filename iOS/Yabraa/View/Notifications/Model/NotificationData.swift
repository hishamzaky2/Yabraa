//
//  NotificationData.swift
//  Yabraa
//
//  Created by Hamada Ragab on 23/11/2023.
//

import Foundation
struct NotificationData : Codable {
    let pageNumber : Int?
    let pageSize : Int?
    let count : Int?
    let isALLRead : Bool?
    let notifications : [Notifications]?
    
    enum CodingKeys: String, CodingKey {
        
        case pageNumber = "pageNumber"
        case pageSize = "pageSize"
        case count = "count"
        case isALLRead = "isALLRead"
        case notifications = "notifications"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pageNumber = try values.decodeIfPresent(Int.self, forKey: .pageNumber)
        pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        isALLRead = try values.decodeIfPresent(Bool.self, forKey: .isALLRead)
        notifications = try values.decodeIfPresent([Notifications].self, forKey: .notifications)
    }
    
}
struct Notifications : Codable {
    let notificationId : Int?
    let titleAR : String?
    let titleEn : String?
    let bodyAR : String?
    let bodyEn : String?
    var isRead : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case notificationId = "notificationId"
        case titleAR = "titleAR"
        case titleEn = "titleEn"
        case bodyAR = "bodyAR"
        case bodyEn = "bodyEn"
        case isRead = "isRead"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notificationId = try values.decodeIfPresent(Int.self, forKey: .notificationId)
        titleAR = try values.decodeIfPresent(String.self, forKey: .titleAR)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        bodyAR = try values.decodeIfPresent(String.self, forKey: .bodyAR)
        bodyEn = try values.decodeIfPresent(String.self, forKey: .bodyEn)
        isRead = try values.decodeIfPresent(Bool.self, forKey: .isRead)
    }
    
}
