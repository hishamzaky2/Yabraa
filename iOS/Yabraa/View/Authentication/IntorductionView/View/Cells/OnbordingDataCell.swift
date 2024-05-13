//
//  OnbordingDataCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 18/06/2023.
//

import UIKit

class OnbordingDataCell: UICollectionViewCell {
    @IBOutlet weak var descriptionData: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var logoImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(slider: OnbordingData) {
        logoImage.setImage(from: slider.path ?? "")
        if UserDefualtUtils.isArabic() {
            title.text = slider.titleAr ?? ""
            descriptionData.text = slider.subTitleAr ?? ""
        }else {
            title.text = slider.titleEn ?? ""
            descriptionData.text = slider.subTitleEn ?? ""
        }
    }

}
