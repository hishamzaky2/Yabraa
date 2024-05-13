//
//  UIImageExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/04/2023.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageURL,placeholder: UIImage(named: "lunach"),options: [.transition(ImageTransition.fade(0.5))])
    }
    func FlipImage(){
        if UserDefualtUtils.isArabic() {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }else{
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}
