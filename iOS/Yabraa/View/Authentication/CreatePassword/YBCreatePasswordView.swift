//
//  YBCreatePasswordView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import UIKit
import RxCocoa
import RxSwift
class YBCreatePasswordView: BaseViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var confirmPasswordBTN: UIButton!
    @IBOutlet weak var showPasswordBTN: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var showConfirmPasswordBTN: UIButton!
    @IBOutlet weak var confirmPassword: UITextField!
    var router: YBCraetePasswordRouterProtocol?
    var viewModel = YBCreatePasswordViewModel()
    private let disposeBag = DisposeBag()
    let showPassword = BehaviorRelay<Bool>(value: true)
    let showConfirmedPassword = BehaviorRelay<Bool>(value: true)
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        bindAPiResult()
        setUpUi()
        hideKeyboardWhenTappedAround()
    }
    private func setUpUi() {
        backBtn.imageView?.FlipImage()
        backBtn.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
        showPasswordBTN.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            let currentValue = self?.showPassword.value ?? false
            self?.showPassword.accept(!currentValue)
        }).disposed(by: disposeBag)
        showPassword.bind(to: password.rx.isSecureTextEntry).disposed(by: disposeBag)
        showPassword.map{$0 == true ? UIImage(named: "showPassword") : UIImage(named: "hidePassword") }.bind(to: showPasswordBTN.rx.image()).disposed(by: disposeBag)
        showConfirmPasswordBTN.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            let currentValue = self?.showConfirmedPassword.value ?? false
            self?.showConfirmedPassword.accept(!currentValue)
        }).disposed(by: disposeBag)
        showConfirmedPassword.bind(to: confirmPassword.rx.isSecureTextEntry).disposed(by: disposeBag)
        showConfirmedPassword.map{$0 == true ? UIImage(named: "showPassword") : UIImage(named: "hidePassword") }.bind(to: showConfirmPasswordBTN.rx.image()).disposed(by: disposeBag)
        
    }
    @IBAction func confirmPasswordTapped(_ sender: Any) {
        viewModel.validateData(password: password.text ?? "", confirmedPassword: confirmPassword.text ?? "")
        
    }
    private func bindAPiResult() {
        viewModel.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        viewModel.isSuccess.asDriver(onErrorJustReturn: ()).drive(onNext: {[weak self] _ in
            self?.didChnagePassword()
        }).disposed(by: disposeBag)
        viewModel.isFails
            .subscribe(onNext: { [weak self] error in
                DispatchQueue.main.async {
                    self?.displayAlert(icon: .ERROR, message: error, OkAction: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    private func didChnagePassword() {
        displayAlert(icon: .SUCCESS, message: "Your password has been changed successfully. Please go to Login to log in again".localized) {
            self.router?.routeToLoginVC()
        }
    }
    private func bindData() {
        viewModel.messageError.subscribe(onNext: { [weak self] message in
            self?.displayMessage(title: "", message: message, status: .error)
        }).disposed(by: disposeBag)
    }
   
    private func goToLoginView() {
        self.displayAlert(icon: .SUCCESS, message: "password changes Successfully".localized) {
            self.router?.routeToLoginVC()
        }
    }
}
