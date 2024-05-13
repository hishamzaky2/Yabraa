//
//  SuccessSuccessRegisterRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 18/09/2023.
//

import Foundation
import UIKit
protocol SuccessRegisterRouterProtocol: AnyObject {
    func routeToHomeVC()
}
class YBSuccessRegisterRouter: BaseRouter {
    weak var view: SuccessRegisterViewController?
    init(view: SuccessRegisterViewController) {
        self.view = view
    }
    func start() {
        view?.router = self
    }
}

extension YBSuccessRegisterRouter:SuccessRegisterRouterProtocol {
    func routeToHomeVC() {
//        let homeVC = TabBarViewController()
//        YBTabBarRouter(view: homeVC).start()
//        homeVC.modalPresentationStyle = .fullScreen
//        view?.navigationController?.pushViewController(homeVC, animated: true)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate else {return}
        let homeVC = TabBarViewController()
        YBTabBarRouter(view:homeVC).start()
        homeVC.modalPresentationStyle = .fullScreen
        let navigation = UINavigationController(rootViewController: homeVC)
        navigation.navigationBar.isHidden = true
        sceneDelegate.window?.rootViewController = navigation
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
