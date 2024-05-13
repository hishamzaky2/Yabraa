//
//  SuccessRegisterViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 18/09/2023.
//

import UIKit
import RxCocoa
import RxSwift
class SuccessRegisterViewController: BaseViewController {
    @IBOutlet weak var startBtn: UIButton!
    var router: SuccessRegisterRouterProtocol?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtnDidTapped()
    }
    private func startBtnDidTapped() {
        startBtn.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.router?.routeToHomeVC()
        }).disposed(by: disposeBag)
    }

}
