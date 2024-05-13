//
//  DiseasesViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
class DiseasesViewModel {
    private let disposeBag = DisposeBag()
    var PatientID: Int?
    let  disease = BehaviorRelay<Diseases>(value: .Allergies)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let diseasesData = BehaviorRelay<[DiseasesData]>(value: [])
    var diseasesServices :DiseasesServicesProtocol?
    let dispatchGroup = DispatchGroup()
    var filteredDiseases: [DiseasesData] = []
    var userDiseases: [DiseasesData] = []
    init(PatientID: Int, disease: Diseases) {
        diseasesServices = DiseasesServices()
        self.PatientID = PatientID
        self.disease.accept(disease)
        getDiseases()
        
    }
    private func getDiseases() {
        switch disease.value {
        case .Allergies:
            handleAllergies()
        case .ChronicDiseases:
            handleChronicDiseases()
        case .CurrentMedications:
            handleCurrentMedications()
        case .Injuries:
            handleInjuries()
        case .PastMedications:
            handlePastMedications()
        case .Surgeries:
            handleSurgeries()
        }
    }
    private func handleAllergies() {
        isLoading.accept(true)
        dispatchGroup.enter()
        getAllergies()
        dispatchGroup.enter()
        getUserAllergies()
        dispatchGroup.notify(queue: .main) { [self] in
            self.isLoading.accept(false)
            self.diseasesData.accept( self.checkIfUserHaveAnyDiseases())
        }
    }
    private func handleChronicDiseases() {
        isLoading.accept(true)
        dispatchGroup.enter()
        getChronicDiseases()
        dispatchGroup.enter()
        getUserChronicDiseases()
        dispatchGroup.notify(queue: .main) { [self] in
            self.isLoading.accept(false)
            self.diseasesData.accept( self.checkIfUserHaveAnyDiseases())
        }
    }
    private func handleCurrentMedications() {
        isLoading.accept(true)
        dispatchGroup.enter()
        getCurrentMedications()
        dispatchGroup.enter()
        getUserCurrentMedications()
        dispatchGroup.notify(queue: .main) { [self] in
            self.isLoading.accept(false)
            self.diseasesData.accept( self.checkIfUserHaveAnyDiseases())
        }
    }
    private func handleInjuries() {
        isLoading.accept(true)
        dispatchGroup.enter()
        getInjuries()
        dispatchGroup.enter()
        getUserInjuries()
        dispatchGroup.notify(queue: .main) { [self] in
            self.isLoading.accept(false)
            self.diseasesData.accept( self.checkIfUserHaveAnyDiseases())
        }
    }
    private func handleSurgeries() {
        isLoading.accept(true)
        dispatchGroup.enter()
        getSurgeries()
        dispatchGroup.enter()
        getUserSurgeries()
        dispatchGroup.notify(queue: .main) { [self] in
            self.isLoading.accept(false)
            self.diseasesData.accept( self.checkIfUserHaveAnyDiseases())
        }
    }
    private func handlePastMedications() {
        isLoading.accept(true)
        dispatchGroup.enter()
        getPastMedications()
        dispatchGroup.enter()
        getUserPastMedications()
        dispatchGroup.notify(queue: .main) { [self] in
            self.isLoading.accept(false)
            self.diseasesData.accept( self.checkIfUserHaveAnyDiseases())
        }
    }
    private func checkIfUserHaveAnyDiseases() -> [DiseasesData] {
        var diseases: [DiseasesData] = []
        for filteredDiseases in self.filteredDiseases {
            var updatedFilterdDisease = filteredDiseases
            if self.userDiseases .contains(where: { dd in
                dd.diseaseId == filteredDiseases.diseaseId
            }) {
                updatedFilterdDisease.isAdded = true
            }else {
                updatedFilterdDisease.isAdded = false
            }
            diseases.append(updatedFilterdDisease)
        }
        return diseases
    }
    private func getAllergies() {
        diseasesServices?.getAllergies(completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.filteredDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getChronicDiseases() {
        diseasesServices?.getChronicDiseases(completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.filteredDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getCurrentMedications() {
        diseasesServices?.getCurrentMedications(completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.filteredDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getInjuries() {
        diseasesServices?.getInjuries(completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.filteredDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getPastMedications() {
        diseasesServices?.getPastMedications(completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.filteredDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getSurgeries() {
        diseasesServices?.getSurgeries(completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.filteredDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getUserAllergies() {
        diseasesServices?.getUserAllergies(PatientID: PatientID,completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getUserChronicDiseases() {
        diseasesServices?.getUserChronicDiseases(PatientID: PatientID,completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getUserCurrentMedications() {
        diseasesServices?.getUserCurrentMedications(PatientID: PatientID,completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getUserInjuries() {
        diseasesServices?.getUserInjuries(PatientID: PatientID,completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func getUserPastMedications() {
        diseasesServices?.getUserPastMedications(PatientID: PatientID,completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })    }
    private func getUserSurgeries() {
        diseasesServices?.getUserSurgeries(PatientID: PatientID,completion: { response in
            self.dispatchGroup.leave()
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    // ADDing
    func addDisease(diseaseID: Int) {
        switch disease.value {
        case .Allergies:
            addAllergies(allergyID: diseaseID)
        case .ChronicDiseases:
            addChronicDiseases(chronicDiseasesID: diseaseID)
        case .CurrentMedications:
           addCurrentMedications(currentMedicationsID: diseaseID)
        case .Injuries:
            addInjuries(injuryId: diseaseID)
        case .PastMedications:
           addPastMedications(pastMedicationId: diseaseID)
        case .Surgeries:
            addSurgeries(surgeryID: diseaseID)
        }
    }
    private func addAllergies(allergyID:Int) {
        isLoading.accept(true)
        diseasesServices?.addAllergies(PatientID: PatientID, allergyID: allergyID, completion: { response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func addChronicDiseases(chronicDiseasesID:Int) {
        isLoading.accept(true)
        diseasesServices?.addChronicDiseases(PatientID: PatientID, chronicDiseasesID: chronicDiseasesID, completion: { response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func addCurrentMedications(currentMedicationsID:Int) {
        isLoading.accept(true)
        diseasesServices?.addCurrentMedications(PatientID: PatientID, medicationId: currentMedicationsID, completion: { response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func addInjuries(injuryId:Int) {
        isLoading.accept(true)
        diseasesServices?.addInjuries(PatientID: PatientID, injuryId: injuryId, completion:{ response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func addPastMedications(pastMedicationId:Int) {
        isLoading.accept(true)
        diseasesServices?.addPastMedications(PatientID: PatientID, medicationId: pastMedicationId, completion:{ response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func addSurgeries(surgeryID:Int) {
        isLoading.accept(true)
        diseasesServices?.addSurgeries(PatientID: PatientID, surgeryId: surgeryID, completion:{ response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    func deleteDisease(diseaseID: Int) {
        switch disease.value {
        case .Allergies:
            deleteAllergies(allergyID: diseaseID)
        case .ChronicDiseases:
            deleteChronicDiseases(chronicDiseasesID: diseaseID)
        case .CurrentMedications:
            deleteCurrentMedications(currentMedicationsID: diseaseID)
        case .Injuries:
            deleteInjuries(injuryId: diseaseID)
        case .PastMedications:
            deletePastMedications(pastMedicationId: diseaseID)
        case .Surgeries:
            deleteSurgeries(surgeryID: diseaseID)
        }
    }
    private func deleteAllergies(allergyID:Int) {
        isLoading.accept(true)
        diseasesServices?.deleteAllergies(PatientID: PatientID, allergyID: allergyID, completion: { response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func deleteChronicDiseases(chronicDiseasesID:Int) {
        isLoading.accept(true)
        diseasesServices?.deleteChronicDiseases(PatientID: PatientID, chronicDiseasesID: chronicDiseasesID, completion: { response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func deleteCurrentMedications(currentMedicationsID:Int) {
        isLoading.accept(true)
        diseasesServices?.deleteCurrentMedications(PatientID: PatientID, medicationId: currentMedicationsID, completion: { response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func deleteInjuries(injuryId:Int) {
        isLoading.accept(true)
        diseasesServices?.deleteInjuries(PatientID: PatientID, injuryId: injuryId, completion:{ response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func deletePastMedications(pastMedicationId:Int) {
        isLoading.accept(true)
        diseasesServices?.deletePastMedications(PatientID: PatientID, medicationId: pastMedicationId, completion:{ response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    private func deleteSurgeries(surgeryID:Int) {
        isLoading.accept(true)
        diseasesServices?.deleteSurgeries(PatientID: PatientID, surgeryId: surgeryID, completion:{ response in
            self.isLoading.accept(false)
            switch response {
            case .success(let diseasesData):
                self.userDiseases = diseasesData
                self.diseasesData.accept(self.checkIfUserHaveAnyDiseases())
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}

