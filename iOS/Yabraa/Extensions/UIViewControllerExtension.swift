//
//  UIViewControllerExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 31/03/2023.
//

import Foundation
import UIKit
extension UIViewController {
    func showHud(showLoding: Bool){
        if showLoding {
            self.view.isUserInteractionEnabled = false
            spinner().showAddedto(self.view)
        }else {
            self.view.isUserInteractionEnabled = true
            spinner().hideFrom(self.view)
        }
        
    }
}
