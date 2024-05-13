//
//  MedicalProfileRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import Foundation
protocol MedicalProfileRouterProtocol: AnyObject {
    func goToDiseasesView(PatientID: Int, disease: Diseases) 
    func back()
}
class MedicalProfileRouter {
    weak var viewController: MedicalProfileViewController?
    init(view: MedicalProfileViewController) {
        self.viewController = view
    }
    func start(PatientID: Int) {
        self.viewController?.router = self
        let viewModel = MedicalProfileViewModel(PatientID: PatientID)
        viewController?.viewModel = viewModel
    }
}

extension MedicalProfileRouter:MedicalProfileRouterProtocol {
    func goToDiseasesView(PatientID: Int, disease: Diseases) {
        let diseasesView = DiseasesViewController()
        DiseasesRouter(view: diseasesView).start(PatientID: PatientID, disease: disease)
        viewController?.navigationController?.pushViewController(diseasesView, animated: true)
    }
    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

