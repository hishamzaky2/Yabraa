//
//  ServicesDetailsRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/05/2023.
//

import Foundation
import UIKit
protocol ServicesDetailsDelegate: AnyObject {
    func goToServiceDescription(package: Packages)
    func goToSeviceChecking(package: Packages)
}
class ServicesDetailsRouter: BaseRouter {
    weak var view: YBServicesDetailsView?
    func start(service: OneDimensionalService)-> YBServicesDetailsView{
        let servciesDetailsVC = YBServicesDetailsView()
        let viewModel = ServicesDetailsViewModel()
        viewModel.oneDiamentionService.onNext(service)
        servciesDetailsVC.viewModel = viewModel
        self.view = servciesDetailsVC
        view?.router = self
        return servciesDetailsVC
    }
}
extension ServicesDetailsRouter: ServicesDetailsDelegate{
    func goToServiceDescription(package: Packages) {
        let servciesDescriptionVC = ServciDescriptionCoordintor().start(package: package)
        servciesDescriptionVC.delegate = view
        servciesDescriptionVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(servciesDescriptionVC, animated: true)
    }
    func goToSeviceChecking(package: Packages) {
        let servciesCheckingVC = ServiceCheckingCoordinator().start(package: package)
//        servciesCheckingVC.delegate = view
        servciesCheckingVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(servciesCheckingVC, animated: true)
    }
}
