//
//  NotificationDetailsViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 23/11/2023.
//

import Foundation
import RxSwift
import RxCocoa
class NotificationDetailsViewModel{
    private let disposeBag = DisposeBag()
    private var notifications: Notifications?
    let notificationData = PublishSubject<Notifications?>()
    init(notification:Notifications) {
        self.notifications = notification
        readNotification()
    }
    func viewDidLoad() {
        notificationData.onNext(notifications)
    }
    
    private func readNotification() {
        if notifications?.isRead ?? false {
            let url = URLS.ReadNotification + String(notifications?.notificationId ?? 0)
            NetworkServices.callAPI(withURL: url, responseType:BasicResponse<Notifications>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
                if response.statusCode == 200 {
                    print("Success")
                }
            },onError: {error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
        }
        
    }
    
    
}
