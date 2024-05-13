////
////  SettingCoordinator.swift
////  Yabraa
////
////  Created by Hamada Ragab on 12/05/2023.
////
//
//import UIKit
//final class SettingCoordinator: ChildCoordinator {
//    var viewControllerRef: UIViewController?
//    var parent: AppCoordinator?
//    var navigationController: UINavigationController
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start(animated: Bool) {
//        let settingView = YBSettingView()
//        viewControllerRef = settingView
//        settingView.coordinator = self
//        navigationController.pushViewController(settingView, animated: animated)
//    }
//    func coordinatorDidFinish() {
//        parent?.childDidFinish(self)
//    }
//    
//    func cleanUpZombieCoordinators() {
////        parent?.baseTabBarController?.cleanUpZombieCoordinators()
//    }
//}
