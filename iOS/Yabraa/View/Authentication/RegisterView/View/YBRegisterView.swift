//
//  YBRegisterView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 25/02/2023.
//

import UIKit
import RxCocoa
import RxSwift
import SemiModalViewController
class YBRegisterView: BaseViewController {
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var showPasswordBTN: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerBTN: UIView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var iqama: UITextField!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var registerLBL: UILabel!
    @IBOutlet weak var femaleBTN: UIButton!
    @IBOutlet weak var maleBTN: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!{
        didSet{
            phoneNumber.textAlignment = .left
        }
    }
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var showMoreImage: UIImageView!
    var router: RegisterRouterProtocol?
    let disposeBag = DisposeBag()
    var viewModel: YBRegisterViewModel?
    var gender = ""
    var countryCode = ""
    let isPasswordVisiable = BehaviorRelay<Bool>(value: true)
    let isConfirmPasswordVisiable = BehaviorRelay<Bool>(value: true)
    override func viewDidLoad() {
        super.viewDidLoad()
        subcribeButtonsctions()
        checkPhoneNumber()
        bindRegisterData()
        bindToPasswordSecureText()
        configureView()
        hideKeyboardWhenTappedAround()
        updateUserInfo()
        viewModel?.viewDidLoad()
    }
    private func subcribeButtonsctions() {
        backBTN.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.backToLogin()
        }).disposed(by: disposeBag)
       
    }
    private func configureView() {
        showMoreImage.FlipImage()
        backBTN.imageView?.FlipImage()
    }
    private func checkPhoneNumber() {
        phoneNumber.rx.text.orEmpty.map{ phone in
            var phoneNumberWithoutLeadingZero = phone
            if phone.hasPrefix("0") {
                 phoneNumberWithoutLeadingZero = String(phone.dropFirst())
            }
            return phoneNumberWithoutLeadingZero
        }.bind(to: phoneNumber.rx.text).disposed(by: disposeBag)
        
    }
    private func bindRegisterData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        
        viewModel?.registrationSuccess.asDriver(onErrorJustReturn: [:]).drive(onNext: { [weak self] registerParameter in
            self?.router?.goToOtp(registerParameter: registerParameter)
        }).disposed(by: disposeBag)
        viewModel?.didAccountUpdated.asDriver(onErrorJustReturn: ()).drive(onNext: {
            self.displayAlert(icon: .SUCCESS, message: "account updated successfully".localized, OkAction: {
                self.router?.backToLogin()
            })
        }).disposed(by: disposeBag)
        viewModel?.messageError.subscribe(onNext: { [weak self] message in
            self?.displayMessage(title: "", message: message, status: .error)
        }).disposed(by: disposeBag)
        viewModel?.registrationError
            .subscribe(onNext: { [weak self] error in
                self?.displayAlert(icon: .ERROR, message: error, OkAction: nil)
            })
            .disposed(by: disposeBag)
        
    }
    private func updateUserInfo() {
        viewModel?.editedUserInfo.filter{$0 != nil}.asDriver(onErrorJustReturn: nil).drive(onNext: {[weak self] userInfo in
            guard let self = self else {return}
            self.firstName.text = userInfo?.firstName ?? ""
            self.lastName.text = userInfo?.lastName ?? ""
            self.phoneNumber.text = userInfo?.phoneNumber ?? ""
            self.birthday.text = userInfo?.birthDate ?? ""
            let isMale = userInfo?.gender ?? "" == "Male"
            self.didSelectGenderBtn(isMale: isMale)
            self.nationality.text = UserDefualtUtils.isArabic() ? (userInfo?.nationalityAr ?? "") : (userInfo?.nationalityEn ?? "")
            self.iqama.text = userInfo?.idOrPassport ?? ""
            self.email.text = userInfo?.email ?? ""
            self.phoneNumber.isEnabled = false
            self.countryCode = userInfo?.countryCode ?? ""
            self.registerLBL.text = "Edit Account".localized
            self.registerButton.setTitle("Edit Account".localized, for: .normal)
        }).disposed(by: disposeBag)
    }
    private func didSelectGenderBtn(isMale: Bool) {
        if isMale {
            gender = "male"
            femaleBTN.setImage(UIImage(named: "unSelected"), for: .normal)
            maleBTN.setImage(UIImage(named: "selected"), for: .normal)
        }else {
            gender = "female"
            femaleBTN.setImage(UIImage(named: "selected"), for: .normal)
            maleBTN.setImage(UIImage(named: "unSelected"), for: .normal)
        }
    }
    private func bindToPasswordSecureText() {
        showPasswordBTN.rx.tap.bind {
            self.isPasswordVisiable.accept(!self.isPasswordVisiable.value)
        }.disposed(by: disposeBag)
        isPasswordVisiable.map{$0 == true ? UIImage(named: "showPassword") : UIImage(named: "hidePassword")}.subscribe(onNext: {[weak self] image in
            self?.showPasswordBTN.setImage(image, for: .normal)
        }).disposed(by: disposeBag)
        isPasswordVisiable.bind(to: password.rx.isSecureTextEntry).disposed(by: disposeBag)
    }
    
    @IBAction func birthDateDidTapped(_ sender: Any) {
        let dateView = DatePickerView()
        let options = [SemiModalOption.pushParentBack: false]
        dateView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        self.presentSemiViewController(dateView,options: options, dismissBlock:  {
            dateView.date.rx.date.subscribe(onNext: { [weak self] date in
                self?.birthday.text = date.fromDateToString(date)
            }).disposed(by: self.disposeBag)
        })
    }
    @IBAction func backTapped(_ sender: Any) {
       
    }
    @IBAction func genderTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            didSelectGenderBtn(isMale: true)
            //            gender = "Male"
            //            femaleBTN.setImage(UIImage(named: "unSelected"), for: .normal)
            //            maleBTN.setImage(UIImage(named: "selected"), for: .normal)
            
        }else {
            didSelectGenderBtn(isMale: false)
            //            gender = "Female"
            //            femaleBTN.setImage(UIImage(named: "selected"), for: .normal)
            //            maleBTN.setImage(UIImage(named: "unSelected"), for: .normal)
        }
    }
    
    @IBAction func nationalityTapped(_ sender: Any) {
        guard let nationalities = viewModel?.nationalities.value else {return}
        router?.routeToNationalitiyVC(nationalities: nationalities)
    }
    
    @IBAction func regiterTapped(_ sender: UIButton) {
        
        viewModel?.validateData(phone: phoneNumber.text ?? "", password: password.text ?? "", birthDay: birthday.text ?? "", email: email.text ?? "", firstName: firstName.text ?? "", lastName: lastName.text ?? "", gender: gender, countryCode: countryCode, iqama: iqama.text ?? "")
    }
}
extension YBRegisterView: SelectedNationalitiy {
    func didSelectNationality(nationality: NationalitiesData) {
        self.countryCode = nationality.countryCode ?? ""
        self.nationality.text = UserDefualtUtils.isArabic() ? (nationality.countryArNationality) : (nationality.countryEnNationality)
    }
}
