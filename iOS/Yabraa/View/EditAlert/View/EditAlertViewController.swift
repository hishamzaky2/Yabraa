//
//  EditAlertViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/07/2023.
//

import UIKit
import RxCocoa
import RxSwift
protocol selectedEdtingAction:AnyObject {
    func editLocation()
    func editInfo()
}
class EditAlertViewController: UIViewController {
    @IBOutlet weak var editLocation: UIButton!
    @IBOutlet weak var editCurrentInfo: UIButton!
    @IBOutlet weak var dismissBtn: UIButton!
    let disposeBag = DisposeBag()
    weak var delegate: selectedEdtingAction?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButtonsAction()
        // Do any additional setup after loading the view.
    }
    private func bindButtonsAction() {
        dismissBtn.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        editCurrentInfo.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.dismiss(animated: true,completion: {
                self.delegate?.editInfo()
            })
        }).disposed(by: disposeBag)
        editLocation.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.dismiss(animated: true,completion: {
                self.delegate?.editLocation()
            })
        }).disposed(by: disposeBag)
    }
}
