//
//  FullScreenImageViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 24/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
class FullScreenImageViewModel {
    private let disposeBag = DisposeBag()
    var shownImage: Observable<String> {
        return Observable.just(sliderImage)
    }
    private var sliderImage = ""
    init(sliderImage: String) {
        self.sliderImage = sliderImage
    }
}
