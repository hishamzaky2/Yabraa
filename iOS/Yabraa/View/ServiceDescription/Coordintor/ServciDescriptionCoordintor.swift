//
//  ServciDescriptionCoordintore.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/05/2023.
//

import UIKit
protocol ServciDescriptionCoordintorDelegate:AnyObject {
        func goToBack()
}
class ServciDescriptionCoordintor: BaseRouter {
     var view: YBServciDescriptionView?
    func start(package: Packages)-> YBServciDescriptionView{
        let servciesDetailsVC = YBServciDescriptionView()
        let viewModel = ServciDescriptionViewModel(package: package)
        servciesDetailsVC.viewModel = viewModel
        self.view = servciesDetailsVC
        view?.coordinator = self
        return servciesDetailsVC
    }
    
}
extension ServciDescriptionCoordintor: ServciDescriptionCoordintorDelegate{
    func goToBack() {
        self.dismissView(view: view)
    }
}
