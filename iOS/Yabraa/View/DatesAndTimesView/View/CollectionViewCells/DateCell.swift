//
//  DateCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit

class DateCell: UICollectionViewCell {

    @IBOutlet weak var dayNumberLBL: UILabel!
    @IBOutlet weak var dayLBL: UILabel!
    @IBOutlet weak var containerView: UIView!
    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerView.backgroundColor = .black
                dayNumberLBL.textColor = .white
                dayLBL.textColor = .white
            }else {
                containerView.backgroundColor = .primaryColor
                dayNumberLBL.textColor = .black
                dayLBL.textColor = .black
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        setUpUi()
        // Initialization code
    }
    private func setUpUi() {
        DispatchQueue.main.async {
            self.containerView.addShadowToAllEdges(cornerRadius: 5)
        }
    }
    func setUpCell(dayNumber: String,day: String) {
        let dayFormater = day.prefix(3).capitalized
        self.dayLBL.text = dayFormater
        self.dayNumberLBL.text = dayNumber
    }

}
