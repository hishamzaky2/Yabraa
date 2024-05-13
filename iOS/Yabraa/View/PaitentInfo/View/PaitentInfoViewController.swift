//
//  PaitentInfoViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SemiModalViewController

class PaitentInfoViewController: BaseViewController {
    
    @IBOutlet weak var deletePatient: UIButton!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var birthDayView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var addNewPatient: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var birthDayBtn: UIButton!
    @IBOutlet weak var birthDayTxt: UITextField!
    var router: PaitentInfoRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: PaitentInfoViewModel?
    var gender = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButtonsAction()
        setUpUi()
        bindData()
        hideKeyboardWhenTappedAround()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpUi()
    }
    private func setUpUi(){
        backBtn.imageView?.FlipImage()
        nameView.addShadowToAllEdges(cornerRadius: 15)
        deletePatient.addShadowToAllEdges(cornerRadius: 15)
        birthDayView.addShadowToAllEdges(cornerRadius: 15)
        genderView.addShadowToAllEdges(cornerRadius: 15)
        addNewPatient.addShadowToAllEdges(cornerRadius: 15)
    }
    private func bindData(){
        viewModel?.didAddNewPatient.subscribe(onNext: { [weak self] message in
            self?.displayAlert(icon: .SUCCESS, titel: "", message: "New Patient added Succssfully".localized, OkAction: {
                self?.router?.back()
            })
        }).disposed(by: disposeBag)
        viewModel?.didUpdatePatient.subscribe(onNext: { [weak self] message in
            self?.displayAlert(icon: .SUCCESS, titel: "", message: "Patient updated Succssfully".localized, OkAction: {
                self?.router?.back()
            })
        }).disposed(by: disposeBag)
        viewModel?.didDeletePatient.subscribe(onNext: { [weak self] message in
            self?.displayAlert(icon: .SUCCESS, titel: "", message: "Patient deleted Succssfully".localized, OkAction: {
                self?.router?.back()
            })
        }).disposed(by: disposeBag)
        viewModel?.messageError.subscribe(onNext: { [weak self] message in
            self?.displayMessage(title: "", message: message, status: .error)
        }).disposed(by: disposeBag)
        viewModel?.updatedPatient.subscribe(onNext: {[weak self] updatedPatient in
            guard let  updatedPatient = updatedPatient else {return}
            self?.deletePatient.isHidden = false
            self?.addNewPatient.setTitle("Update".localized, for: .normal)
            self?.birthDayTxt.text = updatedPatient.birthDate ?? ""
            self?.name.text = updatedPatient.name ?? ""
            if updatedPatient.gender ?? "" == "Male" {
                self?.didSelectGenderBtn(isMale: true)
            }else {
                self?.didSelectGenderBtn(isMale: false)
            }
        }).disposed(by: disposeBag)
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)

    }
    private func bindButtonsAction() {
        maleBtn.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.didSelectGenderBtn(isMale: true)
        }).disposed(by: disposeBag)
        femaleBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.didSelectGenderBtn(isMale: false)
        }).disposed(by: disposeBag)
        birthDayBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.openDatePicker()
        }).disposed(by: disposeBag)
        addNewPatient.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.viewModel?.validateData(name: self?.name.text ?? "", birthDay: self?.birthDayTxt.text ?? "", gender: self?.gender ?? "")
        }).disposed(by: disposeBag)
        backBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
        deletePatient.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.viewModel?.deletePatientData()
        }).disposed(by: disposeBag)
    }
    private func didSelectGenderBtn(isMale: Bool) {
        if isMale {
            gender = "male"
            femaleBtn.setImage(UIImage(named: "unSelected"), for: .normal)
            maleBtn.setImage(UIImage(named: "selected"), for: .normal)
        }else {
            gender = "female"
            femaleBtn.setImage(UIImage(named: "selected"), for: .normal)
            maleBtn.setImage(UIImage(named: "unSelected"), for: .normal)
        }
    }
    private func openDatePicker() {
        let dateView = DatePickerView()
        let options = [SemiModalOption.pushParentBack: false]
        dateView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        self.presentSemiViewController(dateView,options: options, dismissBlock:  {
            dateView.date.rx.date.subscribe(onNext: { [weak self] date in
                self?.birthDayTxt.text = date.fromDateToString(date)
            }).disposed(by: self.disposeBag)
        })
        
    }
    
}
