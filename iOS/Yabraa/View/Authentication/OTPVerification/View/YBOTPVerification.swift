//
//  YBOTPVerification.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SVPinView
import MKOtpView
class YBOTPVerification: BaseViewController {
    @IBOutlet weak var sendCode: UIButton!
    @IBOutlet weak var resendTimer: UILabel!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var verifiyBTN: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    var router: YBOTPVerificationProtocol?
    var viewModel: YBVerificationViewModel?
    private let disposeBag = DisposeBag()
    var otpViewTextFiled:MKOtpView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindRegisterData()
        setUpPinView()
        bind()
        setUpUi()
        hideKeyboardWhenTappedAround()
        setTimerForResendCodeAgain()
        sendCodeAgain()
    }
    private func setTimerForResendCodeAgain() {
        var secondsRemaining = 10
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if secondsRemaining >= 0 {
                self.sendCode.isEnabled = false
                self.sendCode.setTitleColor(UIColor(named: "TextGrayColor"), for: .normal)
                self.resendTimer.text = String(secondsRemaining)
                secondsRemaining -= 1
            } else {
                self.sendCode.isEnabled = true
                self.sendCode.setTitleColor(.mainColor, for: .normal)
                Timer.invalidate()
            }
        }
    }
    private func sendCodeAgain() {
        sendCode.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.setTimerForResendCodeAgain()
//            self?.viewModel?.resendCode()
        }).disposed(by: disposeBag)
    }
    private func bindRegisterData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        
        viewModel?.registrationSuccess.asDriver(onErrorJustReturn: ()).drive(onNext: { [weak self] _ in
            self?.router?.routeToSuccessVC()
        }).disposed(by: disposeBag)
        viewModel?.registrationError
            .subscribe(onNext: { [weak self] error in
                self?.displayAlert(icon: .ERROR, message: error, OkAction: nil)
            })
            .disposed(by: disposeBag)
        viewModel?.goToCreatePassword.subscribe(onNext: { [weak self] _ in
            self?.router?.goToChnagePasswordView()
        }).disposed(by: disposeBag)
        
    }
    private func setUpPinView() {
        otpViewTextFiled = MKOtpView(frame: CGRect(x: 0, y: 0, width: otpView.frame.width, height: 70))
        otpViewTextFiled.setVerticalPedding(pedding: 5)
        otpViewTextFiled.setHorizontalPedding(pedding: 10)
        otpViewTextFiled.setNumberOfDigits(numberOfDigits: 4)
        otpViewTextFiled.setBorderWidth(borderWidth: 2.0)
        otpViewTextFiled.setBorderColor(borderColor: UIColor(named: "ClaerColor")!)
        otpViewTextFiled.setCornerRadius(radius: 6)
        otpViewTextFiled.setInputBackgroundColor(inputBackgroundColor: UIColor(named: "primaryColor")!)
        self.otpView.addSubview(otpViewTextFiled)
        otpViewTextFiled.onFillDigits = { number in
            print("input number is \(number)")
            self.viewModel?.userVerificationCode.accept(String(number))
            self.viewModel?.checkCode()
        }
        otpViewTextFiled.render()
    }
    private func setUpUi() {
        backBtn.imageView?.FlipImage()
        backBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
    @IBAction func verifiyDidTapped(_ sender: Any) {
        viewModel?.checkCode()
        
    }
    private func bind() {
        viewModel?.isUserVerificationCodeValid.subscribe(onNext: {isvalid in
            if !isvalid{
                self.verifiyBTN.isEnabled = true
                self.verifiyBTN.alpha = 1
                self.displayMessage(title: "", message: "verification code not valid", status: .error)
            }
        }).disposed(by: disposeBag)
    }
}
