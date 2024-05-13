//
//  PaymentMethodsViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 03/08/2023.
//

import UIKit
import RxCocoa
import RxSwift
protocol selectedPaymentMethod:AnyObject {
    func didSelectPaymentMethod(paymentMethod: PaymentMethod)
}
class PaymentMethodsViewController: BaseViewController {
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var paymentMethodTable: UITableView!
    var router: PaymentMethodRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: PaymentMethodsViewModel?
    weak var delegate: selectedPaymentMethod?
    var selectedPaymentMethod: PaymentMethod?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        bindTableView()
        bindData()
    }
    private func bindData() {
        dismissBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        payBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.didTapOnPayBtn()
        }).disposed(by: disposeBag)
    }
    private func didTapOnPayBtn() {
        guard let selectedPaymentMethod = selectedPaymentMethod else {
            displayMessage(title: "", message: "please select payment method".localized, status: .info)
            return
        }
        dismiss(animated: true,completion: {
            self.delegate?.didSelectPaymentMethod(paymentMethod: selectedPaymentMethod)
        })
    }
    private func registerCell() {
        paymentMethodTable.register(UINib(nibName: "PaymentMethodCell", bundle: nil), forCellReuseIdentifier: "PaymentMethodCell")
        paymentMethodTable.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindTableView() {
        viewModel?.paymentMethods.bind(to: paymentMethodTable.rx.items(cellIdentifier: "PaymentMethodCell",cellType: PaymentMethodCell.self)) {
            index, paymentMethod, cell in
            cell.setUpCell(paymentMethod: paymentMethod)
        }.disposed(by: disposeBag)
        paymentMethodTable.rx.modelSelected(PaymentMethod.self).subscribe(onNext: {[weak self] paymentMethod in
            self?.selectedPaymentMethod = paymentMethod
        }).disposed(by: disposeBag)
    }
}
extension PaymentMethodsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
