//
//  YBSettingView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import UIKit
import RxCocoa
import RxSwift
class YBSettingView: BaseViewController {
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var ArabicBTN: UIButton!
    @IBOutlet weak var EnglishBTN: UIButton!
    var viewModel: SettingViewModel?
    let disposeBag = DisposeBag()
    var router: SettingRouterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
//        didChangeLanguage()
        setUpButton()
        bindData()
        bindTableViewData()
        getUserInfo()
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    @objc func setText(){
//        reset()
    }
    private func didChangeLanguage() {
        viewModel?.didChangeLanguage.asDriver(onErrorJustReturn: ()).drive(onNext: {[weak self] _ in
//            MOLH.reset(transition: .beginFromCurrentState,duration: 2)
//            self?.reset()
        }).disposed(by: disposeBag)
    }
    private func bindTableViewData() {
        settingTableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
        settingTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel?.settingData.bind(to: settingTableView.rx.items(cellIdentifier: "SettingCell",cellType: SettingCell.self)){ (index, model, cell) in
            cell.setUpCell(titleText: model.localized)
        }.disposed(by: disposeBag)
        settingTableView.rx.modelSelected(String.self).subscribe(onNext: {[weak self] cellTitle in
            self?.didSelectSettingCell(cellTitle: cellTitle)
        }).disposed(by: disposeBag)
    }
    private func didSelectSettingCell(cellTitle: String) {
        switch cellTitle.localized {
        case "medicalProfile".localized:
            router?.goToPatientsProfileView()
        case "myAppointments".localized:
            router?.goToMyAppoinmentsView()
        case "payments".localized:
            router?.goToMyPaymentsView()
        case "deleteAccount".localized:
            deleteAccount()
        case "addPatient".localized:
            router?.goToAddPatient()
        case "contactUs".localized:
            router?.routeToContactUsVC()
        default:
            print("Not Selecte")
        }
    }
    private func bindData() {
        ArabicBTN.rx.tap.asDriver().drive(onNext: { [weak self] _ in
//            self?.viewModel?.setLanguage(language: "ar")
            LocalizationManager.shared.setLanguage(language: .Arabic)
        }).disposed(by: disposeBag)
        EnglishBTN.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            LocalizationManager.shared.setLanguage(language: .English)
//            self?.viewModel?.setLanguage(language: "en")
        }).disposed(by: disposeBag)
//        ArabicBTN.rx.tap.bind(to: viewModel!.isArabicTapped).disposed(by: disposeBag)
//        EnglishBTN.rx.tap.bind(to: viewModel!.isEnglishTapped).disposed(by: disposeBag)
        logoutBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.lougOut()
        }).disposed(by: disposeBag)
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)

        viewModel?.fullName.bind(to: userName.rx.text).disposed(by: disposeBag)
    }
    private func lougOut() {
        displayAlert(icon: .INFO, message: "Are you sure you want to log out ?".localized, showCancel: true) {
            self.viewModel?.logout()
            self.router?.goToLoginView()
        }
    }
    private func deleteAccount() {
        displayAlert(icon: .WARING, message: "Are you sure you want to delete Your account ?".localized, showCancel: true,cencelTitle: "No".localized,okTitle: "Yes".localized) {
            self.viewModel?.deleteAccount()
        }
        viewModel?.didAccountDeleted.asDriver(onErrorJustReturn: ()).drive(onNext: {[weak self] _ in
            self?.displayAlert(icon: .INFO, message: "account Deleted Succesfully !".localized, showCancel: false) {
                self?.router?.goToLoginView()
            }
        }).disposed(by: disposeBag)
    }
    private func setUpButton() {
        EnglishBTN.setTitle("English", for: .normal)
        ArabicBTN.setTitle("عربي", for: .normal)
        viewModel?.isEnglish.subscribe {   isEnglish in
            if isEnglish {
                self.EnglishBTN.setTitleColor(.white, for: .normal)
                self.EnglishBTN.backgroundColor = .mainColor
            }else {
                self.EnglishBTN.setTitleColor(.black, for: .normal)
                self.EnglishBTN.backgroundColor = .primaryColor
            }
        }.disposed(by: disposeBag)
        viewModel?.isArabic.subscribe { isArbic in
            if isArbic {
                self.ArabicBTN.setTitleColor(.white, for: .normal)
                self.ArabicBTN.backgroundColor = .mainColor
            }else {
                self.ArabicBTN.setTitleColor(.black, for: .normal)
                self.ArabicBTN.backgroundColor = .primaryColor
            }
        }.disposed(by: disposeBag)
        
    }
    private func getUserInfo() {
        editProfile.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.viewModel?.getUserInfo()
        }).disposed(by: disposeBag)
        viewModel?.userInfo.asDriver(onErrorJustReturn: nil).drive(onNext: {[weak self] userInfo in
            guard let userInfo = userInfo else {return}
            self?.router?.routeToRegisterVC(userInfo: userInfo)
        }).disposed(by: disposeBag)
    }
    
}
extension YBSettingView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
//    func reset() {
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let window = windowScene.windows.first {
//            let luanchView = YBLaunchView()
//            YBLuanchRouter(view:luanchView).start()
//            let navigationController = UINavigationController(rootViewController: luanchView)
//            navigationController.navigationBar.isHidden = true
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//        }
//        var appDelegate = UIApplication.shared().delegate as! AppDelegate {
            
//            let navigation = UINavigationController(rootViewController: luanchView)
//            navigation.navigationBar.isHidden = true
//        UIWindow.key?.rootViewController = navigation
//        UIWindow.key?.makeKeyAndVisible()
            //        chnageLoactization()
            //        UICollectionView.appearance().semanticContentAttribute = MOL]HLanguage.isArabic() ? .forceRightToLeft : .forceLeftToRight
//        }
//    }
//}
//
//extension UIWindow {
//    static var key: UIWindow! {
//        if #available(iOS 13, *) {
//            return UIApplication.shared.windows.first { $0.isKeyWindow }
//        } else {
//            return UIApplication.shared.keyWindow
//        }
//    }
//}
