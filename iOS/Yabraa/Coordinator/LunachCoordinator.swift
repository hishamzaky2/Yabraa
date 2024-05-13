////
////  LunachCoordinator.swift
////  Yabraa
////
////  Created by Hamada Ragab on 13/05/2023.
////
//
//import UIKit
//final class LunachCoordinator: ChildCoordinator {
//    var viewControllerRef: UIViewController?
//    var parent: AppCoordinator?
//    var navigationController: UINavigationController
//    var window: UIWindow?
//    init(navigationController: UINavigationController,window: UIWindow) {
//        self.navigationController = navigationController
//        self.window = window
//    }
//    func start() {
//        let launchView = YBLaunchView()
//        viewControllerRef = launchView
//        launchView.coordinator = self
//        navigationController.navigationBar.isHidden = true
//        navigationController.pushViewController(launchView, animated: true)
//        window?.rootViewController = navigationController
//        window?.overrideUserInterfaceStyle = .light
//        window?.makeKeyAndVisible()
//        
//    }
//    func coordinatorDidFinish() {
//        parent?.childDidFinish(self)
//    }
//    func login() {
//        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
//        loginCoordinator.parent = parent
//        addChild(loginCoordinator)
//        loginCoordinator.start()
//    }
//
//    func cleanUpZombieCoordinators() {
//        //        parent?.baseTabBarController?.cleanUpZombieCoordinators()
//    }
//}
