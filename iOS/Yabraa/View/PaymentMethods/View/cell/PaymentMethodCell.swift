//
//  PaymentMethodCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 03/08/2023.
//

import UIKit

class PaymentMethodCell: UITableViewCell {
    @IBOutlet weak var selected_Image: UIImageView!
    @IBOutlet weak var paymentMethodImage: UIImageView!
    @IBOutlet weak var paymentMethodName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selected_Image.image = selected ? UIImage(named: "selected") : UIImage(named: "unSelected")
    }
    func setUpCell(paymentMethod: PaymentMethod){
        paymentMethodName.text = paymentMethod.shownName.localized
        paymentMethodImage.image = UIImage(named: paymentMethod.image)
    }
    
}
