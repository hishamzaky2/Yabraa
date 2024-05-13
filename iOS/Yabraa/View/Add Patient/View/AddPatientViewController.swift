//
//  AddPatientViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
class AddPatientViewController: BaseViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var addNewPatientBtn: UIButton!
    @IBOutlet weak var patientTableView: UITableView!
    var router: AddPatientRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: AddPatientViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        bindPatientTableView()
        setUpView()
        bindButtonActions()
    }
    private func setUpView() {
        backBtn.imageView?.FlipImage()
        addNewPatientBtn.addShadowToAllEdges(cornerRadius: 15)
    }
    private func bindButtonActions() {
        addNewPatientBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.router?.goToAddNewPatient(updatedPatient: nil)
        }).disposed(by: disposeBag)
    }
    private func bindData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        backBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
    private func bindPatientTableView() {
        patientTableView.register(UINib(nibName: "PatientCellData", bundle: nil), forCellReuseIdentifier: "PatientCellData")
        patientTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel?.usersFamliy.bind(to: patientTableView.rx.items(cellIdentifier: "PatientCellData",cellType: PatientCellData.self)){ (index, model, cell) in
            cell.updatePatient = {
                self.router?.goToAddNewPatient(updatedPatient: model)
            }
            cell.isUserInteractionEnabled = model.isOwner ?? false ? (false) : (true)
            cell.setUpCell(user: model)
        }.disposed(by: disposeBag)
        patientTableView.rx.modelSelected(UserFamliy.self).subscribe(onNext: { [weak self] patient in
            self?.router?.goToAddNewPatient(updatedPatient: patient)
        }).disposed(by: disposeBag)
    }
}
extension AddPatientViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
