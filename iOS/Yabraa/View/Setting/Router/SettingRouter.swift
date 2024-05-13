//
//  SettingRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/07/2023.
//

import Foundation
protocol SettingRouterProtocol: AnyObject {
    func goToAddPatient()
    func goToMyAppoinmentsView()
    func goToLoginView()
    func routeToRegisterVC(userInfo: UserInfo) 
    func goToMyPaymentsView()
    func goToPatientsProfileView()
    func routeToContactUsVC()
}
class SettingRouter {
    weak var viewController: YBSettingView?
    init(view: YBSettingView) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = SettingViewModel()
        viewController?.viewModel = viewModel
    }
}

extension SettingRouter:SettingRouterProtocol {
    func goToAddPatient() {
        let packagesDetailsVC = AddPatientViewController()
        AddPatientRouter(view: packagesDetailsVC).start()
        packagesDetailsVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(packagesDetailsVC, animated: true)
    }
    func goToLoginView() {
        let loginView = YBLogInView()
        YBLoginRouter(view: loginView).start()
        viewController?.navigationController?.pushViewController(loginView, animated: true)
    }
    func goToMyAppoinmentsView() {
        let myAppoinmentsView = MyAppoinmentsViewController()
        MyAppoinmentsRouter(view: myAppoinmentsView).start()
        viewController?.navigationController?.pushViewController(myAppoinmentsView, animated: true)
    }
    func goToPatientsProfileView() {
        let patientsProfileView = PatientsProfileViewController()
        PatientsProfileRouter(view: patientsProfileView).start()
        viewController?.navigationController?.pushViewController(patientsProfileView, animated: true)
    }
    func goToMyPaymentsView() {
        let myPaymentsView = MyPaymentsViewController()
        MyPaymentsRouter(view: myPaymentsView).start()
        viewController?.navigationController?.pushViewController(myPaymentsView, animated: true)
    }
    func routeToRegisterVC(userInfo: UserInfo) {
       let registerVC = YBRegisterView()
        YBRegisterRouter(view: registerVC).start(userInfo: userInfo)
        registerVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(registerVC, animated: true)
    }
    func routeToContactUsVC() {
       let contactUsVc = ContactUsViewController()
        ContactUsRouter(view: contactUsVc).start()
        contactUsVc.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(contactUsVc, animated: true)
    }

}




