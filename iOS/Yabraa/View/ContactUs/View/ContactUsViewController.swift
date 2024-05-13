//
//  ContactUsViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 14/11/2023.
//

import UIKit
import RxSwift
import RxCocoa
class ContactUsViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var contactUsLBL: UILabel!
    var router: ContactUsRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: ContactUsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButtonActions()
        setUpUi()
        bindContactUs()
        viewModel?.viewDidLoad()
    }
    private func bindButtonActions() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
    private func setUpUi(){
        backBtn.imageView?.FlipImage()
    }
    private func bindContactUs() {
        viewModel?.contactUs.bind(to: contactUsLBL.rx.text).disposed(by: disposeBag)
    }
    
}
