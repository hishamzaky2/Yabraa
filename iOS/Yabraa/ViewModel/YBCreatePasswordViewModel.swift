//
//  YBCreatePasswordViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
class YBCreatePasswordViewModel {
    var messageError = PublishRelay<String>()
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isSuccess = PublishSubject<Void>()
    let isFails = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    init(){
    }
    func CreateNewPAswword(password: String,confirmedPassword: String){
        isLoading.accept(true)
        let parameters = [
            "PhoneNumber": UserDefualtUtils.getPhoneNumber(),
            "Token": UserDefualtUtils.getToken() ?? "",
            "VerificationCode": Contstants.VerificationCode,
            "Password": password,
            "ConfirmPassword": confirmedPassword
        ]
        NetworkServices.callAPI(withURL: URLS.RESET_PASSWORD, responseType:BasicResponse<ForgetPassWord>.self, method: .POST, parameters: parameters).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.isSuccess.onNext(())
                
            }else {
                self?.isFails.onNext(response.error ?? "")
            }
        },onError: { [weak self]error in
            self?.isLoading.accept(false)
            self?.isFails.onNext(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func validateData(password: String,confirmedPassword: String) {
        if password.isEmpty || confirmedPassword.isEmpty {
            messageError.accept("All Fileds Required".localized)
            return
        }
        if password.count < 6 {
            messageError.accept("Password Must Be Greater Than Or Equal 6 Characters".localized)
            return
        }
        if password != confirmedPassword {
            messageError.accept("Password Not Identical".localized)
            return
        }
        CreateNewPAswword(password: password, confirmedPassword: confirmedPassword)
    }
}
