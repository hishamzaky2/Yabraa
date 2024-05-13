//
//  YBOTPVerificationRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 07/03/2023.
//

import Foundation
import SemiModalViewController
protocol YBOTPVerificationProtocol: AnyObject {
    func back()
    func goToChnagePasswordView()
    func routeToSuccessVC()
}
class YBOTPVerificationRouter:BaseRouter {
    weak var view: YBOTPVerification?
    init(view: YBOTPVerification) {
        self.view = view
    }
    func start(phone: String?, registerParameter: [String: String]?) {
        view?.router = self
        view?.viewModel = YBVerificationViewModel(phone: phone, registerParameter: registerParameter)
    }
    
    
}
extension YBOTPVerificationRouter: YBOTPVerificationProtocol{
    func goToChnagePasswordView() {
        let chnagePasswordView = YBCreatePasswordView()
        YBCraetePasswordRouter(view: chnagePasswordView, optView: view).start()
        chnagePasswordView.modalPresentationStyle = .fullScreen
        view?.present(chnagePasswordView, animated: true)
//        self.view?.navigationController?.pushViewController(chnagePasswordView, animated: true)
    }
    func back() {
        view?.dismiss(animated: true)
    }
    func routeToSuccessVC() {
       let successVC = SuccessRegisterViewController()
        YBSuccessRegisterRouter(view: successVC).start()
        successVC.modalPresentationStyle = .fullScreen
        view?.present(successVC, animated: true)
    }
}
