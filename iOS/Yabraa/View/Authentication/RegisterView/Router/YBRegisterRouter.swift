//
//  YBRegisterRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 07/03/2023.
//

import Foundation
import UIKit
protocol RegisterRouterProtocol: AnyObject {
    func goToOtp(registerParameter: [String: String])
    func backToLogin()
    func routeToNationalitiyVC(nationalities: [NationalitiesData])
    func routeToHomeVC()
}
class YBRegisterRouter: BaseRouter {
    weak var view: YBRegisterView?
    init(view: YBRegisterView) {
        self.view = view
    }
    func start(userInfo: UserInfo?) {
        view?.router = self
        let viewModel = YBRegisterViewModel(userInfo: userInfo)
        view?.viewModel = viewModel
    }
}

extension YBRegisterRouter:RegisterRouterProtocol {
    func backToLogin() {
        view?.navigationController?.popViewController(animated: true)
    }
    func routeToNationalitiyVC(nationalities: [NationalitiesData]) {
       let nationalitiesVC = YBNationtioalitesViewController()
        YBNationalitiyRouter(view: nationalitiesVC).start(nationalities: nationalities)
       
        nationalitiesVC.delegate = view
        nationalitiesVC.modalPresentationStyle = .fullScreen
        view?.present(nationalitiesVC, animated: true)
    }
    func goToOtp(registerParameter: [String: String]) {
        let otpVC = YBOTPVerification()
        YBOTPVerificationRouter(view: otpVC).start(phone: nil, registerParameter: registerParameter)
        otpVC.modalPresentationStyle = .overFullScreen
        view?.present(otpVC, animated: true)
    }
    func routeToHomeVC() {
       let homeVC = TabBarViewController()
        YBTabBarRouter(view: homeVC).start()
        homeVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(homeVC, animated: true)
    }
}
