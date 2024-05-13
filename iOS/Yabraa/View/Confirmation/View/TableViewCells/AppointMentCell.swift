//
//  AppointMentCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 17/05/2023.
//

import UIKit
import RxSwift
import RxCocoa
class AppointMentCell: UITableViewCell {
    
    @IBOutlet weak var MoreInfo: UIButton!
    @IBOutlet weak var callyabraa: UIButton!
    @IBOutlet weak var cancelView: UIStackView!
    @IBOutlet weak var moreDetaisl: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var cancelAppointment: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var showServcieDetails: UIButton!
    @IBOutlet weak var serviceTitle: UILabel!
    @IBOutlet weak var serviceDate: UILabel!
    @IBOutlet weak var serviceTime: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var patientName: UILabel!
    var changeServiceLocation: (()->())?
    var cancelAppointmentTapped: (()->())?
    var callYabraaPhone: (()->())?
    var moreInfo: (()->())?
    private let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpButtonActions()
        setUpUi()
    }
    private func setUpUi(){
        moreDetaisl.adjustsFontSizeToFitWidth = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    private func setUpButtonActions() {
        showServcieDetails.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.changeServiceLocation?()
        }).disposed(by: disposeBag)
        cancelAppointment.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.cancelAppointmentTapped?()
        }).disposed(by: disposeBag)
        callyabraa.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.callYabraaPhone?()
        }).disposed(by: disposeBag)
        MoreInfo.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.moreInfo?()
        }).disposed(by: disposeBag)
    }
    func setUpCell(package: Packages) {
        cancelAppointment.isHidden = true
        self.serviceDate.text = package.date
        self.serviceTitle.text = UserDefualtUtils.isArabic() ? (package.nameAR ?? "") : (package.nameEN ?? "")
        self.serviceTime.text = package.time
        self.servicePrice.text = String(package.price ?? 0) + " " + "SAR".localized
        self.patientName.text = package.patientName
    }
    func setUpCell(appointment: MyAppointments) {
        checkStatus(status: appointment.status ?? "")
//        if appointment.status ?? "" == "Pending"{
//            cancelAppointment.isHidden = false
//            self.containerView.backgroundColor = .grayColor
//            showServcieDetails.isHidden = false
//        }else  if appointment.status ?? "" == "Canceled"{
//            self.containerView.backgroundColor = .green
//            showServcieDetails.isHidden = true
//            cancelAppointment.isHidden = true
//        }else {
//            self.containerView.backgroundColor = .mainColor
//            showServcieDetails.isHidden = true
//            cancelAppointment.isHidden = true
//        }
        self.serviceDate.text = (appointment.visitDT ?? "").prefix(10).string
        self.serviceTitle.text = UserDefualtUtils.isArabic() ? (appointment.packageNameAR ?? "") : (appointment.packageNameEN ?? "")
        self.serviceTime.text = (appointment.visitTime ?? "").prefix(5).string
        self.servicePrice.text = String(appointment.price ?? 0) + " " + "SAR".localized
        self.patientName.text = appointment.userFamilyName ?? ""
    }
    private func checkStatus(status: String) {
        showServcieDetails.isHidden = true
        cancelView.isHidden = true
        MoreInfo.isHidden = true
        if status == AppointmentStatus.Pending.rawValue {
            cancelView.isHidden = false
            showServcieDetails.isHidden = false
            self.containerView.backgroundColor = UIColor(hexColorValue: "#771104")
        }else if status == AppointmentStatus.Done.rawValue  {
            MoreInfo.isHidden = false
            self.containerView.backgroundColor = UIColor(hexColorValue: "#AEB8C2")
        }else if status == AppointmentStatus.Canceled.rawValue {
            self.containerView.backgroundColor = UIColor(hexColorValue: "#292D32")
        }else {
            self.containerView.backgroundColor = UIColor(hexColorValue: "#292D32")
        }
    }
}


enum AppointmentStatus: String{
    case Pending = "Pending"
    case Rejected = "Rejected"
    case Done = "Done"
    case Canceled = "Canceled"
}
