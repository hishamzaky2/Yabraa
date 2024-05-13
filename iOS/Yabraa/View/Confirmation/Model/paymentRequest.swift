//
//  paymentData.swift
//  Yabraa
//
//  Created by Hamada Ragab on 03/07/2023.
//

import Foundation
struct paymentRequest{
    let serviceTypeId: ServicesType?
    let locationLongitude: String
    let locationLatitude: String
    let locationAltitude: String
    let totalPrice: Int
    let currency: String
    let paymentType: String
    let paymentMethodId: Int
    let packages: [SelectedPackages]
    func toJosn() -> [String: Any] {
        var selectedPackages: [[String: Any]] = []
        for package in packages {
            selectedPackages.append(package.toJosn())
        }
        var parameters: [String: Any] = [
            "ServiceTypeId":serviceTypeId?.rawValue ?? 1,
            "PaymentMethodId": paymentMethodId,
//            "locationLongitude": locationLongitude,
//            "amount": 4,
            "amount": totalPrice,
            "currency": currency,
//            "paymentType": paymentType,
            "packages": selectedPackages
        ]
        if serviceTypeId == .HomeVisit {
            parameters["locationLatitude"] = locationLatitude
            parameters["locationLongitude"] = locationLongitude
            parameters["locationAltitude"] = locationAltitude

//            parameters["locatioAltitude"] = locationAltitude
        }
        return parameters
    }
}
struct SelectedPackages {
    let packageId: Int
    let userFamilyId: Int
    let price: Int
    let notes: String
    let dateTime: String
    func toJosn() -> [String: Any] {
        return [
            "packageId": packageId,
            "userFamilyId": userFamilyId,
            "price": price,
            "notes": notes,
            "dateTime": dateTime
        ]
    }
}
