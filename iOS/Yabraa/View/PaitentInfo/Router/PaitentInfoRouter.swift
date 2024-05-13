//
//  PaitentInfoRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/07/2023.
//

import Foundation
protocol PaitentInfoRouterProtocol: AnyObject {
    func back()
    func goToPackgeDetails(package: Packages)
    func goToSelectDate(package: Packages,dates: [DatesTimes])
    func goToSelectPatient(package: Packages)
    func routeToMapVC()
}
class PaitentInfoRouter {
    weak var viewController: PaitentInfoViewController?
    init(view: PaitentInfoViewController) {
        self.viewController = view
    }
    func start(updatedPatient: UserFamliy?) {
        self.viewController?.router = self
        let viewModel = PaitentInfoViewModel(updatedPatient: updatedPatient)
        viewController?.viewModel = viewModel
    }
}

extension PaitentInfoRouter:PaitentInfoRouterProtocol {
    func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    func goToPackgeDetails(package: Packages) {
        let packagesDetailsVC = YBPackageDetailsView()
        PackageDetailsRouter(view: packagesDetailsVC).start(package: package, isShowMore: false)
        packagesDetailsVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(packagesDetailsVC, animated: true)
    }
    func goToSelectDate(package: Packages,dates: [DatesTimes]) {
//        let selectDateVC = YBDatesAndTimesView()
//        DatesAndTimesCoordinator(view: selectDateVC).start(package: package, dates: dates)
//        selectDateVC.delegate = viewController
//        selectDateVC.modalPresentationStyle = .overFullScreen
//        self.viewController?.present(selectDateVC, animated: true)
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

