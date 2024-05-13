////
////  AppCoordinator.swift
////  Yabraa
////
////  Created by Hamada Ragab on 12/05/2023.
////
//
//import Foundation
//import UIKit
//
//final class AppCoordinator: NSObject, Coordinator, ParentCoordinator {
//    var childCoordinators = [Coordinator]()
//    var navigationController: UINavigationController
//    var baseTabBarController: YBTabBarView?
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start() {
//        baseTabBarController = YBTabBarView()
//        baseTabBarController!.coordinator = self
//        navigationController.pushViewController(baseTabBarController!, animated: true)
//    }
//    
//    func cleanUpMerch() {
////        baseTabBarController?.cleanUpMerch()
//    }
//}
