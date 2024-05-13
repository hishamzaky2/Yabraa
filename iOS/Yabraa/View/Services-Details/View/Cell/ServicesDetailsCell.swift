//
//  ServicesDetailsCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/05/2023.
//

import UIKit
import RxCocoa
import RxSwift
class ServicesDetailsCell: UICollectionViewCell {
    @IBOutlet weak var servcieFees: UILabel!
    @IBOutlet weak var servcieTitel: UILabel!
    @IBOutlet weak var visitsNumber: UILabel!
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var makeAppointMent: UIButton!
    let disposeBag = DisposeBag()
    var readMore:(()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(package: Packages) {
        servcieFees.text = "\(package.price ?? 0)" + " " + "SAR".localized
        servcieTitel.text = UserDefualtUtils.isArabic() ? package.nameAR ?? "" : package.nameEN ?? ""
        visitsNumber.text = UserDefualtUtils.isArabic() ? package.subTitleAR ?? "" : package.subTitleEN ?? ""
        serviceImage.setImage(from: package.imagePath ?? "")
        makeAppointMent.backgroundColor = package.isSelected ?? false ? .mainColor : .primaryColor
        
    }
    @IBAction func readMoreTapped(_ sender: Any) {
        self.readMore?()
    }
    
    @IBAction func MakeAppointmentTapped(_ sender: Any) {
    }

}
