//
//  AlertView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/04/2023.
//

import UIKit

class AlertView: UIViewController {

    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var okView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var titelLBL: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var cancelBTN: UIButton!
    var okAction: (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    private func setUpView() {
        okBtn.addShadowToAllEdges(cornerRadius: 15)
        cancelBTN.addShadowToAllEdges(cornerRadius: 15)
    }
   
    @IBAction func okDidTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 0
        }) { _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.okAction?()
        }
    }
    
    @IBAction func cancelDidTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 0
        }) { _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}
