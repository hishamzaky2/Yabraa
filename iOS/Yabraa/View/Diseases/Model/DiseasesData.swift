//
//  DiseasesData.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
struct DiseasesData {
    var titleAR: String
    var titleEN: String
    var diseaseId: Int
    var isAdded = false
    init(allergies:Allergies?) {
        self.titleAR = allergies?.titleAR ?? ""
        self.titleEN = allergies?.titleEN ?? ""
        self.diseaseId = allergies?.allergyId ?? 0
    }
    init(injuries:Injuries?) {
        self.titleAR = injuries?.titleAR ?? ""
        self.titleEN = injuries?.titleEN ?? ""
        self.diseaseId = injuries?.injuryId ?? 0
    }
    init(pastMedications:PastMedications?) {
        self.titleAR = pastMedications?.titleAR ?? ""
        self.titleEN = pastMedications?.titleEN ?? ""
        self.diseaseId = pastMedications?.medicationId ?? 0
    }
    init(surgeries:Surgeries?) {
        self.titleAR = surgeries?.titleAR ?? ""
        self.titleEN = surgeries?.titleEN ?? ""
        self.diseaseId = surgeries?.surgeryId ?? 0
    }
    init(currentMedications:CurrentMedications?) {
        self.titleAR = currentMedications?.titleAR ?? ""
        self.titleEN = currentMedications?.titleEN ?? ""
        self.diseaseId = currentMedications?.medicationId ?? 0
    }
    init(chronicDiseases:ChronicDiseases?) {
        self.titleAR = chronicDiseases?.titleAR ?? ""
        self.titleEN = chronicDiseases?.titleEN ?? ""
        self.diseaseId = chronicDiseases?.chronicDiseaseId ?? 0
    }
}
