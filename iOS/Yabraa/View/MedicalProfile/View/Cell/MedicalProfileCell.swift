//
//  MedicalProfileCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import UIKit

class MedicalProfileCell: UITableViewCell {

    @IBOutlet weak var serviceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(diseaseName: String) {
        serviceName.text = diseaseName
    }
    
}
