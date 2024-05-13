//
//  NotificationDetailsRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 23/11/2023.
//

import Foundation
protocol NotificationDetailsRouterProtocol: AnyObject {
    func goToMedicalProfileView(PatientID: Int)
    func back()
}
class NotificationDetailsRouter {
    weak var viewController: NotificationDetailsViewController?
    init(view: NotificationDetailsViewController) {
        self.viewController = view
    }
    func start(notification:Notifications) {
        self.viewController?.router = self
        let viewModel = NotificationDetailsViewModel(notification: notification)
        viewController?.viewModel = viewModel
    }
}

extension NotificationDetailsRouter:NotificationDetailsRouterProtocol {
    func goToMedicalProfileView(PatientID: Int) {
        let medicalProfileView = MedicalProfileViewController()
        MedicalProfileRouter(view: medicalProfileView).start(PatientID: PatientID)
        viewController?.navigationController?.pushViewController(medicalProfileView, animated: true)
    }
    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

