//
//  YBRegisterViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 07/03/2023.
//

import Foundation
import RxSwift
import RxCocoa
class YBRegisterViewModel {
    private let disposeBag = DisposeBag()
    let nationalities = BehaviorRelay<[NationalitiesData]>(value: [])
    var messageError = PublishRelay<String>()
    let isLoading = BehaviorRelay<Bool>(value: false)
    let editedUserInfo = BehaviorRelay<UserInfo?>(value: nil)
    let registrationSuccess = PublishSubject<[String:String]>()
    let registrationError = PublishSubject<String>()
    let regiterLBLTi = PublishSubject<String>()

    let didAccountUpdated = PublishRelay<Void>()
    var isEditUserInfo = false
    var userInfo: UserInfo?
    init(userInfo: UserInfo?){
        getNationalities()
        self.userInfo = userInfo
       
    }
    func viewDidLoad() {
        if let userInfo = userInfo {
            isEditUserInfo = true
            self.editedUserInfo.accept(userInfo)
        }
    }
    func validateData(phone: String, password: String,birthDay: String,email: String,firstName: String, lastName: String, gender: String,countryCode: String, iqama: String) {
//        self.registrationSuccess.onNext(())
        if phone.isEmpty || email.isEmpty || firstName.isEmpty || lastName.isEmpty {
            messageError.accept("All Fileds Required".localized)
            return
        }
        if !phone.isValidPhone() || phone.count < 9 {
            messageError.accept("Phone Number Is Incorrect".localized)
            return
        }
        if !phone.isValidPhone() || phone.count < 9 {
            messageError.accept("Phone Number Is Incorrect".localized)
            return
        }
        if !isEditUserInfo && password.count < 6 {
            messageError.accept("Password Must Be Greater Than Or Equal 6 Characters".localized)
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
        if countryCode.isEmpty {
            messageError.accept("Country not Selected".localized)
            return
        }
        var parameters = [
            "PhoneNumber": phone,
            "Password": password,
            "email": email,
            "FirstName" : firstName,
            "LastName" : lastName,
            "BirthDate" :birthDay,
            "Gender" : gender,
            "CountryCode" :countryCode,
            "IdOrIqamaOrPassport" :iqama
        ]
        if isEditUserInfo {
            parameters["idOrIqamaOrPassport"] = iqama
            editUserInfo(parameters: parameters,firstName: firstName,lastName: lastName)
        }else {
            validateUserInput(parameters: parameters)
        }
    }
    func validateUserInput(parameters : [String: String]) {
        isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.UserValidation ,responseType: BasicResponse<ValidationUserInputs>.self, method: .POST, parameters: parameters)
            .subscribe(onNext: { response in
                // save User To User Defult
                self.isLoading.accept(false)
                if response.statusCode ?? 0 == 200 {
                    self.registrationSuccess.onNext(parameters)
                    RegisterData.shared.registerData = parameters
                    Contstants.VerificationCode = response.data?.verificationCode ?? ""
                }else {
                    self.registrationError.onNext(response.error ?? "")
                }
            }, onError: { error in
                self.isLoading.accept(false)
                self.registrationError.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
   
    func editUserInfo(parameters : [String: Any],firstName: String,lastName:String){
        isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.eidtUserInfo ,responseType: BasicResponse<String>.self, method: .PUT, parameters: parameters)
            .subscribe(onNext: { response in
                self.isLoading.accept(false)
                if response.statusCode ?? 0 == 200 && response.data ?? "" == "Done" {
                    self.saveUpdateData(firstName: firstName, lastName: lastName)
                    self.didAccountUpdated.accept(())
                }else {
                    self.registrationError.onNext(response.error ?? "")
                }
            }, onError: { error in
                self.isLoading.accept(false)
                self.registrationError.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    func saveUpdateData(firstName: String,lastName:String) {
        let username = editedUserInfo.value?.userName ?? ""
        UserDefualtUtils.setName(name: username)
        UserDefualtUtils.setFirstName(name: firstName)
        UserDefualtUtils.setLastName(name: lastName)
        didUpdateUserInfo()
    }
    private func saveUser(user: User?) {
        UserDefualtUtils.setToken(token: user?.token ?? "")
        UserDefualtUtils.setPhoneNumber(phone: user?.phoneNumber ?? "")
        UserDefualtUtils.setIsAuthenticated(authenticated: user?.isAuthenticated ?? false)
        UserDefualtUtils.setName(name: user?.username ?? "")
        UserDefualtUtils.setFirstName(name: user?.firstName ?? "")
        UserDefualtUtils.setLastName(name: user?.lastName ?? "")
    }
    private func getNationalities() {
        NetworkServices.callAPI(withURL: URLS.NATIONALITIES, responseType: BasicResponse<Nationalities>.self, method: .GET, parameters: nil)
            .subscribe(onNext: { response in
                if response.statusCode ?? 0 == 200 {
                    self.nationalities.accept(response.data?.nationalities ?? [])
                }
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    private func didUpdateUserInfo() {
        let notificationName = Notification.Name("DID_UPDATE_USER_INFO")
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
}
