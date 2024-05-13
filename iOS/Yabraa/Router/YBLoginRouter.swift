//
//  YBLoginRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import Foundation
class YBLoginRouter {
    weak var view: YBLogInView?
    init(view: YBLogInView) {
        self.view = view
    }
    func start() {
        view?.router = self
    }
    func goToForgetPasswordView() {
        let forgetPasswordView = YBForgetPasswordView()
        YBForgetPasswordRouter(view: forgetPasswordView).start()
        view?.navigationController?.pushViewController(forgetPasswordView, animated: true)
    }
    func goToRegisterView() {
        let registerView = YBRegisterView()
        YBRegisterRouter(view: registerView).start(userInfo: nil)
        view?.navigationController?.pushViewController(registerView, animated: true)
    }
    func routeToHomeVC() {
       let homeVC = TabBarViewController()
        YBTabBarRouter(view: homeVC).start()
        homeVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(homeVC, animated: true)
    }
    func routeToRegisterVC() {
       let registerVC = YBRegisterView()
        YBRegisterRouter(view: registerVC).start(userInfo: nil)
        registerVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(registerVC, animated: true)
    }
    func routeToForgetPasswordVC() {
       let forgetPasswordVC = YBForgetPasswordView()
        YBForgetPasswordRouter(view: forgetPasswordVC).start()
        forgetPasswordVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(forgetPasswordVC, animated: true)
    }
}
