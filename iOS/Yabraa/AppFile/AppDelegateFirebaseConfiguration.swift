//
//  AppDelegateFirebaseConfiguration.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/11/2023.
//

import Foundation
import RxCocoa
import RxSwift
import UserNotifications
import Firebase
extension AppDelegate: UNUserNotificationCenterDelegate {
    func registerForRemoteNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    private func sendFirebaseToken(token: String) {
        let parameters = ["FirebaseToken":token]
        NetworkServices.callAPI(withURL: URLS.sendFirebaseToken, responseType: BasicResponse<FireBaseTokenResponse>.self, method: .POST, parameters: parameters).subscribe(onNext: {response in
            if response.statusCode ?? 0 == 200 {
                UserDefualtUtils.setFirebaseToken(token: token)
            }
        }, onError: { error in
            print(error.localizedDescription)
        })
        .disposed(by: disposeBage)
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        if let token = Messaging.messaging().fcmToken {
            UserDefualtUtils.setFirebaseToken(token: token)
//            sendFirebaseToken(token: token)
        } else {
            print("FCM Token not available yet.")
        }
//        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
//        sendFirebaseToken(token: token)
//        print("Device token: \(token)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
        // Handle the received notification data here
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }

}
