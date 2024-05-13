//
//  AddPatientRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/07/2023.
//

import Foundation
protocol AddPatientRouterProtocol: AnyObject {
    func back()
    func goToPackgeDetails(package: Packages)
    func goToAddNewPatient(updatedPatient: UserFamliy?)
    func goToSelectPatient(package: Packages)
    func routeToMapVC()
}
class AddPatientRouter {
    weak var viewController: AddPatientViewController?
    init(view: AddPatientViewController) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = AddPatientViewModel()
        viewController?.viewModel = viewModel
    }
}

extension AddPatientRouter:AddPatientRouterProtocol {
    func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    func goToPackgeDetails(package: Packages) {
        let packagesDetailsVC = YBPackageDetailsView()
        PackageDetailsRouter(view: packagesDetailsVC).start(package: package, isShowMore: false)
        packagesDetailsVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(packagesDetailsVC, animated: true)
    }
    func goToAddNewPatient(updatedPatient: UserFamliy?) {
        let newPatientVC = PaitentInfoViewController()
        PaitentInfoRouter(view: newPatientVC).start(updatedPatient: updatedPatient)
        newPatientVC.modalPresentationStyle = .overFullScreen
        viewController?.navigationController?.pushViewController(newPatientVC, animated: true)
    }
    
    func goToSelectPatient(package: Packages) {
//        let selectPatientVC = PatientsCoodintaor().start(package: package)
//        selectPatientVC.selectedPatientDelegate = viewController
//        selectPatientVC.modalPresentationStyle = .overFullScreen
//        self.viewController?.present(selectPatientVC, animated: true)
    }
    func routeToMapVC() {
//        let mapVC = YBMapView()
//        MapCoodintaor(view: mapVC).start()
//        mapVC.modalPresentationStyle = .fullScreen
//        self.viewController?.navigationController?.pushViewController(mapVC, animated: true)
    }
}

