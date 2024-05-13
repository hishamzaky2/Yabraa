//
//  YBForgetPasswordView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import UIKit
import RxSwift
import RxCocoa
class YBForgetPasswordView: BaseViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var phoneTXT: UITextField!{
        didSet{
            phoneTXT.textAlignment = .left
        }
    }
    var router: YBForgetPasswordRouter?
    var viewModel = YBForgetPasswordViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPhoneNumber()
        bind()
        setUpView()
        hideKeyboardWhenTappedAround()
    }
    private func setUpView() {
        backBtn.imageView?.FlipImage()
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
        viewModel.isSuccess.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] phone in
            self?.router?.routeToVerificationVC(phone: phone)
            })
            .disposed(by: disposeBag)
        viewModel.isFails
            .subscribe(onNext: { [weak self] error in
                self?.displayAlert(icon: .ERROR, message: error, OkAction: nil)
            })
            .disposed(by: disposeBag)
    }
    @IBAction func sendVerificationCodeTapped(_ sender: Any) {
        if let phone = self.phoneTXT.text,phone.count == 9, phone.isValidPhone() {
            viewModel.getVerificationCode(phone: phone)}
            else {
            displayMessage(title: "phone number incorrect", message: "", status: .error)
        }
       
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.router?.dismissView(view: self)
    }
}
