//
//  NotificationsViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 22/11/2023.
//

import UIKit
import RxSwift
import RxCocoa
class NotificationsViewController: UIViewController {
    
    @IBOutlet weak var notificationTable: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    var router: NotificationsRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: NotificationsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        bindData()
        setUpUi()
        viewModel?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    private func setUpUi(){
        backBtn.imageView?.FlipImage()
    }
    private func bindData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        backBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
    private func setUpTableView() {
        registerTableViewCells()
        bindNotificationsData()
        didSelectNotifications()
        prefetchNotifications()
    }
    private func registerTableViewCells() {
        notificationTable.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        notificationTable.rx.setDelegate(self).disposed(by: disposeBag)
       
    }
    private func bindNotificationsData() {
        viewModel?.notifications.bind(to: notificationTable.rx.items(cellIdentifier: "NotificationCell",cellType: NotificationCell.self)) { (index, notification, cell) in
            cell.setUpCell(notification: notification)
        }.disposed(by: disposeBag)
    }
    private func didSelectNotifications() {
        notificationTable.rx.modelSelected(Notifications.self).subscribe(onNext: { [weak self]  notifications in
            self?.viewModel?.didSelectNotification(notification: notifications)
            self?.router?.goToNotificationDetails(notification: notifications)
        }).disposed(by: disposeBag)
    }
    private func prefetchNotifications(){
        notificationTable.rx.prefetchRows.subscribe(onNext: { [weak self] indexPaths in
            let lastIndexPath = (self?.viewModel?.notifications.value.count ?? 0) - 1
            if indexPaths.contains(where: { $0.row > lastIndexPath - 4 }) {
                self?.viewModel?.loadMoreNotifications()
            }
        }).disposed(by: disposeBag)
    }
}

extension NotificationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
