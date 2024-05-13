//
//  dropMenuCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import UIKit

class dropMenuCell: UITableViewCell {
    @IBOutlet weak var cellData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        cellData.textColor = selected ? .mainColor : .black
    }
    func setUpCell(natioalitiy: NationalitiesData) {
        cellData.text = UserDefualtUtils.isArabic() ? (natioalitiy.countryArNationality ?? "") : (natioalitiy.countryEnNationality ?? "")
    }
    
}
