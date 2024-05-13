//
//  PackagesRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 19/06/2023.
//

import Foundation
protocol PackagesRouterProtocol: AnyObject {
    func backToHome()
    func goToPackgeDetails(package: Packages,isReadMore: Bool)
    func goToMakeAppintMent()
}
class PackagesRouter {
    
    weak var viewController: YBPackagesView?
    init(view: YBPackagesView) {
        self.viewController = view
    }
    func start(service: OneDimensionalService) {
        self.viewController?.router = self
        let viewModel = PackagesViewModel()
        viewModel.service.accept(service)
        viewController?.viewModel = viewModel
    }
   
}

extension PackagesRouter:PackagesRouterProtocol {
    func backToHome() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    func goToPackgeDetails(package: Packages,isReadMore: Bool) {
        let packagesDetailsVC = YBPackageDetailsView()       
        PackageDetailsRouter(view: packagesDetailsVC).start(package: package, isShowMore: isReadMore)
        packagesDetailsVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(packagesDetailsVC, animated: true)
    }
    func goToMakeAppintMent() {
        let MakeAppointmentVC = MakeAppointmentView()
        MakeAppointmentRouter(view: MakeAppointmentVC).start()
        MakeAppointmentVC.delegate = viewController
        MakeAppointmentVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(MakeAppointmentVC, animated: true)
    }
}
