//
//  PackagesViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 19/06/2023.
//

import Foundation
import RxSwift
import RxCocoa
class PackagesViewModel {
    let filter = BehaviorRelay<[Filters]>(value: [])
    let packages = BehaviorRelay<[Packages]>(value: [])
    let filteredPackages = BehaviorRelay<[Packages]>(value: [])
    let service = PublishRelay<OneDimensionalService>()
    let serviceTitle = BehaviorRelay<String?>(value: "")
    let clearFilter = PublishRelay<Void>()
    let hideConfirmingView = PublishRelay<Bool>()
    let disposeBag = DisposeBag()
    let selectedPackage = SelectedPackage.shared
    init() {
        viewDidLoad()
        bindData()
        
    }
    
    func filterPackage(filter: Filters?) {
        var fillllters = self.filter.value
        if let filter = filter, !filter.isSelected {
            if let index = fillllters.firstIndex(where: { filter_data in
                filter_data.filterId == filter.filterId
            }) {
                fillllters[index].isSelected = true
                var filterPackages: [Packages] = []
                let selected_fillllters = fillllters.filter{$0.isSelected}
                for selected_filter in selected_fillllters {
                    let packages = self.packages.value.filter({$0.filterId == selected_filter.filterId})
                    filterPackages.append(contentsOf: packages)
                }
                self.filter.accept(fillllters)
                self.filteredPackages.accept(filterPackages)
            }
        }
    }
    func removeFilter(filter: Filters?) {
        var fillllters = self.filter.value
        if var filter = filter, filter.isSelected {
            if let index = fillllters.firstIndex(where: { filter_data in
                filter_data.filterId == filter.filterId
            }) {
                fillllters[index].isSelected = false
                var filterPackages: [Packages] = []
                let selected_fillllters = fillllters.filter{$0.isSelected}
                for selected_filter in selected_fillllters {
                    let packages = self.packages.value.filter({$0.filterId == selected_filter.filterId})
                    filterPackages.append(contentsOf: packages)
                }
                self.filter.accept(fillllters)
                if selected_fillllters.count > 0 {
                    self.filteredPackages.accept(filterPackages)
                }else {
                    self.filteredPackages.accept(self.packages.value)
                }
            }
        }
    }
    func emptySelectedPackages() {
        selectedPackage.emptySelectedPackages()
    }
    private func bindData() {
        clearFilter.subscribe(onNext: { [weak self] _ in
            var currentFilters = self?.filter.value ?? []
            
            for index in 0..<currentFilters.count {
                currentFilters[index].isSelected = false
            }
            self?.filter.accept(currentFilters)
            self?.filteredPackages.accept(self?.packages.value ?? [])
        }).disposed(by: disposeBag)
    }
    private func viewDidLoad() {
        service.asObservable().subscribe(onNext: { [weak self]
            service in
            self?.selectedPackage.serviceType = service.servicesType
            self?.serviceTitle.accept(UserDefualtUtils.isArabic() ? service.nameAR : service.nameEN)
            self?.filter.accept(service.filters ?? [])
            let allFilters = service.filters.flatMap { $0 }
            let allPackages = allFilters?.compactMap { $0.packages }.flatMap { $0 }
            self?.packages.accept(allPackages ?? [])
            self?.filteredPackages.accept(allPackages ?? [])
        }).disposed(by: disposeBag)
    }
    func removeAllSelectedPakagse() {
        selectedPackage.removeAllSavedPackage()
        hideConfirmingView.accept(true)
        var filterPackages = self.filteredPackages.value
        var allPackages = self.packages.value
        for index in 0..<filterPackages.count {
            filterPackages[index].isSelected = false
        }
        for index in 0..<allPackages.count {
            allPackages[index].isSelected = false
        }
        self.filteredPackages.accept(allPackages)
        self.packages.accept(allPackages)
    }
    func checkSelectedPackages() {
        let selectedPackages = selectedPackage.packages
        selectedPackages.count > 0 ? hideConfirmingView.accept(false) : hideConfirmingView.accept(true)
        var filterPackages = self.filteredPackages.value
        var allPackages = self.packages.value
        for index in 0..<filterPackages.count {
            if selectedPackages.contains(where: {selected in
                selected.packageId == filterPackages[index].packageId
            }) {
                filterPackages[index].isSelected = true
            }else {
                filterPackages[index].isSelected = false
            }
        }
        for index in 0..<allPackages.count {
            if selectedPackages.contains(where: {selected in
                selected.packageId == allPackages[index].packageId
            }) {
                allPackages[index].isSelected = true
            }else {
                allPackages[index].isSelected = false
            }
        }
        self.filteredPackages.accept(filterPackages)
        self.packages.accept(allPackages)
    }
    func getStringWidthAtIndex(index: Int) -> CGFloat? {
        let curentFilter = filter.value
        if curentFilter.count > 0 {
            let packageName = UserDefualtUtils.isArabic() ? curentFilter[index].nameAR ?? "" : curentFilter[index].nameEN ?? ""
            var widthOfPackageName = packageName.widthOfString(usingFont: UIFont(name: "Arial-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0))
            if curentFilter[index].isSelected {
                widthOfPackageName += 20.0
            }
            return widthOfPackageName
        }
        return nil
    }
}
