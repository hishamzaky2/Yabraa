//
//  EditMyAppointmentViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/07/2023.
//

import UIKit
import RxCocoa
import RxSwift
class EditMyAppointmentViewController: BaseViewController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var selectDate: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var selectPatioentName: UIButton!
    @IBOutlet weak var PackageDescription: UITextView!
    @IBOutlet weak var patientNameLBL: UILabel!
    @IBOutlet weak var dateTimeLBL: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var servicetitle: UILabel!
    @IBOutlet weak var serviceName: UILabel!
    var router: EditMyAppointmentRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: EditMyAppointmentViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButtonsAction()
        bindAppointmentData()
        setUpUi()
        bindData()
    }
    private func setUpUi() {
        backBtn.imageView?.FlipImage()
    }
    private func bindData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        viewModel?.didUpdateAppointment.asDriver(onErrorJustReturn: ()).drive(onNext: { [weak self] _ in
            guard let self = self else {return}
            self.displayAlert(icon: .SUCCESS, message: "package Updated Successfully".localized) {
                self.router?.back()
            }
        }).disposed(by: disposeBag)
        viewModel?.didFailsUpdateAppointment
            .subscribe(onNext: { [weak self] error in
                self?.displayMessage(title: error, message: "", status: .error)
            })
            .disposed(by: disposeBag)
    }
    private func bindAppointmentData() {
        viewModel?.appointment.filter{$0 != nil}.asDriver(onErrorJustReturn: nil).drive(onNext: { [weak self] appointmentData in
            guard let self = self else {return}
            if UserDefualtUtils.isArabic() {
                self.servicetitle.text = appointmentData?.serviceAR ?? ""
                self.serviceName.text = appointmentData?.packageNameAR ?? ""
            }else {
                self.servicetitle.text = appointmentData?.serviceEN ?? ""
                self.serviceName.text = appointmentData?.packageNameEN ?? ""
            }
            self.PackageDescription.text = appointmentData?.notes ?? ""
            self.patientNameLBL.text = appointmentData?.userFamilyName ?? ""
            self.servicePrice.text =  String(appointmentData?.price ?? 0.0)
            self.dateTimeLBL.text = self.getPackageDateAndTime(date: appointmentData?.visitDT ?? "", time: appointmentData?.visitTime ?? "")
        }).disposed(by: disposeBag)
    }
    private func getPackageDateAndTime(date: String, time: String) -> String{
        let date = date.prefix(10)
        let time = time.prefix(5)
        return time + " " + date
    }
    private func bindButtonsAction() {
        editBtn.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.router?.goToEditAlert()
        }).disposed(by: disposeBag)
        saveBtn.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.viewModel?.editAppointMent(notes: self?.PackageDescription.text ?? "")
        }).disposed(by: disposeBag)
        backBtn.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
}
extension EditMyAppointmentViewController: selectedEdtingAction {
    func editLocation() {
        router?.routeToMapVC()
        saveBtn.isHidden = false
    }
    func editInfo() {
        PackageDescription.isUserInteractionEnabled = true
        PackageDescription.becomeFirstResponder()
        saveBtn.isHidden = false
    }
}
extension EditMyAppointmentViewController: LocationEditing {
    func didEditLocation(lat: Double, lng: Double) {
        self.viewModel?.appointmentLng.accept(lng)
        self.viewModel?.appointmentLat.accept(lat)
    }
}

