//
//  EditAlertRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/07/2023.
//

import Foundation
protocol EditAlertRouterProtocol: AnyObject {
    func back()
}
class EditAlertRouter {
    weak var viewController: EditAlertViewController?
    init(view: EditAlertViewController) {
        self.viewController = view
    }
//    func start() {
//        self.viewController?.router = self
//
//    }
}

extension EditAlertRouter:EditAlertRouterProtocol {
    func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}

