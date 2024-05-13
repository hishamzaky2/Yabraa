//
//  DiseasesServices.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
protocol DiseasesServicesProtocol{
    func getAllergies(completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getChronicDiseases(completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getCurrentMedications(completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getInjuries(completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getPastMedications(completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getSurgeries(completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getUserAllergies(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getUserChronicDiseases(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getUserCurrentMedications(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getUserInjuries(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getUserSurgeries(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func getUserPastMedications(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func addSurgeries(PatientID:Int?,surgeryId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func addPastMedications(PatientID:Int?,medicationId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func addCurrentMedications(PatientID:Int?,medicationId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func addInjuries(PatientID:Int?,injuryId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func addChronicDiseases(PatientID:Int?,chronicDiseasesID:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func addAllergies(PatientID:Int?,allergyID:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func deleteSurgeries(PatientID:Int?,surgeryId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func deletePastMedications(PatientID:Int?,medicationId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func deleteCurrentMedications(PatientID:Int?,medicationId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func deleteInjuries(PatientID:Int?,injuryId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
    func deleteChronicDiseases(PatientID:Int?,chronicDiseasesID:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
     func deleteAllergies(PatientID:Int?,allergyID:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ())
}
class DiseasesServices:DiseasesServicesProtocol {
    private let disposeBag = DisposeBag()
    
    func getAllergies(completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        NetworkServices.callAPI(withURL: URLS.GetAllergies, responseType:BasicResponse<[Allergies]>.self, method: .GET, parameters: nil).subscribe(onNext: { response in
            if let allergies = response.data {
                let allergiesData = allergies.map{DiseasesData(allergies: $0)}
                completion(.success(allergiesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getChronicDiseases(completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        NetworkServices.callAPI(withURL: URLS.GetChronicDiseases, responseType:BasicResponse<[ChronicDiseases]>.self, method: .GET, parameters: nil).subscribe(onNext: { response in
            if let chronicDiseases = response.data {
                let chronicDiseasesData = chronicDiseases.map{DiseasesData(chronicDiseases: $0)}
                completion(.success(chronicDiseasesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getCurrentMedications(completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        NetworkServices.callAPI(withURL: URLS.GetCurrentMedications, responseType:BasicResponse<[CurrentMedications]>.self, method: .GET, parameters: nil).subscribe(onNext: { response in
            if let currentMedications = response.data {
                let currentMedicationsData = currentMedications.map{DiseasesData(currentMedications: $0)}
                completion(.success(currentMedicationsData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getInjuries(completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        NetworkServices.callAPI(withURL: URLS.GetInjuries, responseType:BasicResponse<[Injuries]>.self, method: .GET, parameters: nil).subscribe(onNext: {response in
            if let injuries = response.data {
                let injuriesData = injuries.map{DiseasesData(injuries: $0)}
                completion(.success(injuriesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getPastMedications(completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        NetworkServices.callAPI(withURL: URLS.GetPastMedications, responseType:BasicResponse<[PastMedications]>.self, method: .GET, parameters: nil).subscribe(onNext: { response in
            if let medications = response.data {
                let medicationsData = medications.map{DiseasesData(pastMedications: $0)}
                completion(.success(medicationsData))
                
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getSurgeries(completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        NetworkServices.callAPI(withURL: URLS.GetSurgeries, responseType:BasicResponse<[Surgeries]>.self, method: .GET, parameters: nil).subscribe(onNext: {response in
            if let surgeries = response.data {
                let surgeriesData = surgeries.map{DiseasesData(surgeries: $0)}
                completion(.success(surgeriesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getUserAllergies(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.GetUserAllergies + String(PatientID)
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[Allergies]>.self, method: .GET, parameters: nil).subscribe(onNext: {response in
            if let allergies = response.data {
                let allergiesData = allergies.map{DiseasesData(allergies: $0)}
                completion(.success(allergiesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getUserChronicDiseases(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.GetUserChronicDiseases + String(PatientID)
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[ChronicDiseases]>.self, method: .GET, parameters: nil).subscribe(onNext: {response in
            if let chronicDiseases = response.data {
                let chronicDiseasesData = chronicDiseases.map{DiseasesData(chronicDiseases: $0)}
                completion(.success(chronicDiseasesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getUserCurrentMedications(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.GetUserCurrentMedications + String(PatientID)
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[CurrentMedications]>.self, method: .GET, parameters: nil).subscribe(onNext: {response in
            if let currentMedications = response.data {
                let currentMedicationsData = currentMedications.map{DiseasesData(currentMedications: $0)}
                completion(.success(currentMedicationsData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getUserInjuries(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.GetUserInjuries + String(PatientID)
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[Injuries]>.self, method: .GET, parameters: nil).subscribe(onNext: {response in
            if let injuries = response.data {
                let injuriesData = injuries.map{DiseasesData(injuries: $0)}
                completion(.success(injuriesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getUserPastMedications(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.GetUserPastMedications + String(PatientID)
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[PastMedications]>.self, method: .GET, parameters: nil).subscribe(onNext: {response in
            if let medications = response.data {
                let medicationsData = medications.map{DiseasesData(pastMedications: $0)}
                completion(.success(medicationsData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func getUserSurgeries(PatientID:Int?,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.GetUserSurgeries + String(PatientID)
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[Surgeries]>.self, method: .GET, parameters: nil).subscribe(onNext: {response in
            if let surgeries = response.data {
                let surgeriesData = surgeries.map{DiseasesData(surgeries: $0)}
                completion(.success(surgeriesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    
    func addAllergies(PatientID:Int?,allergyID:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.AddAllergies + "AllergyId=\(allergyID)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[Allergies]>.self, method: .POST, parameters: nil).subscribe(onNext: {response in
            if let allergies = response.data {
                let allergiesData = allergies.map{DiseasesData(allergies: $0)}
                completion(.success(allergiesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func addChronicDiseases(PatientID:Int?,chronicDiseasesID:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.AddChronicDiseases + "ChronicDiseaseId=\(chronicDiseasesID)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[ChronicDiseases]>.self, method: .POST, parameters: nil).subscribe(onNext: {response in
            if let chronicDisease = response.data {
                let chronicDiseaseData = chronicDisease.map{DiseasesData(chronicDiseases: $0)}
                completion(.success(chronicDiseaseData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func addInjuries(PatientID:Int?,injuryId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.AddInjuries + "InjuryId=\(injuryId)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[Injuries]>.self, method: .POST, parameters: nil).subscribe(onNext: {response in
            if let injuries = response.data {
                let injuriesData = injuries.map{DiseasesData(injuries: $0)}
                completion(.success(injuriesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func addCurrentMedications(PatientID:Int?,medicationId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.AddCurrentMedications + "MedicationId=\(medicationId)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[CurrentMedications]>.self, method: .POST, parameters: nil).subscribe(onNext: {response in
            if let currentMedications = response.data {
                let currentMedicationsData = currentMedications.map{DiseasesData(currentMedications: $0)}
                completion(.success(currentMedicationsData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func addPastMedications(PatientID:Int?,medicationId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.AddPastMedications + "MedicationId=\(medicationId)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[PastMedications]>.self, method: .POST, parameters: nil).subscribe(onNext: {response in
            if let pastMedications = response.data {
                let pastMedicationsData = pastMedications.map{DiseasesData(pastMedications: $0)}
                completion(.success(pastMedicationsData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func addSurgeries(PatientID:Int?,surgeryId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.AddSurgeries + "SurgeryId=\(surgeryId)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[Surgeries]>.self, method: .POST, parameters: nil).subscribe(onNext: {response in
            if let surgeries = response.data {
                let surgeriesData = surgeries.map{DiseasesData(surgeries: $0)}
                completion(.success(surgeriesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func deleteAllergies(PatientID:Int?,allergyID:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.DeleteAllergies + "AllergyId=\(allergyID)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[Allergies]>.self, method: .DELETE, parameters: nil).subscribe(onNext: {response in
            if let allergies = response.data {
                let allergiesData = allergies.map{DiseasesData(allergies: $0)}
                completion(.success(allergiesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func deleteChronicDiseases(PatientID:Int?,chronicDiseasesID:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.DeleteChronicDiseases + "ChronicDiseaseId=\(chronicDiseasesID)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[ChronicDiseases]>.self, method: .DELETE, parameters: nil).subscribe(onNext: {response in
            if let chronicDisease = response.data {
                let chronicDiseaseData = chronicDisease.map{DiseasesData(chronicDiseases: $0)}
                completion(.success(chronicDiseaseData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func deleteInjuries(PatientID:Int?,injuryId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.DeleteInjuries + "InjuryId=\(injuryId)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[Injuries]>.self, method: .DELETE, parameters: nil).subscribe(onNext: {response in
            if let injuries = response.data {
                let injuriesData = injuries.map{DiseasesData(injuries: $0)}
                completion(.success(injuriesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func deleteCurrentMedications(PatientID:Int?,medicationId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.DeleteCurrentMedications + "MedicationId=\(medicationId)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[CurrentMedications]>.self, method: .DELETE, parameters: nil).subscribe(onNext: {response in
            if let currentMedications = response.data {
                let currentMedicationsData = currentMedications.map{DiseasesData(currentMedications: $0)}
                completion(.success(currentMedicationsData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func deletePastMedications(PatientID:Int?,medicationId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.DeletePastMedications + "MedicationId=\(medicationId)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[PastMedications]>.self, method: .DELETE, parameters: nil).subscribe(onNext: {response in
            if let pastMedications = response.data {
                let pastMedicationsData = pastMedications.map{DiseasesData(pastMedications: $0)}
                completion(.success(pastMedicationsData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
    func deleteSurgeries(PatientID:Int?,surgeryId:Int,completion: @escaping (Result<[DiseasesData],APIError>) -> ()) {
        guard let PatientID = PatientID else {return}
        let url = URLS.DeleteSurgeries + "SurgeryId=\(surgeryId)&UserFamilyId=\(PatientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<[Surgeries]>.self, method: .DELETE, parameters: nil).subscribe(onNext: {response in
            if let surgeries = response.data {
                let surgeriesData = surgeries.map{DiseasesData(surgeries: $0)}
                completion(.success(surgeriesData))
            }else {
                completion(.failure(.jsonParsingFailed))
            }
        },onError: {error in
            completion(.failure(error as! APIError))
        }).disposed(by: disposeBag)
    }
}
