//
//  YBPatientsView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit
import RxSwift
import RxCocoa
class YBPatientsView: UIViewController {
    @IBOutlet weak var patientsTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
     var coordinator: PatientsCoodintaorDelegate?
    var viewModel: PatientsViewModel?
    private let disposeBag = DisposeBag()
    var selectedPatientDelegate:PackageUpdating?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        bindData()
    }
    private func registerCell() {
        patientsTableView.register(UINib(nibName: "PataintCell", bundle: nil), forCellReuseIdentifier: "PataintCell")
        patientsTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindData() {
        viewModel?.patients.bind(to: patientsTableView.rx.items(cellIdentifier: "PataintCell",cellType: PataintCell.self)) {
            index, patient, cell in
            cell.setUpCell(user: patient)
        }.disposed(by: disposeBag)
        patientsTableView.rx.modelSelected(UserFamliy.self).subscribe(onNext: { [weak self]  patient in
            self?.viewModel?.didSelectPatientName(user: patient)
            self?.coordinator?.dismissView()
            self?.selectedPatientDelegate?.didUpdatePackage()
        }).disposed(by: disposeBag)
        cancelButton.rx.tap.asDriver().drive(onNext: { _ in
            self.coordinator?.dismissView()
        }).disposed(by: disposeBag)
    }
}

extension YBPatientsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
