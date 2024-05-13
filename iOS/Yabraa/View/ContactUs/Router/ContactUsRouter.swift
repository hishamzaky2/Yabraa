//
//  ContactUsRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 14/11/2023.
//

import Foundation
protocol ContactUsRouterProtocol: AnyObject {
    func back()
}
class ContactUsRouter {
    weak var viewController: ContactUsViewController?
    init(view: ContactUsViewController) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = ContactUsViewModel()
        viewController?.viewModel = viewModel
    }
}

extension ContactUsRouter:ContactUsRouterProtocol {

    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

