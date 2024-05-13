//
//  File.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/07/2023.
//

import Foundation
import RxSwift
import RxCocoa
class PaitentInfoViewModel {
    let usersFamliy = BehaviorRelay<[UserFamliy]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    var messageError = PublishRelay<String>()
    var didAddNewPatient = PublishRelay<Void>()
    var didDeletePatient = PublishRelay<Void>()
    var didUpdatePatient = PublishRelay<Void>()
    let updatedPatient = BehaviorRelay<UserFamliy?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(updatedPatient: UserFamliy?) {
        if let updatedPatient = updatedPatient {
            self.updatedPatient.accept(updatedPatient)
        }
    }
    func validateData(name: String, birthDay : String, gender: String) {
        if name.isEmpty || birthDay.isEmpty || gender.isEmpty {
            messageError.accept("All Fileds Required".localized)
            return
        }
        if name.isEmpty{
            messageError.accept("patient name Not Selected".localized)
            return
        }
        if birthDay.isEmpty{
            messageError.accept("Birth day Not Selected".localized)
            return
        }
        if gender.isEmpty {
            messageError.accept("Gender Not Selected".localized)
            return
        }
        var parameters = [
            "Name": name,
            "BirthDate":birthDay,
            "Gender": gender
        ]
        if let updatedPatient = updatedPatient.value{
            parameters["UserFamilyId"] = String(updatedPatient.userFamilyId ?? 0)
            updatePatientData(parameters: parameters)
        }else {
            addNewPatient(parameters: parameters)
        }
    }
    private func addNewPatient(parameters: [String:String]) {
        self.isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.userFamily, responseType:BasicResponse<[UserFamliy]>.self, method: .POST, parameters: parameters).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.didAddedNewPatient(userFamily: response.data ?? [])
                self?.didAddNewPatient.accept(())
            }else {
                print(response.error ?? "")
            }
        },onError: {error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    private func updatePatientData(parameters: [String:String]) {
        self.isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.userFamily, responseType:BasicResponse<UserFamliy>.self, method: .PUT, parameters: parameters).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.didUpdateUser(userFamily: response.data)
                self?.didUpdatePatient.accept(())
            }else {
                print(response.error ?? "")
            }
        },onError: {error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
     func deletePatientData() {
        self.isLoading.accept(true)
         guard let patientID = updatedPatient.value?.userFamilyId else {return}
         let url = URLS.userFamily + "/\(patientID)"
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<String>.self, method: .DELETE, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 && response.data ?? "" == "Deleted" {
                self?.didDeletePatientData()
//                self?.didDeletePatient(userFamily: response.data)
                self?.didDeletePatient.accept(())
            }else {
                print(response.error ?? "")
            }
        },onError: {error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func didAddedNewPatient(userFamily:[UserFamliy]) {
        let notificationName = Notification.Name("DID_ADD_NEW_PATIENT")
        let userInfo = ["userFamily":userFamily] 
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
    }
    func didDeletePatientData() {
        guard let deletedPatient = updatedPatient.value else {return}
        let notificationName = Notification.Name("DID_Delete_PATIENT")
        let userInfo = ["userFamily":deletedPatient]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
    }
    func didUpdateUser(userFamily:UserFamliy?) {
        guard let userFamily = userFamily else {return}
        let notificationName = Notification.Name("DID_UPDATE_PATIENT")
        let userInfo = ["userFamily":userFamily]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
    }
}
