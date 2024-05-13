//
//  PatientsViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
class PatientsViewModel {
    let patients = BehaviorRelay<[UserFamliy]>(value: [])
    var package: Packages?
    let savedPackages = SelectedPackage.shared
    init(package: Packages) {
        viewDidLoad()
        self.package = package
    }
    private func viewDidLoad() {
        self.patients.accept(savedPackages.users)
    }
    func didSelectPatientName(user: UserFamliy) {
        
        if var updatablePackage = savedPackages.packages.filter({$0.packageId == package?.packageId}).first {
            updatablePackage.patientName = user.name ?? ""
            updatablePackage.userId = user.userFamilyId ?? 0
           savedPackages.updatePackage(package: updatablePackage)
        }
    }
}
