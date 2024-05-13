//
//  YBLogInView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 25/02/2023.
//

import UIKit
import RxSwift
import RxCocoa
class YBLogInView: BaseViewController {
    @IBOutlet weak var showAndHidePasswordBTN: UIButton!
    @IBOutlet weak var loginBTN: UIButton!
    @IBOutlet weak var passwordTXT: UITextField!
    @IBOutlet weak var phoneTXT: UITextField!
    private let disposeBag = DisposeBag()
    private let viewModel = YBLoginViewModel()
    var router: YBLoginRouter?
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPhoneNumber()
        bind()
        setUi()
        hideKeyboardWhenTappedAround()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    private func setUi() {
        [passwordTXT,phoneTXT].forEach { textField in
            textField?.textAlignment = .left
        }
    }
    private func checkPhoneNumber() {
        phoneTXT.rx.text.orEmpty.map{ phone in
            var phoneNumberWithoutLeadingZero = phone
            if phone.hasPrefix("0") {
                 phoneNumberWithoutLeadingZero = String(phone.dropFirst())
            }
            return phoneNumberWithoutLeadingZero
        }.bind(to: phoneTXT.rx.text).disposed(by: disposeBag)
        
    }
    private func bind() {
        viewModel.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        viewModel.loginSuccess
            .subscribe(onNext: { [weak self] in
                DispatchQueue.main.async {
                    self?.router?.routeToHomeVC()
                }
            })
            .disposed(by: disposeBag)
        viewModel.loginFails
            .subscribe(onNext: { [weak self] error in
                self?.displayAlert(icon: .ERROR, message: error, OkAction: nil)
            })
            .disposed(by: disposeBag)
    }
    @IBAction func showAndHidePasswordDidTapped(_ sender: Any) {
        var imageName = ""
        passwordTXT.isSecureTextEntry = !passwordTXT.isSecureTextEntry
        passwordTXT.isSecureTextEntry == true ? (imageName = "showPassword") : (imageName = "hidePassword")
        self.showAndHidePasswordBTN.setImage(UIImage(named: imageName), for: .normal)
    }
    @IBAction func registerTapped(_ sender: Any) {
        self.router?.routeToRegisterVC()
    }
    @IBAction func loginWithFacebookTapped(_ sender: Any) {
    }
    @IBAction func loginWithGoogleTapped(_ sender: Any) {
    }
    @IBAction func forgetPasswordTapped(_ sender: Any) {
        self.router?.goToForgetPasswordView()
    }
    @IBAction func loginAsAgestTapped(_ sender: Any) {
        self.router?.routeToHomeVC()
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        if (phoneTXT.text ?? "").isEmpty || (passwordTXT.text ?? "").isEmpty {
            displayMessage(title: "", message: "All Fileds Required".localized, status: .error)
            return
        }
        if let phone = self.phoneTXT.text, !phone.isValidPhone() || phone.count < 9 {
            displayMessage(title: "", message: "Phone Number Is Incorrect".localized, status: .error)
            return
        }
        if let password = self.passwordTXT.text,password.count < 6 {
            displayMessage(title: "", message: "Password Must Be Greater Than Or Equal 6 Characters".localized, status: .error)
            return
        }
        viewModel.login(phone: phoneTXT.text ?? "", password: passwordTXT.text ?? "")
    }
}
