//
//  UILabelExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/02/2023.
//

import Foundation
import UIKit
extension UILabel {
    @IBInspectable var localizedTitle: String {
        set {
            self.text = newValue.localized
        }
        get {
            return self.text ?? ""
        }
    }
}
