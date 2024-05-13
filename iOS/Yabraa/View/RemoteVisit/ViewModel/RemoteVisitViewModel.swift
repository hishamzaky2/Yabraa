//
//  HomeVisitViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 27/08/2023.
//

import Foundation
import RxSwift
import RxCocoa
class RemoteVisitViewModel {
    let homeVisits = BehaviorRelay<[OneDimensionalService]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    init() {
//        getHomeVisitsService()
    }
    private func getHomeVisitsService() {
        isLoading.accept(true)
        let url = URLS.SERVICES_DETAILS + "\(ServicesType.RemoteDoctor.rawValue)"
        NetworkServices.callAPI(withURL: url, responseType: BasicResponse<ServicesDetails>.self, method: .GET
                                , parameters: nil)
        .subscribe(onNext: { [weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                var services = response.data?.oneDimensionalService ?? []
                for i in 0..<services.count {
                    services[i].chnageServiceType(servicesType: .RemoteDoctor)
                }
                self?.homeVisits.accept(services)
            }
        }, onError: { error in
            self.isLoading.accept(false)
            print(error.localizedDescription)
        })
        .disposed(by: disposeBag)
    }
}
