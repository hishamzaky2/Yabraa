//
//  RemoteVisitRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 27/08/2023.
//

import Foundation
protocol RemoteVisitProtocol {
    func goToPackges(service: OneDimensionalService)

}
class RemoteVisitRouter {
    
    weak var viewController: RemoteVisitViewController?
    init(view: RemoteVisitViewController) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = RemoteVisitViewModel()
        viewController?.viewModel = viewModel
    }
}
extension RemoteVisitRouter: RemoteVisitProtocol {
    func goToPackges(service: OneDimensionalService) {
        let packagesVC = YBPackagesView()
        PackagesRouter(view: packagesVC).start(service: service)
        packagesVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(packagesVC, animated: true)
    }
}
