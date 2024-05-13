//
//  YBPackageDetailsView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 22/06/2023.
//

import UIKit

import RxSwift
import RxCocoa
class YBPackageDetailsView: BaseViewController {
    @IBOutlet weak var packageName: UILabel!
    @IBOutlet weak var instruction: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var confirmViewBottomConstraint: NSLayoutConstraint!
    var viewModel: PackageDetailsViewModel?
    var router: PackageDetailsRouterProtocol?
    let disposeBage = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindPackageDetails()
        setUpUI()
        bindButtonAction()
        bindData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.checkIfPackageIsAddedToSeletedPackagesBefore()
    }
    private func checkAlignment() {
        [instruction,price,descriptionLBL].forEach { labale in
            if UserDefualtUtils.isArabic() {
                labale.textAlignment = .right
            }else {
                labale.textAlignment = .left
            }
        }
    }
    private func bindData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBage)
        
    }
    private func bindPackageDetails() {
        viewModel?.package.map({ package in
            return UserDefualtUtils.isArabic() ? (package?.nameAR ?? "") : (package?.nameEN ?? "")
        }).bind(to: packageName.rx.text).disposed(by: disposeBage)
        viewModel?.package.asDriver().drive(onNext: { [weak self] packageDetails in
            self?.image.setImage(from: packageDetails?.imagePath ?? "")
            self?.price.text = "\(packageDetails?.price ?? 0)" + " " + "SAR".localized
            if UserDefualtUtils.isArabic() {
                self?.instruction.text = packageDetails?.instructionAR ?? ""
                self?.name.text = packageDetails?.nameAR ?? ""
                self?.descriptionLBL.text = packageDetails?.detailsAR ?? ""
            }else {
                self?.instruction.text = packageDetails?.instructionEN ?? ""
                self?.name.text = packageDetails?.nameEN ?? ""
                self?.descriptionLBL.text = packageDetails?.detailsEN ?? ""
            }
            
        }).disposed(by: disposeBage)
        viewModel?.isPackageAddedToSelectedPackages.subscribe(onNext: { [weak self] isAdded in
            if isAdded {
                self?.cancel.rx.alpha.onNext(1.0)
                self?.cancel.rx.isEnabled.onNext(true)
                self?.confirm.rx.backgroundColor.onNext(.white)
                self?.confirm.setTitleColor(.grayColor, for: .normal)
            }else {
                self?.cancel.rx.alpha.onNext(0.5)
                //                self?.cancel.rx.isEnabled.onNext(false)
                self?.confirm.rx.backgroundColor.onNext(.mainColor)
                self?.confirm.setTitleColor(.white, for: .normal)
            }
        }).disposed(by: disposeBage)
    }
    private func setUpUI() {
        viewModel!.isShowMore ? confirmViewBottomConstraint.constant = 0 : (confirmViewBottomConstraint.constant = 70)
        backBtn.imageView?.FlipImage()
    }
    private func bindButtonAction() {
        confirm.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.addPackageToSelectedPackages()
            self?.router?.back()
        }).disposed(by: disposeBage)
        cancel.rx.tap.subscribe(onNext: { [weak self] _ in
            if self?.viewModel?.isPackageAddedToSelectedPackages.value ?? false {
                self?.viewModel?.removePackageToSelectedPackages()
                self?.router?.back()
            }else {
                self?.router?.back()
            }
            
        }).disposed(by: disposeBage)
        backBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBage)
    }
}
