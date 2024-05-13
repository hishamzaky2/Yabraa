//
//  MedicalProfileViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
class MedicalProfileViewController: BaseViewController {
    @IBOutlet weak var diseaseName: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var diseaseTableView: UITableView!

    var router: MedicalProfileRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: MedicalProfileViewModel?
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
        diseaseName.text = Diseases.Allergies.rawValue.localized
    }
    
    private func registerCell() {
        diseaseTableView.register(UINib(nibName: "MedicalProfileCell", bundle: nil), forCellReuseIdentifier: "MedicalProfileCell")
        diseaseTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindData() {
//        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
//            self?.showHud(showLoding: isLoading)
//        }).disposed(by: disposeBag)
        backBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
    private func bindTableView() {
        viewModel?.diseaseNames.bind(to: diseaseTableView.rx.items(cellIdentifier: "MedicalProfileCell",cellType: MedicalProfileCell.self)){ (index, model, cell) in
            cell.selectionStyle = .none
            cell.setUpCell(diseaseName: model.rawValue.localized)
        }.disposed(by: disposeBag)
        diseaseTableView.rx.modelSelected(Diseases.self).subscribe(onNext: { [weak self] disease in
            self?.diseaseName.text = disease.rawValue.localized
            self?.router?.goToDiseasesView(PatientID: self?.viewModel!.PatientID ?? 0, disease: disease)
        }).disposed(by: disposeBag )
    }
   
}

extension MedicalProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


