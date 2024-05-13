//
//  PatientsCoodintaor.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit
import SemiModalViewController
protocol PatientsCoodintaorDelegate:AnyObject {
    func dismissView()
}
class PatientsCoodintaor: BaseRouter {
     var view: YBPatientsView?
    func start(package: Packages)-> YBPatientsView{
        let patientsVC = YBPatientsView()
        let viewModel = PatientsViewModel(package: package)
        patientsVC.viewModel = viewModel
        self.view = patientsVC
        view?.coordinator = self
        return patientsVC
    }
    
}
extension PatientsCoodintaor: PatientsCoodintaorDelegate{
    func dismissView() {
        self.view?.dismiss(animated: true)
    }
}

