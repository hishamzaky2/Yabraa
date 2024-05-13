//
//  PataintCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit

class PataintCell: UITableViewCell {

    @IBOutlet weak var patientName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(user: UserFamliy) {
        self.patientName.text = user.name ?? ""
    }
    
}
