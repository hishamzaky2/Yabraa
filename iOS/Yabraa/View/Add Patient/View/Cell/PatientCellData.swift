//
//  PatientCellData.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/07/2023.
//

import UIKit
import RxCocoa
import RxSwift
class PatientCellData: UITableViewCell {
    @IBOutlet weak var upatePatientData: UIButton!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var updateLBL: UILabel!
    var updatePatient: (()->())?
    let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
//        bindButtonsActions()
        // Initialization code
    }
    private func bindButtonsActions() {
        upatePatientData.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.updatePatient?()
        }).disposed(by: disposeBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setUpCell(user: UserFamliy) {
        if user.isOwner ?? false {
            updateLBL.isHidden = true
        }else {
            updateLBL.isHidden = false
        }
        patientName.text = user.name ?? ""
    }
    
}
