//
//  YBServciDescriptionView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 03/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
protocol ServciDescriptionProtocol:AnyObject {
    func didTapConfirm(package: Packages)
}
class YBServciDescriptionView: UIViewController {
    @IBOutlet weak var instruction: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var confirm: UIButton!
    var viewModel: ServciDescriptionViewModel?
     var coordinator: ServciDescriptionCoordintorDelegate?
    weak var delegate:ServciDescriptionProtocol?
    let disposeBage = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        setUpView()
        setUpUi()
    }
    private func bindData() {
        let currentLanguage = UserDefualtUtils.isArabic()
        viewModel?.package.map{currentLanguage ? $0?.instructionAR : $0?.instructionEN}.bind(to: instruction.rx.text).disposed(by: disposeBage)
        viewModel?.package.map{currentLanguage ? $0?.detailsAR : $0?.detailsEN}.bind(to: descriptionLBL.rx.text).disposed(by: disposeBage)
        viewModel?.package.map{currentLanguage ? $0?.nameAR : $0?.nameEN}.bind(to: name.rx.text).disposed(by: disposeBage)
        viewModel?.package.map{
            return String($0?.price ?? 0) + " " + "SAR".localized}.bind(to: price.rx.text).disposed(by: disposeBage)
        viewModel?.package.map{$0?.imagePath ?? ""}.subscribe(onNext: { [weak self] imagePath in
            self?.image.setImage(from: imagePath)
        }).disposed(by: disposeBage)
        confirm.rx.tap.subscribe(onNext: {
            var package = self.viewModel?.package.value
            package?.isSelected = true
            self.delegate?.didTapConfirm(package: package!)
            self.coordinator?.goToBack()
        }).disposed(by: disposeBage)
        cancel.rx.tap.subscribe(onNext: {
            self.coordinator?.goToBack()
        }).disposed(by: disposeBage)
    }
    private func setUpView() {
        
    }
    private func setUpUi() {
        
    }

}
