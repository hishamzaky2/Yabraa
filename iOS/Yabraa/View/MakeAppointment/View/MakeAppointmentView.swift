//
//  MakeAppointmentView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 23/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
protocol MakeAppointmentProtocol: AnyObject {
    func didCancelPackage()
}
class MakeAppointmentView: BaseViewController {
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var packagesTableView: UITableView!
    var router: MakeAppointmentRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: MakeAppointmentViewModel?
    var delegate: MakeAppointmentProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewModelPublishers()
        setUpPackagesTableView()
        setUpUi()
        bindButtonActions()
        viewModel?.viewDidLoad()
    }
    private func setUpUi() {
        backBtn.imageView?.FlipImage()
        confirmBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        viewModel?.viewDidLoad()
    }
    private func subscribeViewModelPublishers() {
        viewModel?.serviceName.bind(to: serviceName.rx.text).disposed(by: disposeBag)
//        viewModel?.didCancelPackage.subscribe(onNext: {[weak self] isCanceled in
//            if isCanceled {
//                self?.delegate?.didCancelPackage()
//                self?.router?.back()
//            }
//        }).disposed(by: disposeBag)
    }
    private func bindButtonActions() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
        confirmBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.viewModel?.checkAllPackagesAreValidated()
        }).disposed(by: disposeBag)
        cancelBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.delegate?.didCancelPackage()
            self?.router?.back()
//            self?.viewModel?.cancelPackage()
        }).disposed(by: disposeBag)
        viewModel?.didValidatePackages.subscribe(onNext: { [weak self]  _ in
            if let serviceType = SelectedPackage.shared.serviceType,serviceType == .HomeVisit {
                self?.router?.routeToMapVC()
            }else {
                self?.router?.goToConfirmation()
            }
        }).disposed(by: disposeBag)
        viewModel?.messageError.subscribe(onNext: { [weak self] message in
            self?.displayAlert(icon: .INFO, titel: "beAttenion".localized, message: message, OkAction: nil)
        }).disposed(by: disposeBag)
    }
    private func setUpPackagesTableView() {
        packagesTableView.register(UINib(nibName: "PackagesDataCell", bundle: nil), forCellReuseIdentifier: "PackagesDataCell")
        packagesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        let headerImageView = UIImageView()
        headerImageView.setImage(from: viewModel?.serviceImage ?? "")
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.frame = CGRect(x: 0, y: 0, width: packagesTableView.frame.width, height: 200)
        packagesTableView.tableHeaderView = headerImageView
        bindPackagesTableViewata()
    }
    private func bindPackagesTableViewata() {
        viewModel?.packages.bind(to: packagesTableView.rx.items(cellIdentifier: "PackagesDataCell",cellType: PackagesDataCell.self)){  index, model, cell in
            cell.setUpCell(package: model)
            cell.PackageDescription.rx.text.orEmpty.subscribe(onNext: {[weak self] text in
                self?.viewModel?.setDescriptionToPackage(description: text, index: index)
            }).disposed(by: cell.disposeBag)
            cell.selectDate.rx.tap.asDriver().drive(onNext: { _ in
                self.router?.goToSelectDate(package: model, dates: self.viewModel?.dates ?? [])
            }).disposed(by: cell.disposeBag)
            self.viewModel?.canSelectPatient.bind(to: cell.selectPatioentName.rx.isEnabled).disposed(by: cell.disposeBag)
            cell.selectPatioentName.rx.tap.asDriver().drive(onNext: {  _ in
                self.router?.goToSelectPatient(package: model)
            }).disposed(by: cell.disposeBag)
        }.disposed(by: disposeBag)
    }
}
extension MakeAppointmentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension MakeAppointmentView:PackageUpdating {
    func didUpdatePackage() {
        viewModel?.didGetUsers()
    }
}
