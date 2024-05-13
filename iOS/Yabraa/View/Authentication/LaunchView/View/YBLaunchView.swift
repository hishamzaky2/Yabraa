//
//  YBLaunchView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 25/02/2023.
//

import UIKit
import RxCocoa
import RxSwift
class YBLaunchView: BaseViewController {
    var router: YBLuanchRouterProtocol?
    private var viewModel = LuanchViewModel()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeOnbordingData()
        configureView()
        openLandingPage()
        
        // Do any additional setup after loading the view.
    }
    private func configureView() {
        self.navigationController?.navigationBar.isHidden = true
    }
    private func subscribeOnbordingData(){
        viewModel.onbordingData.asDriver(onErrorJustReturn: []).drive(onNext: {[weak self] onbordingData in
            self?.router?.goToOnbordingView(onbordingData: onbordingData)
        }).disposed(by: disposeBag)
    }
    private func openLandingPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if UserDefualtUtils.getIsOnbordingViewed() {
                // check if login or not
                self.checkIfUserLoggedIn()
                
            }else {
                self.viewModel.getOnbording()
            }
        }
    }
    private func checkIfUserLoggedIn() {
        if let token =  UserDefualtUtils.getToken(), !token.isEmpty && UserDefualtUtils.getIsAuthenticated() {
            self.router?.goToTabBarView()
        }else {
            self.router?.goToLoginView()
        }
    }
    
}
