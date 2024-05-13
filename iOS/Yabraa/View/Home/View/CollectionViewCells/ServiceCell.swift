//
//  ServiceCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 27/08/2023.
//

import UIKit

class ServiceCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var serviceImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }
    func setUpcell(service: OneDimensionalService) {
        serviceImage.setImage(from: service.imagePath ?? "")
        serviceName.text =  UserDefualtUtils.isArabic() ? service.nameAR ?? "" : service.nameEN ?? ""
    }
    private func configureView() {
       
        DispatchQueue.main.async {
            self.containerView.addShadowToAllEdges(cornerRadius: 10)
            self.serviceName.adjustsFontSizeToFitWidth = true
            
//            self.contentView.addGradientBorder(to: [.top, .bottom, .left, .right])
//            self.contentView.addShadow(to: [.right,.left,.bottom,.top],radius: 5,opacity: 0.2,color: shadowColor!)
//            self.contentView.addShadow(to: [.bottom],radius: 6,opacity: 0.2,color: shadowColor!)
        }
    }
   
   
}
//extension UIView {
//    func dropSwhadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
//    self.layer.masksToBounds = false
//    self.layer.shadowColor = color.cgColor
//    self.layer.shadowOpacity = opacity
//    self.layer.shadowOffset = offSet
//    self.layer.shadowRadius = radius
//    self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//    self.layer.shouldRasterize = true
//    self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//}
