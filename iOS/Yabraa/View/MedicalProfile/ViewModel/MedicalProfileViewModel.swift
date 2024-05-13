//
//  MedicalProfileViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
class MedicalProfileViewModel {
    private let disposeBag = DisposeBag()
    let diseaseNames = Observable.just([Diseases.Allergies, Diseases.ChronicDiseases,Diseases.CurrentMedications,Diseases.Injuries,Diseases.PastMedications,Diseases.Surgeries])
    var PatientID: Int?
    init(PatientID: Int) {
        self.PatientID = PatientID
    }
   
}
