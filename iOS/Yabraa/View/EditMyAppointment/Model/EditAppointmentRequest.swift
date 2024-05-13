//
//  EditAppointmentRequest.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/07/2023.
//

import Foundation
struct EditAppointmentRequest {
    var appointmentId: Int?
    var locationLongitude: String?
    var locationLatitude: String?
    var locatioAltitude: String?
    var notes: String?
    init(appointmentId: Int, locatioLongitude: Double, locationLatitude: Double, locatioAltitude: Double, notes: String) {
        self.appointmentId = appointmentId
        self.locationLongitude = String(locatioLongitude)
        self.locationLatitude = String(locationLatitude)
        self.locatioAltitude = String(locatioAltitude)
        self.notes = notes
    }
    func toJosn() -> [String: Any] {
        return [
            "AppointmentId": appointmentId ?? 0,
            "locationLongitude": locationLongitude ?? "",
            "locationLatitude": locationLatitude ?? "",
            "locatioAltitude": locatioAltitude ?? "",
            "Notes": notes ?? ""
        ]
    }
}
