//
//  UIButtonExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/02/2023.
//

import Foundation
import UIKit
extension UIButton {
    @IBInspectable var localizedTitle: String {
        set {
            self.setTitle(newValue.localized, for: .normal)
        }
        get {
            return self.titleLabel?.text ?? ""
        }
    }
   
}
class VerticalButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentHorizontalAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerButtonImageAndTitle()
    }
    
    private func centerButtonImageAndTitle() {
        let titleSize = self.titleLabel?.frame.size ?? .zero
        let imageSize = self.imageView?.frame.size  ?? .zero
        
        let spacing: CGFloat = 6.0
        if UserDefualtUtils.isArabic() {
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing),left: -titleSize.width, bottom: 0, right:  0)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -(imageSize.height + spacing), right: -imageSize.width)
        }else {
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing),left: 0, bottom: 0, right:  -titleSize.width)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        }
    }
}
