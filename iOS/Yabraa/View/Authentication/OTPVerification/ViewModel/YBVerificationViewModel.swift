//
//  YBVerificationViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
class YBVerificationViewModel {
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isSuccess = PublishSubject<String>()
    let isFails = PublishSubject<String>()
    let registrationError = PublishSubject<String>()
    let registrationSuccess = PublishSubject<Void>()
    let goToCreatePassword = PublishSubject<Void>()
    let userVerificationCode =  BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()
    let isUserVerificationCodeValid = PublishSubject<Bool>()
    var phone: String?
    var registerParameter: [String: String]?
    private var forgetPasswordViewModel = YBForgetPasswordViewModel()
    private var registerViewModel = YBRegisterViewModel(userInfo: nil)
    init(phone: String?, registerParameter: [String: String]?) {
        self.phone = phone
        self.registerParameter = registerParameter
    }
    func checkCode() {
        guard let code = userVerificationCode.value else {return}
        if code == Contstants.VerificationCode {
            if let _ = phone {
                goToCreatePassword.onNext(())
            }else {
                register()
            }
        }else {
            self.isUserVerificationCodeValid.onNext(false)
        }
    }
    func resendCode() {
        if let phone = phone {
            forgetPasswordViewModel.getVerificationCode(phone: phone)
        }else if let registerParameter = registerParameter {
            registerViewModel.validateUserInput(parameters: registerParameter)
        }
    }
    private func register(){
        isLoading.accept(true)
        let  parameters = RegisterData.shared.registerData
        NetworkServices.callAPI(withURL: URLS.REGISTER ,responseType: BasicResponse<User>.self, method: .POST, parameters: parameters)
            .subscribe(onNext: { response in
                // save User To User Defult
                self.isLoading.accept(false)
                if response.statusCode ?? 0 == 200 {
                    self.registrationSuccess.onNext(())
                    self.saveUser(user: response.data)
                }else {
                    self.registrationError.onNext(response.error ?? "")
                }
            }, onError: { error in
                self.isLoading.accept(false)
                self.registrationError.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
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
