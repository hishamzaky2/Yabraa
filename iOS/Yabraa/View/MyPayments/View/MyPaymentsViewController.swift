//
//  MyPaymentsViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MyPaymentsViewController: BaseViewController {
    @IBOutlet weak var paymentsTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    var router: MyPaymentsRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: MyPaymentsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        setUpUi()
        registerTableViewCells()
        bindServiceTableViewData()
    }
    private func setUpUi() {
        backBtn.imageView?.FlipImage()
    }
    private func bindData() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
    }
    private func registerTableViewCells() {
        paymentsTableView.register(UINib(nibName: "MyPaymentsCell", bundle: nil), forCellReuseIdentifier: "MyPaymentsCell")
        paymentsTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, Items>> {
        return RxTableViewSectionedReloadDataSource<SectionModel<String, Items>>(
            configureCell: { dataSource, tableView, indexPath, data in
                return self.setUpPaymentCell(item: data)
            }, titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            })
    }
    private func setUpPaymentCell(item: Items)-> MyPaymentsCell  {
        let cell = paymentsTableView.dequeueReusableCell(withIdentifier: "MyPaymentsCell") as! MyPaymentsCell
        cell.setUpCell(item: item)
        return cell
    }
    private func bindServiceTableViewData() {
        let dataSource = dataSource()
        viewModel?
            .PaymentsData
            .bind(to: paymentsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
}
extension MyPaymentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}
