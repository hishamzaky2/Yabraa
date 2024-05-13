//
//  ServicesDetailsViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
class ServicesDetailsViewModel {
    let fillter = BehaviorSubject<[Filters]>(value: [])
    let oneDiamentionService = PublishSubject<OneDimensionalService>()
    let packages = BehaviorSubject<[Packages]>(value: [])
    let filteredPackages = BehaviorSubject<[Packages]>(value: [])
    let selectedFiletr = PublishSubject<Int?>()
    let didTapOnClose = BehaviorRelay<Void>(value: ())
    let didSelectItem = PublishSubject<Int?>()
    let selectedPackage = PublishSubject<Packages>()

    private let disposeBag = DisposeBag()
    init() {
        viewDidLoad()
    }
    private func viewDidLoad() {
        oneDiamentionService.asObservable().subscribe(onNext: {
            service in
            self.fillter.onNext(service.filters ?? [])
            let allFilters = service.filters.flatMap { $0 }
            let allPackages = allFilters?.compactMap { $0.packages }.flatMap { $0 }
            self.packages.onNext(allPackages ?? [])
            self.filteredPackages.onNext(allPackages ?? [])
        }).disposed(by: disposeBag)
        selectedFiletr.subscribe(onNext: { filterId in
            self.fillter.map{$0.filter{$0.filterId == filterId}}.subscribe(onNext: { item in
                self.filteredPackages.onNext(item.first?.packages ?? [])
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        didTapOnClose.asObservable().subscribe { _ in
            do {
                try self.filteredPackages.onNext(self.packages.value())
            }catch {
                
            }
           
        }.disposed(by: disposeBag)
        didSelectItem.asObservable().subscribe(onNext: { index in
            guard let index = index else {return}
            do {
                
                self.selectedPackage.onNext(try self.packages.value()[index])
            }catch {
                
            }
            
        }) .disposed(by: disposeBag)
    }
    func clearSelectedPackage() {
        do {
            var selectedPackages = try filteredPackages.value()
            for index in 0..<selectedPackages.count {
                selectedPackages[index].isSelected = false
            }
            filteredPackages.onNext(selectedPackages)
        }catch {
            
        }
    }
}
