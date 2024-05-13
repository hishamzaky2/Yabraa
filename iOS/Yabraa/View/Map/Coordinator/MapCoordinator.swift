//
//  MapCoordinator.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import Foundation
import UIKit
protocol MapCoodintaorDelegate:AnyObject {
    func back()
    func goToConfirmation()
}
class MapCoodintaor: BaseRouter {
    weak var view: YBMapView?
    init(view: YBMapView) {
        self.view = view
    }
    func start(isFromEditingAppointMent: Bool){
        let viewModel = MapViewModel(isFromEditingAppointMent: isFromEditingAppointMent)
        view?.viewModel = viewModel
        view?.coordinator = self
    }
}
extension MapCoodintaor: MapCoodintaorDelegate{
    func goToConfirmation() {
        let confirmationVC = YBConfirmationView()
        confirmationVC.delegate = view
        ConfirmationRouter(view: confirmationVC).start()
        confirmationVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(confirmationVC, animated: true)
    }
    func back() {
        self.view?.navigationController?.popViewController(animated: true)
    }
}

