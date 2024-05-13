//
//  MyAppoinmentsViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
class MyAppoinmentsViewController: BaseViewController {
    
    @IBOutlet weak var appointmentsTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    var router: MyAppoinmentsRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: MyAppoinmentsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        handleSuccessAndErrorStatus()
        bindData()
        setUpUi()
        registerCell()
        bindTableView()
        viewModel?.viewDidLoad()
    }
    private func setUpUi() {
        backBtn.imageView?.FlipImage()
    }
    private func handleSuccessAndErrorStatus() {
        viewModel?.isFails.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] error in
            self?.displayMessage(title: "", message: error, status: .error)
        })
        .disposed(by: disposeBag)
        viewModel?.didCancelAppointmentSuccessfully
            .asDriver(onErrorJustReturn: ()).drive(onNext: { [weak self] error in
                self?.displayMessage(title: "", message: "appointment canceled successfully".localized, status: .success)
            })
            .disposed(by: disposeBag)
    }
    private func bindData() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        
    }
    private func registerCell() {
        appointmentsTableView.register(UINib(nibName: "AppointMentCell", bundle: nil), forCellReuseIdentifier: "AppointMentCell")
    }
    private func bindTableView() {
        viewModel?.myAppointments.bind(to: appointmentsTableView.rx.items(cellIdentifier: "AppointMentCell",cellType: AppointMentCell.self)) {
            index, appointment, cell in
            cell.changeServiceLocation = {
                self.router?.goToAppointmentDetails(appointmentId: appointment.appointmentId ?? 0)
            }
            cell.cancelAppointmentTapped = {
                self.viewModel?.cancelAppointMent(at: index)
            }
            cell.callYabraaPhone = {
                self.callPhone()
            }
            cell.moreInfo = {
                self.router?.goToMedicalDescription(appointmentId: appointment.appointmentId ?? 0)
            }
            cell.setUpCell(appointment: appointment)
        }.disposed(by: disposeBag)
        appointmentsTableView.rx.modelSelected(MyAppointments.self).subscribe(onNext: {[weak self] appointment in
            self?.router?.goToAppointmentDetails(appointmentId: appointment.appointmentId ?? 0)
        }).disposed(by: disposeBag)
    }
    private func callPhone() {
        if let phoneURL = URL(string: "tel://+966570666649") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                // Handle the case where the device cannot make phone calls
                print("Phone calls are not supported on this device.")
            }
        }
    }
    
}
