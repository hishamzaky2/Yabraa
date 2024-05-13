//
//  BaseRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 07/03/2023.
//

import Foundation
import UIKit
class BaseRouter {
    func dismissView(view: UIViewController?) {
        view?.navigationController?.popViewController(animated: true)
    }
}
