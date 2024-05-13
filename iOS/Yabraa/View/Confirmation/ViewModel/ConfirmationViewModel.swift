//
//  ConfirmationViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import Foundation
import RxCocoa
import RxSwift
class ConfirmationViewModel {
    let disposeBage = DisposeBag()
    let selectedPackage = SelectedPackage.shared
    let packages = BehaviorRelay<[Packages]>(value: [])
    let totalPrice = BehaviorRelay<Int>(value: 0)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isSuccess = PublishRelay<Void>()
    let isFails = PublishRelay<String>()
    let checkoutID = PublishRelay<String>()
    let paymentMethods = BehaviorRelay<[PaymentMethodData]>(value: [])

    init() {
        viewDidLoad()
//        getPaymentMethods()
    }
    func viewDidLoad() {
        let savedPackages = selectedPackage.packages
        packages.accept(savedPackages)
        let totalPrice = savedPackages.reduce(0, {$0 + ($1.price ?? 0)})
        self.totalPrice.accept(totalPrice)
    }
    private func getPaymentMethods() {
        isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.PaymentsMethods, responseType: BasicResponse<PaymentMethodResponse>.self, method: .GET
                                , parameters: nil)
        .subscribe(onNext: { [weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.paymentMethods.accept(response.data?.result ?? [])
            }
        }, onError: { error in
            self.isLoading.accept(false)
            print(error.localizedDescription)
        })
        .disposed(by: disposeBage)
    }
    func didSelectPaymentMethod(paymentMethod: PaymentMethod) {
        pay(paymentID: paymentMethod.paymentMethodId)
    }
    func pay(paymentID: Int) {
        let savedPackages = selectedPackage.packages
        isLoading.accept(true)
        var  selectedPackages: [SelectedPackages] = []
        for package in savedPackages {
            selectedPackages.append(SelectedPackages(packageId: package.packageId ?? 0, userFamilyId: package.userId ?? 0, price: package.price ?? 0, notes: package.packageDescription, dateTime: package.serverDate))
        }
        let paymentRequest = paymentRequest(serviceTypeId: SelectedPackage.shared.serviceType,locationLongitude: selectedPackage.lng, locationLatitude: selectedPackage.lat, locationAltitude: selectedPackage.lat, totalPrice: totalPrice.value, currency: "SAR", paymentType: "DB", paymentMethodId: paymentID, packages: selectedPackages)
        let parameters = paymentRequest.toJosn()
        print(parameters)
        NetworkServices.callAPI(withURL: URLS.PAYMENT, responseType:BasicResponse<PaymentResponse>.self, method: .POST, parameters: parameters).subscribe(onNext: {[weak self] response in
            self?.didPaymentDone(response:response)
        },onError: { [weak self]error in
            self?.isLoading.accept(false)
            self?.isFails.accept(error.localizedDescription)
        }).disposed(by: disposeBage)
    }
    private func didPaymentDone(response:BasicResponse<PaymentResponse>) {
       isLoading.accept(false)
        if let statusCode =  response.statusCode, statusCode == 200, let checkoutId = response.data?.checkoutId {
            self.checkoutID.accept(checkoutId)
            isSuccess.accept(())
        }else {
            isFails.accept(response.error ?? "")
        }
    }
    func removeSelectedPackages() {
        selectedPackage.emptySelectedPackages()
    }
    func checkIfTransactionStatusCode(code: String) -> Bool {
        // pattern1 // pattern2 are regular expression for succeffully transaction
        let pattern1 = "^(000.000.|000.100.1|000.[36]|000.400.[1][12]0)"
        let pattern2 = "^(000.400.0[^3]|000.400.100)"
        do {
            let regex1 = try NSRegularExpression(pattern: pattern1, options: [])
            let regex2 = try NSRegularExpression(pattern: pattern2, options: [])
            let range = NSRange(location: 0, length: code.utf16.count)
            
            if regex1.firstMatch(in: code, options: [], range: range) != nil ||
               regex2.firstMatch(in: code, options: [], range: range) != nil {
                print("String matches one of the patterns.")
                return true
            } else {
                print("String does not match any of the patterns.")
                return false
            }
        } catch {
            print("Invalid regular expression: \(error.localizedDescription)")
            return false
        }
    }
    
//    func checkIfTransactionStatusCode(resultCode: String) -> PaymentCodeStatus {
//        // pattern1 // pattern2 are regular expression for succeffully transaction
//        let pattern1 = "^(000.000.|000.100.1|000.[36]|000.400.[1][12]0)"
//        let pattern2 = "^(000.400.0[^3]|000.400.100)"
//
//        let pattern1 = "^(000.000.|000.100.1|000.[36]|000.400.[1][12]0)"
//        let pattern2 = "^(000.400.0[^3]|000.400.100)"
//        if checkIfStringMatchesAnyExpression(string: resultCode, expressions: [pattern1,pattern2]) {
//            return .success
//        }else if checkIfStringMatchesAnyExpression(string: resultCode, expressions: [pattern1,pattern2]) {
//
//        }
//
//    }
//    func checkIfStringMatchesAnyExpression(string: String, expressions: [String]) -> Bool {
//        for expression in expressions {
//            do {
//                let regex = try NSRegularExpression(pattern: expression, options: [])
//                let range = NSRange(location: 0, length: string.utf16.count)
//                if let _ = regex.firstMatch(in: string, options: [], range: range) {
//                    return true // String matches the expression
//                }
//            } catch {
//                print("Error: \(error)")
//            }
//        }
//        return false // String doesn't match any expression or an error occurred
//    }

}
