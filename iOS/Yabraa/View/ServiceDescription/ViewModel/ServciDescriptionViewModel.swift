//
//  ServciDescriptionViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 15/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
class ServciDescriptionViewModel{
    let package = BehaviorRelay<Packages?>(value: nil)
    let confirmSevicesTapped = BehaviorRelay<Int?>(value: nil)

    private let disposeBag = DisposeBag()
    init(package: Packages) {
        self.package.accept(package)
    }
}
