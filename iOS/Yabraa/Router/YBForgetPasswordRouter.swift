//
//  YBForgetPasswordRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 07/03/2023.
//

import Foundation
class YBForgetPasswordRouter: BaseRouter {
    weak var view: YBForgetPasswordView?
    init(view: YBForgetPasswordView) {
        self.view = view
    }
    func start() {
        view?.router = self
    }
    func routeToVerificationVC(phone: String) {
       let verificationVC = YBOTPVerification()
        YBOTPVerificationRouter(view: verificationVC).start(phone: phone, registerParameter: nil)
        verificationVC.modalPresentationStyle = .fullScreen
        view?.present(verificationVC, animated: true)
    }
}
