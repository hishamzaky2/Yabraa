//
//  MapViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import RxSwift
import RxCocoa
class MapViewModel {
    let selectedPackage = SelectedPackage.shared
    let isFromEditingAppointMent = BehaviorRelay<Bool>(value: false)
    init(isFromEditingAppointMent: Bool) {
        self.isFromEditingAppointMent.accept(isFromEditingAppointMent)
    }
    func setLatAndLng(lat: String, lng: String) {
        selectedPackage.lat = lat
        selectedPackage.lng = lng
    }
}
