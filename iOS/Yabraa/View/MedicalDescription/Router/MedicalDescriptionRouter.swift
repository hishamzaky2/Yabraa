//
//  MedicalDescriptionRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 19/11/2023.
//

import Foundation
protocol MedicalDescriptionRouterProtocol: AnyObject {
    func back()
}
class MedicalDescriptionRouter {
    weak var viewController: MedicalDescriptionViewController?
    init(view: MedicalDescriptionViewController) {
        self.viewController = view
    }
    func start(appointmentId: Int) {
        self.viewController?.router = self
        let viewModel = MedicalDescriptionViewModel(appointmentId: appointmentId)
        viewController?.viewModel = viewModel
    }
}

extension MedicalDescriptionRouter:MedicalDescriptionRouterProtocol {

    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

