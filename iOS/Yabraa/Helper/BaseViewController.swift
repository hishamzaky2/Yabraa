//
//  BaseViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import UIKit
import SwiftMessages
class BaseViewController: UIViewController {
    let loadingView = CircleLoadingView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func openAnimatly(vc: UIViewController, inVC: UIViewController, withHeight: CGFloat,completion: (() -> Void)?) {
        let sheetController = SheetViewController(controller: vc, sizes: [.fixed(withHeight)])
        sheetController.modalPresentationStyle = .overCurrentContext
        sheetController.adjustForBottomSafeArea = true
        sheetController.topCornersRadius = 22
        sheetController.overlayColor = UIColor.black.withAlphaComponent(0.16)
        sheetController.handleColor = UIColor.orange
        sheetController.handleView.isHidden = true
        inVC.present(sheetController, animated: false, completion: completion)
    }
    
    func displayMessage(title: String, message: String, status: Theme) {
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(status, iconStyle: .default )
        success.configureDropShadow()
        success.configureContent(title: title, body: message)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.duration = .seconds(seconds: 3)
        successConfig.presentationStyle = .top
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)
    }
    func displayAlert(icon: ToastStatus,titel: String? = "", message: String,showCancel:Bool? = false,cencelTitle:String = "Cancel".localized,okTitle:String = "Ok".localized,OkAction: (()->())?) {
        DispatchQueue.main.async {
            let alert = AlertView()
            alert.view.frame = self.view.bounds
            alert.titelLBL.isHidden = titel?.isEmpty ?? true
            alert.titelLBL.text = titel
            alert.descriptionLBL.text = message
            alert.icon.image = UIImage(named: icon.rawValue)
            alert.okAction = OkAction
            alert.cancelView.isHidden = !showCancel!
            alert.cancelBTN.setTitle(cencelTitle, for: .normal)
            alert.okBtn.setTitle(okTitle, for: .normal)
            
            self.addChild(alert)
            self.view.addSubview(alert.view)
           
            
        }
       
    }
}
