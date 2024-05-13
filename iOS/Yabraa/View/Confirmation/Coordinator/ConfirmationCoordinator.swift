//
//  Confirmation.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import Foundation

import UIKit
protocol ConfirmationRouterDelegate:AnyObject {
    func back()
    func backToHome()
    func goToPaymentMethods()
} 
class ConfirmationRouter: BaseRouter {
    weak var view: YBConfirmationView?
    init(view: YBConfirmationView) {
        self.view = view
    }
    func start(){
        let viewModel = ConfirmationViewModel()
        self.view?.viewModel = viewModel
        view?.router = self
    }
   
    
}
extension ConfirmationRouter: ConfirmationRouterDelegate{
    func back() {
        view?.navigationController?.popViewController(animated: true)
    }
    func backToHome() {
        view?.navigationController?.popToViewController(YBHomeViewController(), animated: true)
    }
    func goToPaymentMethods() {
        let PaymentMethodsVC = PaymentMethodsViewController()
        PaymentMethodsVC.delegate = view
        PaymentMethodRouter(view: PaymentMethodsVC).start()
        PaymentMethodsVC.modalTransitionStyle = .crossDissolve
        PaymentMethodsVC.modalPresentationStyle = .overFullScreen
        self.view?.present(PaymentMethodsVC, animated: true)
    }
}

