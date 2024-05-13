//
//  UITextFieldExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import Foundation
import UIKit

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
       get {
                 return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
             }
             set {
                 guard let attributedPlaceholder = attributedPlaceholder else { return }
                 let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue!]
                 self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
             }
    }
    @IBInspectable var localizedTitle: String {
        set {
            self.placeholder = newValue.localized
        }
        get {
            return self.placeholder ?? ""
        }
    }
}
