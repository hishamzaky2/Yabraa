////
////  ServicesCoordinator.swift
////  Yabraa
////
////  Created by Hamada Ragab on 12/05/2023.
////
//
//import UIKit
//final class ServicesCoordinator: ChildCoordinator {
//    var viewControllerRef: UIViewController?
//    var parent: AppCoordinator?
//    var navigationController: UINavigationController
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start(animated: Bool) {
//        let serviceView = YBServicesView()
//        viewControllerRef = serviceView
//        serviceView.coordinator = self
//        navigationController.pushViewController(serviceView, animated: animated)
//    }
//    func coordinatorDidFinish() {
//        parent?.childDidFinish(self)
//    }
//    
//    func cleanUpZombieCoordinators() {
////        parent?.baseTabBarController?.cleanUpZombieCoordinators()
//    }
//}
