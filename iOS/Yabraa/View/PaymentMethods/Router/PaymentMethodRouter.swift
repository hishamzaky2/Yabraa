//
//  PaymentMethodRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 03/08/2023.
//

import Foundation
protocol PaymentMethodRouterProtocol: AnyObject {
    func dismiss()
}
class PaymentMethodRouter {
    weak var viewController: PaymentMethodsViewController?
    init(view: PaymentMethodsViewController) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = PaymentMethodsViewModel()
        viewController?.viewModel = viewModel
    }
}
extension PaymentMethodRouter :PaymentMethodRouterProtocol {
    func dismiss() {
       print("")
    }
    
    
}
