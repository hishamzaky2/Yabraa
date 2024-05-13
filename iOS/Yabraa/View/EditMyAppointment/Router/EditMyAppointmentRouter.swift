//
//  EditMyAppointmentRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/07/2023.
//

import Foundation
import SemiModalViewController

protocol EditMyAppointmentRouterProtocol: AnyObject {
    func back()
    func goToPackgeDetails(package: Packages)
    func goToEditAlert()
    func routeToMapVC()
}
class EditMyAppointmentRouter {
    weak var viewController: EditMyAppointmentViewController?
    init(view: EditMyAppointmentViewController) {
        self.viewController = view
    }
    func start(appointmentId: Int?) {
        self.viewController?.router = self
        let viewModel = EditMyAppointmentViewModel(appointmentId: appointmentId)
        viewController?.viewModel = viewModel
    }
}

extension EditMyAppointmentRouter:EditMyAppointmentRouterProtocol {
    func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    func goToPackgeDetails(package: Packages) {
        let packagesDetailsVC = YBPackageDetailsView()
        PackageDetailsRouter(view: packagesDetailsVC).start(package: package, isShowMore: false)
        packagesDetailsVC.modalPresentationStyle = .overCurrentContext
        viewController?.navigationController?.pushViewController(packagesDetailsVC, animated: true)
    }
    func goToEditAlert() {
        let editAlertVC = EditAlertViewController()
        editAlertVC.delegate = viewController
        editAlertVC.modalTransitionStyle = .crossDissolve
        editAlertVC.modalPresentationStyle = .overFullScreen
        self.viewController?.present(editAlertVC, animated: true)
    }
    func routeToMapVC() {
        let mapVC = YBMapView()
        mapVC.delegate = viewController
        MapCoodintaor(view: mapVC).start(isFromEditingAppointMent: true)
        mapVC.modalPresentationStyle = .fullScreen
        self.viewController?.navigationController?.pushViewController(mapVC, animated: true)
    }
}

