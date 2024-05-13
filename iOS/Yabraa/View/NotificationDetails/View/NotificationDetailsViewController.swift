//
//  NotificationDetailsViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 23/11/2023.
//

import UIKit
import RxSwift
import RxCocoa
class NotificationDetailsViewController: UIViewController {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var notificationName: UILabel!
    @IBOutlet weak var notificationNumber: UILabel!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    var router: NotificationDetailsRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: NotificationDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButtonsActions()
        bindNotificationData()
        setUpUi()
        viewModel?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    private func setUpUi(){
        backBtn.imageView?.FlipImage()
        notificationName.adjustsFontSizeToFitWidth = true
    }
    private func bindButtonsActions() {
        backBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
    private func bindNotificationData() {
        viewModel?.notificationData.subscribe(onNext: {[weak self] notification in
            guard let notification = notification, let self = self else {return}
            self.notificationNumber.text = "Num # ".localized + String(notification.notificationId ?? 0)
            if UserDefualtUtils.isArabic() {
                self.notificationName.text = notification.titleAR ?? ""
                self.notificationTitle.text = notification.titleAR ?? ""
                self.date.text = notification.bodyAR ?? ""
            }else {
                self.notificationName.text = notification.titleEn ?? ""
                self.notificationTitle.text = notification.titleEn ?? ""
                self.date.text = notification.bodyEn ?? ""
            }
           
        }).disposed(by: disposeBag)
    }
    
}
