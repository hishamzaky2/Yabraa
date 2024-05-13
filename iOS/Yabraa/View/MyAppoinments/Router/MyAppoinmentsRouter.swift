//
//  MyAppoinmentsRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/07/2023.
//

import Foundation
protocol MyAppoinmentsRouterProtocol: AnyObject {
    func back()
    func goToAppointmentDetails(appointmentId: Int)
    func goToMedicalDescription(appointmentId: Int)
}
class MyAppoinmentsRouter {
    weak var viewController: MyAppoinmentsViewController?
    init(view: MyAppoinmentsViewController) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = MyAppoinmentsViewModel()
        viewController?.viewModel = viewModel
    }
}

extension MyAppoinmentsRouter:MyAppoinmentsRouterProtocol {
    func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    func goToAppointmentDetails(appointmentId: Int) {
        let editMyAppointmentVc = EditMyAppointmentViewController()
        EditMyAppointmentRouter(view: editMyAppointmentVc).start(appointmentId: appointmentId)
        editMyAppointmentVc.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(editMyAppointmentVc, animated: true)
    }
    func goToMedicalDescription(appointmentId: Int) {
        let medicalDescriptionVC = MedicalDescriptionViewController()
        MedicalDescriptionRouter(view: medicalDescriptionVC).start(appointmentId: appointmentId)       
        medicalDescriptionVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(medicalDescriptionVC, animated: true)
    }
}
