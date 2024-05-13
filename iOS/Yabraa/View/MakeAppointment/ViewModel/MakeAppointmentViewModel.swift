//
//  MakeAppointmentViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 23/06/2023.
//

import Foundation
import RxSwift
import RxCocoa
class MakeAppointmentViewModel {
    let packages = BehaviorRelay<[Packages]>(value: [])
    let selectedPackage = SelectedPackage.shared
    let selectedIndex = BehaviorRelay<Int?>(value: nil)
    let packageDescription = PublishRelay<String>()
    let selectedDateAndTime = PublishRelay<String>()
    let selectedeAndTime = PublishRelay<Void>()
    var dates: [DatesTimes] = []
    var messageError = PublishRelay<String>()
    var didValidatePackages = PublishRelay<Void>()
    let canSelectPatient = BehaviorRelay<Bool>(value: true)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let disposeBage = DisposeBag()
    let serviceName = PublishSubject<String>()
    var serviceImage = ""
    let didCancelPackage = PublishSubject<Bool>()
    init() {
        serviceImage = selectedPackage.serviceImage
        getDates()
        getUsersFamliy()
        
    }
    func viewDidLoad() {
        serviceName.onNext(selectedPackage.serviceTitle)
    }
    func didGetUsers() {
        let userFamily = selectedPackage.users
        if userFamily.count == 1 {
            for i in 0..<selectedPackage.packages.count{
                selectedPackage.packages[i].userId = userFamily.first?.userFamilyId ?? 0
                selectedPackage.packages[i].patientName = userFamily.first?.name ?? ""
            }
            canSelectPatient.accept(false)
        }
        packages.accept(selectedPackage.packages)
    }
    func setDescriptionToPackage(description: String, index: Int) {
        selectedPackage.packages[index].packageDescription = description
    }
    private func getDates() {
        isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.SERVICES_DATES, responseType: BasicResponse<[DatesTimes]>.self, method: .GET
                                , parameters: nil)
        .subscribe(onNext: { [weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.dates = response.data ?? []
            }
        }, onError: { error in
            self.isLoading.accept(false)
            print(error.localizedDescription)
        })
        .disposed(by: disposeBage)
    }
    private func getUsersFamliy() {
        isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.userFamily, responseType:BasicResponse<[UserFamliy]>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.selectedPackage.users = response.data ?? []
                self?.didGetUsers()
            }else {
                print(response.error ?? "")
            }
        },onError: {error in
            self.isLoading.accept(false)
            print(error.localizedDescription)
        }).disposed(by: disposeBage)
    }
    func checkAllPackagesAreValidated() {
        if let packageWithNoPatientNameOrDate = selectedPackage.packages.filter({package in
            package.patientName.isEmpty || package.date.isEmpty
        }).first {
            let packageName = UserDefualtUtils.isArabic() ? packageWithNoPatientNameOrDate.nameAR ?? "" : packageWithNoPatientNameOrDate.nameEN ?? ""
            messageError.accept("Patient name and Date are required".localized +  " \(packageName)")
        }else {
            didValidatePackages.accept(())
        }
    }
    func cancelPackage() {
        selectedPackage.removeAllSavedPackage()
        didCancelPackage.onNext(true)
    }
}
