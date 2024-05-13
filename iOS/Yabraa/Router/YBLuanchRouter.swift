//
//  YBLuanchRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import Foundation
protocol YBLuanchRouterProtocol:AnyObject{
    func goToOnbordingView(onbordingData: [OnbordingData])
    func goToLoginView()
    func goToTabBarView()
}
class YBLuanchRouter: YBLuanchRouterProtocol {
   weak var view: YBLaunchView?
    init(view: YBLaunchView) {
        self.view = view
    }
    func start() {
        view?.router = self
    }
    func goToOnbordingView(onbordingData: [OnbordingData]) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate else {return}
        let onbordingView = YBIntroductionView()
        YBIntroductionRouter(view: onbordingView).start(onbordingData: onbordingData)
        onbordingView.modalPresentationStyle = .fullScreen
        let navigation = UINavigationController(rootViewController: onbordingView)
        navigation.navigationBar.isHidden = true
        sceneDelegate.window?.rootViewController = navigation
        sceneDelegate.window?.makeKeyAndVisible()
//        view?.navigationController?.pushViewController(onbordingView, animated: true)
    }
    func goToLoginView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate else {return}
        let loginView = YBLogInView()
        YBLoginRouter(view: loginView).start()
        loginView.modalPresentationStyle = .fullScreen
        let navigation = UINavigationController(rootViewController: loginView)
        navigation.navigationBar.isHidden = true
        sceneDelegate.window?.rootViewController = navigation
        sceneDelegate.window?.makeKeyAndVisible()
//        view?.navigationController?.pushViewController(loginView, animated: true)
    }
    func goToTabBarView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate else {return}
        let homeVC = TabBarViewController()
        YBTabBarRouter(view:homeVC).start()
        homeVC.modalPresentationStyle = .fullScreen
        let navigation = UINavigationController(rootViewController: homeVC)
        navigation.navigationBar.isHidden = true
        sceneDelegate.window?.rootViewController = navigation
        sceneDelegate.window?.makeKeyAndVisible()
//        let tabBarView = TabBarViewController()
//        YBTabBarRouter(view: tabBarView).start()
//        view?.navigationController?.pushViewController(tabBarView, animated: true)
        
    }
}
