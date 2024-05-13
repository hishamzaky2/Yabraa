//
//  ServiceCheckingViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
class ServiceCheckingViewModel{
    let packgae = BehaviorRelay<Packages?>(value: nil)
    let selectedDate = PublishRelay<String>()
    let selectedTime = PublishRelay<String>()
    let selectedPatient = PublishRelay<String>()
    let isAllDataValid = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    init(package: Packages) {
        self.packgae.accept(package)
        Observable.combineLatest(selectedDate.asObservable(), selectedTime.asObservable(),selectedPatient.asObservable()).map { (date, time,name) in
            return !(date.isEmpty || time.isEmpty || name.isEmpty)
        }.subscribe(onNext: {
            isValid in
            self.isAllDataValid.accept(isValid)
        }).disposed(by: disposeBag)
        
    }
     func savePackage() {
//        let package = SelectedPackage(date: selectedDate.value, time: selectedTime.value, price: packgae.value?.price ?? 0, patientName: selectedPatient.value, PackageName: packgae.value?.nameAR ?? "", id: packgae.value?.packageId ?? 0)
    }
}
