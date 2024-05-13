////
////  ProfileCoordinator.swift
////  Yabraa
////
////  Created by Hamada Ragab on 12/05/2023.
////
//
//import UIKit
//final class ProfileCoordinator: ChildCoordinator {
//    var viewControllerRef: UIViewController?
//    var parent: AppCoordinator?
//    var navigationController: UINavigationController
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start(animated: Bool) {
//        let profileView = YBProfileView()
//        viewControllerRef = profileView
//        profileView.coordinator = self
//        navigationController.pushViewController(profileView, animated: animated)
//    }
//    func coordinatorDidFinish() {
//        parent?.childDidFinish(self)
//    }
//    
//    func cleanUpZombieCoordinators() {
////        parent?.baseTabBarController?.cleanUpZombieCoordinators()
//    }
//}
