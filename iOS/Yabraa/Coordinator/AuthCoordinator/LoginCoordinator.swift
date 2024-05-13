////
////  LoginCoordinator.swift
////  Yabraa
////
////  Created by Hamada Ragab on 13/05/2023.
////
//
//import UIKit
//final class LoginCoordinator: ChildCoordinator {
//    var viewControllerRef: UIViewController?
//    var parent: AppCoordinator?
//    var navigationController: UINavigationController
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    func start() {
//        let loginView = YBLogInView()
//        viewControllerRef = loginView
//        loginView.coordinator = self
//        navigationController.pushViewController(loginView, animated: true)
//        
//    }
//    func coordinatorDidFinish() {
//        parent?.childDidFinish(self)
//    }
//    func cleanUpZombieCoordinators() {
//        //        parent?.baseTabBarController?.cleanUpZombieCoordinators()
//    }
//}
