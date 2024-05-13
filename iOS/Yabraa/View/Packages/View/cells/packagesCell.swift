//
//  packagesCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 19/06/2023.
//

import UIKit
import RxCocoa
import RxSwift
class packagesCell: UITableViewCell {
    @IBOutlet weak var selectedIcon: UIImageView!
    @IBOutlet weak var makeAppointmentView: UIView!
    @IBOutlet weak var servcieFees: UILabel!
    @IBOutlet weak var servcieTitel: UILabel!
    @IBOutlet weak var visitsNumber: UILabel!
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var makeAppointMent: UIButton!
    @IBOutlet weak var showMoreBtn: UIButton!
    let disposeBag = DisposeBag()
    var makeAppointmentTapped: (()->())?
    var readMore:(()->())?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        bindButtonActions()
    }
    private func bindButtonActions() {
        makeAppointMent.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.makeAppointmentTapped?()
        }).disposed(by: disposeBag)
        showMoreBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.readMore?()
        }).disposed(by: disposeBag)
    }
    func setUpCell(package: Packages) {
        servcieFees.text = "\(package.price ?? 0)" + " " + "SAR".localized
        servcieTitel.text = UserDefualtUtils.isArabic() ? package.nameAR ?? "" : package.nameEN ?? ""
        visitsNumber.text = UserDefualtUtils.isArabic() ? package.subTitleAR ?? "" : package.subTitleEN ?? ""
        serviceImage.setImage(from: package.imagePath ?? "")
        if package.isSelected ?? false {
            makeAppointmentView.backgroundColor = .mainColor
            selectedIcon.isHidden = false
            makeAppointMent.setTitleColor(.white, for: .normal)
            makeAppointMent.setTitle("appointmentDone".localized, for: .normal)
        }else {
            makeAppointMent.setTitle("Make an Appointment".localized, for: .normal)
            makeAppointmentView.backgroundColor = .primaryColor
            selectedIcon.isHidden = true
            makeAppointMent.setTitleColor(.black, for: .normal)
        }
        
    }
}
