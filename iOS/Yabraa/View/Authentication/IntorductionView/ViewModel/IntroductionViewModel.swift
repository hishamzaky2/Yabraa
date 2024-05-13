//
//  YBIntroductionViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 17/06/2023.
//

import Foundation
import RxCocoa
import RxSwift
class IntroductionViewModel {
    let disposeBag = DisposeBag()
    let onbordingData = BehaviorRelay<[OnbordingData]>(value: [])
//    var ss: [OnbordingData] = []
    init(onbordingData: [OnbordingData]) {
        self.onbordingData.accept(onbordingData)
    }
//    func ssss() {
//
//    }
//     func getSlider() {
//        NetworkServices.callAPI(withURL: URLS.START_PAGES, responseType: BasicResponse<[OnbordingData]>.self, method: .GET
//                                , parameters: nil)
//        .subscribe(onNext: { response in
//            if response.statusCode ?? 0 == 200 {
//                self.sliders.accept(response.data ?? [])
//            }
//        }, onError: { error in
//            print(error.localizedDescription)
//        })
//        .disposed(by: disposeBag)
//    }
}
