//
//  MyPaymentsRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/07/2023.
//

import Foundation
protocol MyPaymentsRouterProtocol: AnyObject {
    func back()
}
class MyPaymentsRouter {
    weak var viewController: MyPaymentsViewController?
    init(view: MyPaymentsViewController) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = MyPaymentsViewModel()
        viewController?.viewModel = viewModel
    }
}

extension MyPaymentsRouter:MyPaymentsRouterProtocol {
    func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
