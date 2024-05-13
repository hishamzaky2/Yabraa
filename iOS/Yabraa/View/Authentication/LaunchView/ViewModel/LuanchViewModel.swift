//
//  LuanchViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 05/11/2023.
//

import Foundation
import RxCocoa
import RxSwift
class LuanchViewModel {
   private let disposeBag = DisposeBag()
    let onbordingData = PublishSubject<[OnbordingData]>()
    func getOnbording() {
       NetworkServices.callAPI(withURL: URLS.START_PAGES, responseType: BasicResponse<[OnbordingData]>.self, method: .GET
                               , parameters: nil)
       .subscribe(onNext: { response in
           if response.statusCode ?? 0 == 200 {
               self.onbordingData.onNext(response.data ?? [])
           }
       }, onError: { error in
           print(error.localizedDescription)
       })
       .disposed(by: disposeBag)
   }
}
