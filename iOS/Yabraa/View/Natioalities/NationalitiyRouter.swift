//
//  NationalitiyRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 17/06/2023.
//

import Foundation
class YBNationalitiyRouter: BaseRouter {
    weak var view: YBNationtioalitesViewController?
    init(view: YBNationtioalitesViewController) {
        self.view = view
    }
    func start(nationalities: [NationalitiesData]) {
        view?.router = self
        let viewModel = NatioalitiesViewModel()
        viewModel.Natioalities.accept(nationalities)
        view?.viewModel = viewModel
    }
    
    func backToLogin() {
        view?.dismiss(animated: true)
    }
//    func routeToNationalitiyVC() {
//       let homeVC = YBNationtioalitesViewController()
//        YBTabBarRouter(view: homeVC).start()
//        homeVC.modalPresentationStyle = .fullScreen
//        view?.navigationController?.pushViewController(homeVC, animated: true)
//    }
}

