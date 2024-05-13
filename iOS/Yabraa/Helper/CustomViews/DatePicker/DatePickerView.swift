//
//  DatePickerView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/04/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SemiModalViewController
class DatePickerView: UIViewController {

    @IBOutlet weak var date: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        date.maximumDate = Date()
    }
    @IBAction func DoneTapped(_ sender: Any) {
        dismissSemiModalView()
    }
    
}
