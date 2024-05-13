//
//  NotificationsViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 22/11/2023.
//

import Foundation
import RxSwift
import RxCocoa
class NotificationsViewModel{
    private let disposeBag = DisposeBag()
    let notifications = BehaviorRelay<[Notifications]>(value: [])
    let isLoading = PublishSubject<Bool>()
    private var pageNumber = 1
    private var pagesCount = 0
    private var isGetingMoreNotifications = false
    init() {
        
    }
    func viewDidLoad() {
        isLoading.onNext(true)
        getNotification()
    }
    func loadMoreNotifications(){
        pageNumber += 1
        if pagesCount >= pageNumber && !isGetingMoreNotifications {
            isGetingMoreNotifications = true
            getNotification()
        }
    }
    private func getNotification() {
        let url = URLS.Notifications + String(pageNumber)
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<NotificationData>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.didGetNotifications(notificationData: response.data)
        },onError: {error in
            self.isGetingMoreNotifications = false
            self.isLoading.onNext(false)
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
        
    }
    private func didGetNotifications(notificationData: NotificationData?) {
        isLoading.onNext(false)
        isGetingMoreNotifications = false
        self.pageNumber = notificationData?.pageNumber ?? 0
        self.pagesCount = notificationData?.count ?? 0
        var olderNotifications = notifications.value
        olderNotifications.append(contentsOf: notificationData?.notifications ?? [])
        self.notifications.accept(olderNotifications)
    }
    func didSelectNotification(notification: Notifications) {
        var notifications = self.notifications.value
        if let index =  notifications.firstIndex(where: {$0.notificationId == notification.notificationId}) {
            notifications[index].isRead = true
            self.notifications.accept(notifications)
        }
    }
    
}
