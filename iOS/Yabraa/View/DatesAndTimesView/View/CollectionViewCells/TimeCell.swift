//
//  TimeCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit

class TimeCell: UICollectionViewCell {
    @IBOutlet weak var timeLBL: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        setUpUi()
        // Initialization code
    }
    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerView.backgroundColor = .black
                timeLBL.textColor = .white
            }else {
                containerView.backgroundColor = .primaryColor
                timeLBL.textColor = .black

            }
        }
    }
    private func setUpUi() {
        containerView.addShadowToAllEdges(cornerRadius: 5)
    }
    func setUpCell(time: Times) {
        self.timeLBL.text = time.hourNameEn
    }
}
