//
//  File.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import Foundation
class YBIntroductionRouter {
    weak var view: YBIntroductionView?
    init(view: YBIntroductionView) {
        self.view = view
    }
    func start(onbordingData: [OnbordingData]) {
        view?.router = self
        view?.viewModel = IntroductionViewModel(onbordingData: onbordingData)
    }
    func goToLogin() {
        let registerView = YBLogInView()
        YBLoginRouter(view: registerView).start()
        view?.navigationController?.pushViewController(registerView, animated: true)
    }
}
