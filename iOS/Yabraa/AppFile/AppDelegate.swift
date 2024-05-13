//
//  AppDelegate.swift
//  Yabraa
//
//  Created by Hamada Ragab on 25/02/2023.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import AppCenter
import AppCenterCrashes
import AppCenterAnalytics
import RxSwift
import FirebaseCore
import FirebaseMessaging
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let disposeBage = DisposeBag()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        registerForRemoteNotifications() 
        setUpConfigurations()
        setUpGoogleMap()
        setUpAppCenter()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme?.caseInsensitiveCompare("com.Yabraa-Medical-Center.Yabraa.payments") == .orderedSame {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
            return true
        }
        return false
    }
    
}

extension AppDelegate {
//    func reset() {
//        print("sssssS")
//        let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
//        rootViewController.rootViewController = UITableViewController()
//    }
    private func setUpConfigurations() {
//        MOLHLanguage.setDefaultLanguage("ar")
//        MOLH.shared.activate(true)
        IQKeyboardManager.shared.enable = true
        LocalizationManager.shared.delegate = self
        LocalizationManager.shared.setAppInnitLanguage()
//        UserDefualtUtils.setCurrentLang(lang: "ar")
    }
    private func setUpGoogleMap() {
        GMSServices.provideAPIKey("AIzaSyBeVjNeRlk_P9LWzOps0ypDasWh1rhuuNs")
        GMSPlacesClient.provideAPIKey("AIzaSyBeVjNeRlk_P9LWzOps0ypDasWh1rhuuNs")
    }
    private func setUpAppCenter(){
        AppCenter.start(withAppSecret: "3421cc52-5ea0-4ab0-a13c-e178425df968", services: [Analytics.self,Crashes.self])
    }
    
}
extension AppDelegate: LocalizationDelegate {
    func resetApp() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let luanchView = TabBarViewController()
            YBTabBarRouter(view:luanchView).start()
            let navigationController = UINavigationController(rootViewController: luanchView)
            navigationController.navigationBar.isHidden = true
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}

