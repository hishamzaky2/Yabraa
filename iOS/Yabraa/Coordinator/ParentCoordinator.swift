////
////  ParentCoordinator.swift
////  Yabraa
////
////  Created by Hamada Ragab on 12/05/2023.
////
//
//import Foundation
//protocol ParentCoordinator: Coordinator {
//    var childCoordinators: [Coordinator] { get set }
//    func addChild(_ child: Coordinator?)
//    func childDidFinish(_ child: Coordinator?)
//}
//
//extension ParentCoordinator {
//    func addChild(_ child: Coordinator?){
//        if let _child = child {
//            childCoordinators.append(_child)
//        }
//    }
//    func childDidFinish(_ child: Coordinator?) {
//        for (index, coordinator) in childCoordinators.enumerated() {
//            if coordinator === child {
//                childCoordinators.remove(at: index)
//                break
//            }
//        }
//    }
//}
