////
////  HoomeCoordinator.swift
////  Yabraa
////
////  Created by Hamada Ragab on 12/05/2023.
////
//
//import Foundation
//import UIKit
//
//final class HomeCoordinator: ChildCoordinator {
//    var viewControllerRef: UIViewController?
//    var parent: AppCoordinator?
//    var navigationController: UINavigationController
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start(animated: Bool) {
//        let homeView = YBHomwView()
//        viewControllerRef = homeView
//        homeView.coordinator = self
//        navigationController.pushViewController(homeView, animated: animated)
//    }
//    func coordinatorDidFinish() {
//        parent?.childDidFinish(self)
//    }
//    
//    func cleanUpZombieCoordinators() {
////        parent?.baseTabBarController?.cleanUpZombieCoordinators()
//    }
//}
////a
