//
//  ServicesCellViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/05/2023.
//

import Foundation
import RxSwift
class ServicesCellViewModel {
    let services = PublishSubject<[OneDimensionalService]>()
    init() {
    }
}
