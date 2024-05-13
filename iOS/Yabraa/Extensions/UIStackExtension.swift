//
//  UIStackextension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import Foundation
import UIKit
extension UIStackView{
}
class TappedStack: UIStackView{
    weak var tapDelegate:TappedStackcDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))

            button.addTarget(self, action: #selector(TappedStack.stackTapped), for: .touchUpInside)
            self.addSubview(button)
    }
    
    @objc func stackTapped(){
        tapDelegate?.stackDidTap(self)
    }
}

protocol TappedStackcDelegate:NSObject {
    func stackDidTap(_ stack:TappedStack)
}
