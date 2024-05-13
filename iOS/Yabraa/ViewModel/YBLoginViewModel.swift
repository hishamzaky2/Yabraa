//
//  LoginViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import Foundation
import RxSwift
import RxCocoa
class YBLoginViewModel {
    let isLoading = BehaviorRelay<Bool>(value: false)
    let loginSuccess = PublishSubject<Void>()
    let loginFails = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    init() {
        
    }
    
    func login(phone:String, password: String){
        isLoading.accept(true)
        let parameters = [
            "PhoneNumber": phone,
            "password": password
        ]
        NetworkServices.callAPI(withURL: URLS.LOGIN, responseType:BasicResponse<User>.self, method: .POST, parameters: parameters).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.loginSuccess.onNext(())
                self?.saveUser(user: response.data)
            }else {
                self?.loginFails.onNext(response.error ?? "")
            }
        },onError: { [weak self]error in
            self?.isLoading.accept(false)
            self?.loginFails.onNext(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    private func saveUser(user: User?) {
        UserDefualtUtils.setToken(token: user?.token ?? "")
        UserDefualtUtils.setPhoneNumber(phone: user?.phoneNumber ?? "")
        UserDefualtUtils.setIsAuthenticated(authenticated: user?.isAuthenticated ?? false)
        UserDefualtUtils.setName(name: user?.username ?? "")
        UserDefualtUtils.setFirstName(name: user?.firstName ?? "")
        UserDefualtUtils.setLastName(name: user?.lastName ?? "")
    }
}
