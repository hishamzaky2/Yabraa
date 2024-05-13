//
//  DiseasesViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
class DiseasesViewController: UIViewController {
    @IBOutlet weak var diseaseName: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var diseasesTableView: UITableView!
    var router: DiseasesRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: DiseasesViewModel?
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
        diseasesTableView.register(UINib(nibName: "DiseasesCell", bundle: nil), forCellReuseIdentifier: "DiseasesCell")
        diseasesTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        backBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
        viewModel?.disease.map{$0.rawValue.localized}.bind(to: diseaseName.rx.text).disposed(by: disposeBag)
    }
    private func bindTableView() {
        viewModel?.diseasesData.bind(to: diseasesTableView.rx.items(cellIdentifier: "DiseasesCell",cellType: DiseasesCell.self)){ (index, model, cell) in
            cell.addTapped = {
                self.viewModel?.addDisease(diseaseID: model.diseaseId)
            }
            cell.deleteTapped = {
                self.viewModel?.deleteDisease(diseaseID: model.diseaseId)
            }
            cell.setUpCell(diseasesData: model)
        }.disposed(by: disposeBag)
    }
}

extension DiseasesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
