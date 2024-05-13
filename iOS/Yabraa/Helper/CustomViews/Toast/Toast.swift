//
//  Toast.swift
//  Yabraa
//
//  Created by Hamada Ragab on 31/03/2023.
//

import UIKit

class Toast: UIView {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var message: UILabel!
    static var newInstance: Toast {
        return Bundle.main.loadNibNamed("Toast", owner: self, options: nil)?.first as! Toast
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

}
