//
//  PaymentMethodsViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 03/08/2023.
//

import Foundation
import RxSwift
import RxCocoa
enum PaymentsIds: Int {
    case Visa = 3
    case Mada = 9
    case Master = 5
    case Stc = 11
    case Apple = 2
}
class PaymentMethodsViewModel {
    let paymentMethods = BehaviorRelay<[PaymentMethod]>(value: [])
    let disposeBag = DisposeBag()
    init() {
        let paymentMethods = [
            PaymentMethod(shownName: "Visa", name: "VISA", image: "visa", paymentMethodId: PaymentsIds.Visa.rawValue),
            PaymentMethod(shownName: "Mada", name: "MADA", image: "mada", paymentMethodId: PaymentsIds.Mada.rawValue),
            PaymentMethod(shownName: "Master", name: "MASTER", image: "masterCard", paymentMethodId: PaymentsIds.Master.rawValue),
            PaymentMethod(shownName: "Stc", name: "STC_PAY", image: "stc", paymentMethodId: PaymentsIds.Stc.rawValue),
            PaymentMethod(shownName: "Apple", name: "APPLEPAY", image: "apple", paymentMethodId: PaymentsIds.Apple.rawValue)
        ]
        self.paymentMethods.accept(paymentMethods)
    }
    
}
