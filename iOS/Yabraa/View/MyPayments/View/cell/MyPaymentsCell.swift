//
//  MyPaymentsCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/08/2023.
//

import UIKit

class MyPaymentsCell: UITableViewCell {
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var serviceTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(item: Items) {
        if UserDefualtUtils.isArabic() {
            serviceTitle.text = item.serviceAR ?? ""
            serviceName.text = item.packageNameAR ?? ""
        }else {
            serviceTitle.text = item.serviceEN ?? ""
            serviceName.text = item.packageNameEN ?? ""
        }
        if item.status ?? "" == "Canceled" {
            servicePrice.text = String(item.price ?? 0.0) + " " + "SAR".localized + " - "
            servicePrice.textColor = UIColor(hexColorValue: "#429849")
        }else if item.status ?? "" == "Pending" {
            servicePrice.text = String(item.price ?? 0.0) + " " + "SAR".localized + " + "
            servicePrice.textColor = UIColor(hexColorValue: "#c55345")
        }
    }
    
}

