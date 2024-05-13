//
//  UIColorsExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import Foundation
import UIKit
extension UIColor {
    static var mainColor: UIColor {
        return UIColor(named: "mainColor") ?? UIColor.red
    }
    static var confirmBtnColor: UIColor {
        return UIColor(named: "confirmBtnColor") ?? UIColor.red
    }
    static var primaryColor: UIColor {
        return UIColor(named: "primaryColor") ?? UIColor.red
    }
    static var grayColor: UIColor {
        return UIColor(named: "grayColor") ?? UIColor.red
    }
}

