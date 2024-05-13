//
//  HomeViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/04/2023.
//

import Foundation
import RxSwift
import RxCocoa
class HomeViewModel {
    let filteredServices = BehaviorRelay<[OneDimensionalService]>(value: [])
    let AllServices = BehaviorRelay<[OneDimensionalService]>(value: [])
    let Gallery = BehaviorRelay<[String]>(value: [])
    let servicePackages = PublishSubject<OneDimensionalService>()
    let isLoading = BehaviorRelay<Bool>(value: false)
    private let selectedPackage = SelectedPackage.shared
    private var _tableViewDataSources: BehaviorSubject<[TableViewDataSources]> = BehaviorSubject(value: [])
    
    var tableViewDataSources: SharedSequence<DriverSharingStrategy, [TableViewDataSources]> {
        return _tableViewDataSources.asDriver(onErrorJustReturn: [])
    }
    private let disposeBag = DisposeBag()
    var sections: [TableViewDataSources] = [] {
        didSet {
            self._tableViewDataSources.onNext(sections.sorted(by: { $0.weight < $1.weight }))
        }
    }
    init() {
        callHomeVCApi()
        configureDataSources()
    }
    
    private func callHomeVCApi() {
        getGallery()
        getServiceDetails()
    }
    func configureDataSources() {
        
        Gallery.subscribe(onNext: {[weak self] gallery in
            if !gallery.isEmpty {
                self?.sections.append(TableViewDataSources.Gallery(title: "slider", items: [.Gallery(gallery)])) }
        }).disposed(by: disposeBag)
        filteredServices.filter{!$0.isEmpty}.subscribe(onNext: {[weak self]  services in
            self?.sections.append(TableViewDataSources.Services(title: "Service", items: [.Services(services)]))
        }).disposed(by: disposeBag)
    }
    
    private func getGallery() {
        NetworkServices.callAPI(withURL: URLS.GALLERY, responseType: BasicResponse<Gallery>.self, method: .GET
                                , parameters: nil)
        .subscribe(onNext: { response in
            if response.statusCode ?? 0 == 200 {
                self.Gallery.accept(response.data?.galleryImages ?? [])
            }
        }, onError: { error in
            print(error.localizedDescription)
        })
        .disposed(by: disposeBag)
    }
    private func getServiceDetails() {
        isLoading.accept(true)
        let url = URLS.SERVICES_DETAILS + "\(ServicesType.HomeVisit.rawValue)"
        NetworkServices.callAPI(withURL: url, responseType: BasicResponse<ServicesDetails>.self, method: .GET
                                , parameters: nil)
        .subscribe(onNext: { [weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                var services = response.data?.oneDimensionalService ?? []
                for i in 0..<services.count {
                    services[i].chnageServiceType(servicesType: .HomeVisit)
                }
                self?.filteredServices.accept(services)
                self?.AllServices.accept(services)
            }
        }, onError: { error in
            self.isLoading.accept(false)
            print(error.localizedDescription)
        })
        .disposed(by: disposeBag)
    }
    func search(query: String) {
        self.sections.removeAll(where: { section in
            section.title == "Service"
        })
        if query.isEmpty {
            self.filteredServices.accept(AllServices.value)
        }else {
            let searchedData = self.AllServices.value.filter{ service in
                let nationalityName =  UserDefualtUtils.isArabic() ? (service.nameAR ?? "") : (service.nameEN ?? "")
                return nationalityName.lowercased().contains(query.lowercased())
            }
            self.filteredServices.accept(searchedData )
        }
    }
    func getPackagesAt(Index: Int) {
        let selectedService = filteredServices.value[Index]
        servicePackages.onNext(selectedService)
    }
    func didSelectServices(service: OneDimensionalService){
        selectedPackage.serviceImage = service.imagePath ?? ""
        selectedPackage.serviceTitle = UserDefualtUtils.isArabic() ? (service.nameAR ?? "") : (service.nameEN ?? "")
    }
}
