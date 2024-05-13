//
//  ServiceCheckingCoordinator.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/05/2023.
//

import UIKit
import SemiModalViewController
import RxCocoa
import RxSwift
protocol ServiceCheckingCoordinatorDelegate:AnyObject {
    func goToSelectDate()
    func goToSelectPatient()
    func routeToMapVC()
}
class ServiceCheckingCoordinator: BaseRouter {
     var view: YBServiceCheckingView?
    private let disposeBag = DisposeBag()

    func start(package: Packages)-> YBServiceCheckingView{
        let servciesDetailsVC = YBServiceCheckingView()
        let viewModel = ServiceCheckingViewModel(package: package)
        servciesDetailsVC.viewModel = viewModel
        self.view = servciesDetailsVC
        view?.coordinator = self
        return servciesDetailsVC
    }
    
}
extension ServiceCheckingCoordinator: ServiceCheckingCoordinatorDelegate{
    func goToSelectDate() {
//        let selectDateVC = DatesAndTimesCoordinator().start()
//        let options = [SemiModalOption.pushParentBack: false]
//        selectDateVC.view.frame = CGRect(x: 0, y: 0, width: (self.view?.view.bounds.width)!, height: 300)
////        selectDateVC.viewModel?.delegate = self.view
//        self.view?.presentSemiViewController(selectDateVC,options: options)
    }
    
    func goToSelectPatient() {
//        let selectPatientVC = PatientsCoodintaor().start()
//        let options = [SemiModalOption.pushParentBack: false]
//        selectPatientVC.view.frame = CGRect(x: 0, y: 0, width: (self.view?.view.bounds.width)!, height: 300)
//        selectPatientVC.viewModel?.selectedPatient.bind(to: (self.view?.viewModel!.selectedPatient)!).disposed(by: disposeBag)
//        self.view?.presentSemiViewController(selectPatientVC,options: options)
    }
    func routeToMapVC() {
//        let mapVC = MapCoodintaor().start()
//        mapVC.modalPresentationStyle = .fullScreen
//        self.view?.navigationController?.pushViewController(mapVC, animated: true)
    }
}
