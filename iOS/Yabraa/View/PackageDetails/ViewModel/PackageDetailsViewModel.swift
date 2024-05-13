//
//  PackageDetailsViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 22/06/2023.
//

import Foundation
import RxSwift
import RxCocoa
class PackageDetailsViewModel{
    let package = BehaviorRelay<Packages?>(value: nil)
    let isPackageAddedToSelectedPackages = BehaviorRelay<Bool>(value: false)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let selectedPackage = SelectedPackage.shared
    private let disposeBag = DisposeBag()
    var isShowMore = false
    init(isShowMore: Bool) {
        self.isShowMore = isShowMore
    }
   
    func checkIfPackageIsAddedToSeletedPackagesBefore() {
        guard let package = package.value else {return}
        if selectedPackage.isPackagedAddedBefore(package: package) {
            isPackageAddedToSelectedPackages.accept(true)
        }else {
            isPackageAddedToSelectedPackages.accept(false)
        }
    }
    func addPackageToSelectedPackages() {
        guard let package = package.value else {return}
        selectedPackage.addPackage(package: package)
    }
    func removePackageToSelectedPackages() {
        guard let package = package.value else {return}
        selectedPackage.removePackage(package: package)
    }
}
