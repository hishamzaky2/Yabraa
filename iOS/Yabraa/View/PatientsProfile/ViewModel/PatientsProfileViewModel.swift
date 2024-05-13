//
//  PatientsProfileViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
class PatientsProfileViewModel{
    private let disposeBag = DisposeBag()
    let usersFamliy = BehaviorRelay<[UserFamliy]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    init() {
        getUsersFamliy()
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
     func didSelectPatient(patientID: Int) {
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
}
