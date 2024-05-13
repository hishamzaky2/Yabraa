//
//  MakeAppointmentRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 23/06/2023.
//

import Foundation
import SemiModalViewController
protocol MakeAppointmentRouterProtocol: AnyObject {
    func back()
    func goToPackgeDetails(package: Packages)
    func goToSelectDate(package: Packages,dates: [DatesTimes])
    func goToSelectPatient(package: Packages)
    func routeToMapVC()
    func goToConfirmation()
//    func popUpView
}
class MakeAppointmentRouter {
    weak var viewController: MakeAppointmentView?
    init(view: MakeAppointmentView) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = MakeAppointmentViewModel()
        viewController?.viewModel = viewModel
    }
}

extension MakeAppointmentRouter:MakeAppointmentRouterProtocol {
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
        let selectDateVC = YBDatesAndTimesView()
        DatesAndTimesCoordinator(view: selectDateVC).start(package: package, dates: dates)
        selectDateVC.delegate = viewController
        selectDateVC.modalPresentationStyle = .overFullScreen
        selectDateVC.modalTransitionStyle = .coverVertical   
        self.viewController?.present(selectDateVC, animated: true)
    }
    
    func goToSelectPatient(package: Packages) {
        let selectPatientVC = PatientsCoodintaor().start(package: package)
        selectPatientVC.selectedPatientDelegate = viewController
        selectPatientVC.modalPresentationStyle = .overFullScreen
        self.viewController?.present(selectPatientVC, animated: true)
    }
    func routeToMapVC() {
        let mapVC = YBMapView()
        MapCoodintaor(view: mapVC).start(isFromEditingAppointMent: false)
        mapVC.modalPresentationStyle = .fullScreen
        self.viewController?.navigationController?.pushViewController(mapVC, animated: true)
    }
    func goToConfirmation() {
        let confirmationVC = YBConfirmationView()
//        confirmationVC.delegate = viewController
        ConfirmationRouter(view: confirmationVC).start()
        confirmationVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(confirmationVC, animated: true)
    }
}

