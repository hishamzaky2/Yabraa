//
//  SceneDelegate.swift
//  Yabraa
//
//  Created by Hamada Ragab on 25/02/2023.
//

import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        createInitialView()
        
    }
    private func createInitialView() {
        let luanchView = YBLaunchView()
        YBLuanchRouter(view:luanchView).start()
//        let luanchView = YBOTPVerification()
//        YBOTPVerificationRouter(view: luanchView).start(phone: "3333", registerParameter: nil)
        let navigation = UINavigationController(rootViewController: luanchView)
        navigation.navigationBar.isHidden = true
        window?.rootViewController = navigation
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url{
            if url.scheme?.caseInsensitiveCompare("com.Yabraa-Medical-Center.Yabraa.payments") == .orderedSame {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
            }
            
        }
    }
    
}
//extension SceneDelegate: MOLHResetable {
//    func reset() {
//            let luanchView = TabBarViewController()
//            YBTabBarRouter(view:luanchView).start()
//            let navigation = UINavigationController(rootViewController: luanchView)
//            navigation.navigationBar.isHidden = true
//            window?.rootViewController = navigation
//            window?.makeKeyAndVisible()
//        chnageLoactization()
////        UICollectionView.appearance().semanticContentAttribute = MOLHLanguage.isArabic() ? .forceRightToLeft : .forceLeftToRight
//       
//    }
//    private func chnageLoactization() {
////       if UILabel.appearance().textAlignment != .center {
//        UIView.appearance().semanticContentAttribute = MOLHLanguage.isArabic() ? .forceRightToLeft : .forceLeftToRight
////       }else {
////           UILabel.appearance().textAlignment = .center
////       }
//    }
//}
