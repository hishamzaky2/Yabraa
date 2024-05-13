//
//  DiseasesRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
protocol DiseasesRouterProtocol: AnyObject {
    func goToMedicalProfileView()
    func back()
}
class DiseasesRouter {
    weak var viewController: DiseasesViewController?
    init(view: DiseasesViewController) {
        self.viewController = view
    }
    func start(PatientID: Int, disease: Diseases) {
        self.viewController?.router = self
        let viewModel = DiseasesViewModel(PatientID: PatientID, disease: disease)
        viewController?.viewModel = viewModel
    }
}

extension DiseasesRouter:DiseasesRouterProtocol {
    func goToMedicalProfileView() {
//        let medicalProfileView = MedicalProfileViewController()
//        MedicalProfileRouter(view: medicalProfileView).start()
//        viewController?.navigationController?.pushViewController(medicalProfileView, animated: true)
    }
    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

