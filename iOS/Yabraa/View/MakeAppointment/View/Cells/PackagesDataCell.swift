//
//  PackagesDataCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 23/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
class PackagesDataCell: UITableViewCell {
    @IBOutlet weak var selectDate: UIButton!
    @IBOutlet weak var selectPatioentName: UIButton!
    @IBOutlet weak var PackageDescription: UITextView!
    @IBOutlet weak var patientNameLBL: UILabel!
    @IBOutlet weak var dateTimeLBL: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var servicetitle: UILabel!
     let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    private func configureCell() {
        dateTimeLBL.adjustsFontSizeToFitWidth = true
        patientNameLBL.adjustsFontSizeToFitWidth = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setUpCell(package: Packages) {
        UserDefualtUtils.isArabic() ? ( self.servicetitle.text = package.nameAR ?? "") : ( self.servicetitle.text =  package.nameEN ?? "")
        if !package.date.isEmpty {
            self.dateTimeLBL.text = package.time +  " - " + package.date
        }else {
            self.dateTimeLBL.text = "Select Date".localized
        }
        if !package.patientName.isEmpty {
            self.patientNameLBL.text = package.patientName
        }else {
            self.patientNameLBL.text = "Select Patient".localized
        }
        if !package.packageDescription.isEmpty {
            self.PackageDescription.text = package.packageDescription
        }else {
            self.PackageDescription.text = ""
        }
        self.servicePrice.text = "\(package.price ?? 0)" + " " + "SAR".localized
    }
  
}
