//
//  YBServiceCheckingView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/05/2023.
//

import UIKit
import RxSwift
import RxCocoa
class YBServiceCheckingView: BaseViewController,UINavigationControllerDelegate {
    @IBOutlet weak var patientNameLBL: UILabel!
    @IBOutlet weak var dateTimeLBL: UILabel!
    @IBOutlet weak var sericeMainTitle: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var servicetitle: UILabel!
    var coordinator: ServiceCheckingCoordinatorDelegate?
    var viewModel: ServiceCheckingViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setUpUi()
    }
    private func setUpUi() {
        self.navigationController?.delegate = self
        dateTimeLBL.adjustsFontSizeToFitWidth = true
    }
    private func bind() {
        let isArabic = UserDefualtUtils.isArabic()
        viewModel?.packgae.asObservable().subscribe(onNext: { package in
            self.servicetitle.text = isArabic ? package?.nameAR ?? "" : package?.instructionEN ?? ""
            self.servicePrice.text = "\(package?.price ?? 0)" + " " + "SAR".localized
            self.sericeMainTitle.text = isArabic ? package?.nameAR ?? "" : package?.nameEN ?? ""
        }).disposed(by: disposeBag)
        viewModel?.selectedDate.bind(to: dateTimeLBL.rx.text).disposed(by: disposeBag)
        viewModel?.selectedPatient.bind(to: patientNameLBL.rx.text).disposed(by: disposeBag)
    }
    private func showAlert() {
        displayMessage(title: "Plaese Choose patient name , date and time For Confirmation", message: "", status: .error)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelTapped(_ sender: Any) {
        self.viewModel?.savePackage()
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func confirmTapped(_ sender: Any) {
        if viewModel?.isAllDataValid.value == true {
            // save package
            self.viewModel?.savePackage()
            self.coordinator?.routeToMapVC()
        }else {
            showAlert()
        }
    }
    
    @IBAction func selectPatientTapped(_ sender: Any) {
        self.coordinator?.goToSelectPatient()
    }
    
    @IBAction func selectDateTapped(_ sender: Any) {
        self.coordinator?.goToSelectDate()
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let previousViewController = navigationController.viewControllers.last {
            // The previous view controller (i.e. the one being popped up) is `previousViewController`
            print("Previous view controller: \(previousViewController)")
        }
    }
}
