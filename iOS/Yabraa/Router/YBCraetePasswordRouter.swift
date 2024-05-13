//
//  YBCraetePasswordRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 07/03/2023.
//

import Foundation
import SemiModalViewController
protocol YBCraetePasswordRouterProtocol: AnyObject {
    func back()
    func routeToLoginVC()
}
class YBCraetePasswordRouter: BaseRouter {
    weak var view: YBCreatePasswordView?
    weak var optView: YBOTPVerification?
    init(view: YBCreatePasswordView, optView: YBOTPVerification?) {
        self.view = view
        self.optView = optView
    }
    func start() {
        view?.router = self
    }
}
extension YBCraetePasswordRouter:YBCraetePasswordRouterProtocol{
    func routeToLoginVC() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate else {return}
        let loginVC = YBLogInView()
        YBLoginRouter(view: loginVC).start()
        loginVC.modalPresentationStyle = .fullScreen
        let navigation = UINavigationController(rootViewController: loginVC)
        navigation.navigationBar.isHidden = true
        sceneDelegate.window?.rootViewController = navigation
        sceneDelegate.window?.makeKeyAndVisible()
    }
    func back() {
        view?.dismiss(animated: true)
//        view?.navigationController?.popViewController(animated: true)
    }
}
