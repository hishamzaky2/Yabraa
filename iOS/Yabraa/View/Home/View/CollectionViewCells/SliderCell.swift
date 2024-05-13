//
//  SliderCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import UIKit

class SliderCell: UICollectionViewCell {
    @IBOutlet weak var sliderImage: UIImageView! 
    override func awakeFromNib() {
        super.awakeFromNib()
//        sliderImage.contentMode = .scaleToFill
        // Initialization code
    }
    func configureCell(image:String?) {
        sliderImage.setImage(from: image ?? "")
      
//        titleLBL.text = page.title ?? ""
//        subTitleLBL.text = page.subTitle ?? ""
        
    }

}
