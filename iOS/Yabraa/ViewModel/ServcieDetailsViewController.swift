//
//  ServcieDetailsViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/11/2023.
//

import UIKit

class ServcieDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        view.semanticContentAttribute  = .forceRightToLeft
        print(view.semanticContentAttribute)
    }
}
