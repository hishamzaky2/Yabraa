//
//  PatientsProfileViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
class PatientsProfileViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var patientsTableView: UITableView!
    var router: PatientsProfileRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: PatientsProfileViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        bindTableView()
        setUpUi()
        bindData()
        // Do any additional setup after loading the view.
    }
    private func setUpUi(){
        backBtn.imageView?.FlipImage()
    }
    private func registerCell() {
        patientsTableView.register(UINib(nibName: "PatientCellData", bundle: nil), forCellReuseIdentifier: "PatientCellData")
        patientsTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        backBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
    private func bindTableView() {
        viewModel?.usersFamliy.bind(to: patientsTableView.rx.items(cellIdentifier: "PatientCellData",cellType: PatientCellData.self)){ (index, model, cell) in
            cell.upatePatientData.isHidden = true
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = model.isOwner ?? false ? (false) : (true)
            cell.setUpCell(user: model)
        }.disposed(by: disposeBag)
        patientsTableView.rx.modelSelected(UserFamliy.self).subscribe(onNext: { [weak self] patient in
            self?.router?.goToMedicalProfileView(PatientID: patient.userFamilyId ?? 0)
        }).disposed(by: disposeBag )
    }
}

extension PatientsProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
