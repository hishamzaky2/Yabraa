//
//  SettingViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 24/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
class SettingViewModel {
    private let disposeBag = DisposeBag()
    
    let isArabic = BehaviorRelay<Bool>(value: false)
    let fullName = BehaviorRelay<String>(value: "")
    let isEnglish = BehaviorRelay<Bool>(value: false)
    let isArabicTapped = PublishSubject<Void>()
    let isEnglishTapped = PublishRelay<Void>()
    let errorMeaasge = PublishRelay<String>()
    let didAccountDeleted = PublishRelay<Void>()
    let userInfo = PublishRelay<UserInfo?>()
    let isLoading = BehaviorRelay<Bool>(value: false)
    let didChangeLanguage = PublishRelay<Void>()

    //    let isEnglishTapped = PublishSubject<Void>()
    let settingData = Observable<[String]>.just(["medicalProfile","myAppointments","payments","addPatient","deleteAccount","contactUs"
                                                ])
    init() {
        checkCurrentLanguage()
//        changeLanguage()
        getUserData()
        observeDidUpdatedUserData()
    }
    private func getUserData() {
        let userFullName = UserDefualtUtils.getFirstName() + " " + UserDefualtUtils.getLastName()
        fullName.accept(userFullName)
    }
    func setLanguage(language: String) {
       
//        MOLH.setLanguageTo(language)
//        UserDefualtUtils.setCurrentLang(lang: language)
//        DispatchQueue.main.async {
//        MOLH.reset(transition: .transitionCrossDissolve)
//
//        }
//        Localize.setCurrentLanguage(language)
//        didChangeLanguage.accept(())
    }
//    private func changeLanguage() {
//
//
//        isArabicTapped.asObservable().subscribe(onNext: {
//            MOLH.setLanguageTo("ar")
//            MOLH.reset()
//            UserDefualtUtils.setCurrentLang(lang: "ar")
//        }).disposed(by: disposeBag)
//        isEnglishTapped.asObservable().subscribe(onNext: {
//            MOLH.setLanguageTo("en")
//            MOLH.reset()
//            UserDefualtUtils.setCurrentLang(lang: "en")
//        }).disposed(by: disposeBag)
//
//    }
    private func checkCurrentLanguage() {
//        if UserDefualtUtils.isArabic(){
//            isArabic.accept(true)
//        }else {
//            isEnglish.accept(true)
//        }
    }
    func logout() {
        UserDefualtUtils.logout()
    }
    func deleteAccount() {
        isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.deleteAccount, responseType:BasicResponse<String>.self, method: .DELETE, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 && response.data ?? "" == "Deleted" {
                self?.logout()
                self?.didAccountDeleted.accept(())
            }else {
                print(response.error ?? "")
            }
        },onError: {error in
            self.isLoading.accept(false)
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func getUserInfo() {
        isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.userInfo, responseType:BasicResponse<UserInfo>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.userInfo.accept(response.data)
            }else {
                print(response.error ?? "")
            }
        },onError: {error in
            self.isLoading.accept(false)
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    private func observeDidUpdatedUserData() {
        let notificationName = Notification.Name("DID_UPDATE_USER_INFO")
        NotificationCenter.default.rx.notification(notificationName)
            .subscribe(onNext: { [weak self] notification in
                self?.getUserData()
            })
            .disposed(by: disposeBag)
    }
}

