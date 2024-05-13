//
//  YBConfirmationView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit
import RxSwift
import RxCocoa
protocol PackagesLocation: AnyObject {
    func chnagePackagesLocation(packages: Packages)
}
class YBConfirmationView: BaseViewController {
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var ServicesTables: UITableView!
    @IBOutlet weak var paymentBTN: UIButton!
    @IBOutlet weak var totalPrice: UILabel!
    var router: ConfirmationRouterDelegate?
    var viewModel: ConfirmationViewModel?
    weak var delegate: PackagesLocation?
    let disposeBag = DisposeBag()
    var hayperPay: HyperPaymentManager?
    var checkoutProvider: OPPCheckoutProvider?
    var transaction: OPPTransaction?
    var checkOutId: String?
    var paymentMethod: String?
    var paymentMethodID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        bindTableView()
        bindData()
        bindButtonsAction()
        setUpUi()
        bindCheckout()
    }
    private func setUpUi() {
        backBTN.imageView?.FlipImage()
    }
    private func bindButtonsAction() {
        backBTN.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
        viewModel?.totalPrice.map{
            return String($0) + " " + "SAR".localized}.bind(to: totalPrice.rx.text).disposed(by: disposeBag)
        paymentBTN.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.router?.goToPaymentMethods()
        }).disposed(by: disposeBag)
    }
    private func bindCheckout() {
        viewModel?.checkoutID.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] checkoutId in
            self?.openHyperPay(checkoutId: checkoutId)
        }).disposed(by: disposeBag)
    }
    private func openHyperPay(checkoutId: String?) {
        guard let checkoutId = checkoutId, let paymentMethod = paymentMethod else {return}
        self.checkOutId = checkoutId
        hayperPay = HyperPaymentManager(checkoutId: checkoutId,paymentMethod: paymentMethod)
        checkoutProvider = hayperPay?.configureCheckoutProvider()
        checkoutProvider?.delegate = self
        checkoutProvider?.presentCheckout(withPaymentBrand: paymentMethod, loadingHandler:{_ in }, completionHandler: {[weak self] (transaction, error)  in
            self?.handleTransactionSubmission(transaction: transaction, error: error)
        })
    }
   
    private func bindData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {[weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        viewModel?.isFails
            .subscribe(onNext: { [weak self] error in
                self?.displayAlert(icon: .ERROR, message: error, OkAction: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func registerCell() {
        ServicesTables.register(UINib(nibName: "AppointMentCell", bundle: nil), forCellReuseIdentifier: "AppointMentCell")
    }
    private func bindTableView() {
        viewModel?.packages.bind(to: ServicesTables.rx.items(cellIdentifier: "AppointMentCell",cellType: AppointMentCell.self)) {
            index, package, cell in
            cell.changeServiceLocation = {
                self.delegate?.chnagePackagesLocation(packages: package)
                self.router?.back()
            }
            
            cell.setUpCell(package: package)
        }.disposed(by: disposeBag)
    }
    
}
extension YBConfirmationView: selectedPaymentMethod {
    func didSelectPaymentMethod(paymentMethod: PaymentMethod) {
        self.paymentMethod = paymentMethod.name.uppercased()
        self.paymentMethodID = paymentMethod.paymentMethodId
        viewModel?.didSelectPaymentMethod(paymentMethod: paymentMethod)
    }
}
