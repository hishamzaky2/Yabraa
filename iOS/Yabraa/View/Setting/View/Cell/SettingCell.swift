//
//  SettingCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 24/05/2023.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var settingTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(titleText: String) {
        settingTitle.text = titleText
    }
    
}

