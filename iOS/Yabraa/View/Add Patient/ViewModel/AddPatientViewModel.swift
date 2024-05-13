//
//  AddPatientViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/07/2023.
//

import Foundation
import RxSwift
import RxCocoa
class AddPatientViewModel {
    let usersFamliy = BehaviorRelay<[UserFamliy]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    init() {
        getUsersFamliy()
        observeNewPatientAdded()
        observeDidDeletePatient()
        observeDidUpdatedPatient()
    }
    private func getUsersFamliy() {
        isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.userFamily, responseType:BasicResponse<[UserFamliy]>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.usersFamliy.accept(response.data ?? [])
            }else {
                print(response.error ?? "")
            }
        },onError: {error in
            self.isLoading.accept(false)
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    private func observeNewPatientAdded() {
        let notificationName = Notification.Name("DID_ADD_NEW_PATIENT")
        NotificationCenter.default.rx.notification(notificationName)
            .subscribe(onNext: { notification in
                if let userInfo = notification.userInfo {
                    let userFamily = userInfo["userFamily"] as? [UserFamliy] ?? []
                    self.usersFamliy.accept(userFamily)
                }
            })
            .disposed(by: disposeBag)
    }
    private func observeDidUpdatedPatient() {
        let notificationName = Notification.Name("DID_UPDATE_PATIENT")
        NotificationCenter.default.rx.notification(notificationName)
            .subscribe(onNext: { notification in
                if let userInfo = notification.userInfo, let userFamily = userInfo["userFamily"] as? UserFamliy {
                    var users = self.usersFamliy.value
                    if let index =  users.firstIndex(where: {$0.userFamilyId == userFamily.userFamilyId}) {
                        users[index] = userFamily
                        self.usersFamliy.accept(users)
                        
                        
                    }
                    
                }
            })
            .disposed(by: disposeBag)
    }
    private func observeDidDeletePatient() {
        let notificationName = Notification.Name("DID_Delete_PATIENT")
        NotificationCenter.default.rx.notification(notificationName)
            .subscribe(onNext: { notification in
                if let userInfo = notification.userInfo, let userFamily = userInfo["userFamily"] as? UserFamliy {
                    var users = self.usersFamliy.value
                    if let index =  users.firstIndex(where: {$0.userFamilyId == userFamily.userFamilyId}) {
                        users.remove(at: index)
                        self.usersFamliy.accept(users)
                    }
                    
                }
            })
            .disposed(by: disposeBag)
    }
}


