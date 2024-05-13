//
//  DatesAndTimesCoordinator.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit
import SemiModalViewController
protocol DatesAndTimesCoordinatorDelegate:AnyObject {
    func dismissView()
}
class DatesAndTimesCoordinator: BaseRouter {
     var view: YBDatesAndTimesView?
    init(view: YBDatesAndTimesView) {
        self.view = view
    }
    func start(package: Packages,dates: [DatesTimes]){
        let viewModel = DatesAndTimesViewModel(package: package, dates: dates)
        view?.viewModel = viewModel
        view?.coordinator = self
    }
    
}
extension DatesAndTimesCoordinator: DatesAndTimesCoordinatorDelegate{
    func dismissView() {
        self.view?.dismissSemiModalView()
    }
}
