//
//  MyPaymentsViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/07/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class MyPaymentsViewModel {
    let result = PublishSubject<[ResultData]>()
    let isLoading = BehaviorRelay<Bool>(value: false)
    let PaymentsData =  BehaviorRelay<[SectionModel<String, Items>]>(value: [])
    private let disposeBag = DisposeBag()
    init() {
      
        getMyPayments()
        configureDataSources()
    }
    private func getMyPayments() {
        isLoading.accept(true)
        NetworkServices.callAPI(withURL: URLS.paymentHistory, responseType:BasicResponse<Payments>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.result.onNext(response.data?.result ?? [])
            }else {
                print(response.error ?? "")
            }
        },onError: {error in
            self.isLoading.accept(false)
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func configureDataSources() {
        var sections: [SectionModel<String,Items>] = []
        result.subscribe(onNext: {[weak self] reslut in
            for resultData in reslut {
                sections.append(SectionModel(model: resultData.date ?? "", items: resultData.items ?? []))
            }
            self?.PaymentsData.accept(sections)
        }).disposed(by: disposeBag)
    }
    
}

