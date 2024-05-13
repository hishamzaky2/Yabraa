//
//  NotificationsRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 22/11/2023.
//

import Foundation
protocol NotificationsRouterProtocol: AnyObject {
    func goToNotificationDetails(notification: Notifications)
    func back()
}
class NotificationsRouter {
    weak var viewController: NotificationsViewController?
    init(view: NotificationsViewController) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = NotificationsViewModel()
        viewController?.viewModel = viewModel
    }
}

extension NotificationsRouter:NotificationsRouterProtocol {
    func goToNotificationDetails(notification: Notifications) {
        let notificationView = NotificationDetailsViewController()
        NotificationDetailsRouter(view: notificationView).start(notification: notification)
        viewController?.navigationController?.pushViewController(notificationView, animated: true)
    }
    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

