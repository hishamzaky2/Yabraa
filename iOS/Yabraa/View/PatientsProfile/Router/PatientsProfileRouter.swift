//
//  PatientsProfileRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
protocol PatientsProfileRouterProtocol: AnyObject {
    func goToMedicalProfileView(PatientID: Int)
    func back()
}
class PatientsProfileRouter {
    weak var viewController: PatientsProfileViewController?
    init(view: PatientsProfileViewController) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = PatientsProfileViewModel()
        viewController?.viewModel = viewModel
    }
}

extension PatientsProfileRouter:PatientsProfileRouterProtocol {
    func goToMedicalProfileView(PatientID: Int) {
        let medicalProfileView = MedicalProfileViewController()
        MedicalProfileRouter(view: medicalProfileView).start(PatientID: PatientID)
        viewController?.navigationController?.pushViewController(medicalProfileView, animated: true)
    }
    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

