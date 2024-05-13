//
//  YBForgetPasswordViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
class YBForgetPasswordViewModel {
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isSuccess = PublishSubject<String>()
    let isFails = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    init() {
        
    }
    func getVerificationCode(phone:String){
        isLoading.accept(true)
        let parameters = [
            "PhoneNumber": phone
        ]
        NetworkServices.callAPI(withURL: URLS.FORGET_PASSWORD, responseType:BasicResponse<ForgetPassWord>.self, method: .POST, parameters: parameters).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.isSuccess.onNext((phone))
                Contstants.VerificationCode = response.data?.verificationCode ?? ""
                self?.saveUserData(userData: response.data)
               
            }else {
                self?.isFails.onNext(response.error ?? "")
            }
        },onError: { [weak self]error in
            self?.isLoading.accept(false)
            self?.isFails.onNext(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    private func saveUserData(userData: ForgetPassWord?) {
        UserDefualtUtils.setToken(token: userData?.token ?? "")
        UserDefualtUtils.setPhoneNumber(phone: userData?.phoneNumber ?? "")
//        UserDefualtUtils.setNaAme(userName: userData?.username ?? "")
    }
}
