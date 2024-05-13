//
//  YBNationtioalitesViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/06/2023.
//

import UIKit
import RxCocoa
import RxSwift
protocol SelectedNationalitiy {
    func didSelectNationality(nationality: NationalitiesData)
}
class YBNationtioalitesViewController: UIViewController {
    
    @IBOutlet weak var doneTapped: UIButton!
    @IBOutlet weak var NatioalitiesTable: UITableView!
    @IBOutlet weak var searchTXT: UITextField!
    @IBOutlet weak var titleLBL: UILabel!
    let disposeBag = DisposeBag()
    var viewModel: NatioalitiesViewModel?
    var router: YBNationalitiyRouter?
    var delegate: SelectedNationalitiy?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureView()
        bindSearchBar()
    }
    private func bindSearchBar() {
        searchTXT.rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] query in
                self?.viewModel?.searchQuery(query: query)
            }).disposed(by: disposeBag)
    }
    private func configureView() {
        doneTapped.rx.tap.subscribe(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    private func configureTableView() {
        NatioalitiesTable.register(UINib(nibName: "dropMenuCell", bundle: nil), forCellReuseIdentifier: "dropMenuCell")
        viewModel?.filteredNatioalities.bind(to: NatioalitiesTable.rx.items(cellIdentifier: "dropMenuCell",cellType: dropMenuCell.self)) { index, item, cell in
            cell.setUpCell(natioalitiy: item)
            cell.selectionStyle = .none
        }
        .disposed(by: disposeBag)
        NatioalitiesTable.rx.modelSelected(NationalitiesData.self).subscribe(onNext: {[weak self] model in
            self?.delegate?.didSelectNationality(nationality: model)
        }).disposed(by: disposeBag)
        NatioalitiesTable.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
}
extension YBNationtioalitesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
