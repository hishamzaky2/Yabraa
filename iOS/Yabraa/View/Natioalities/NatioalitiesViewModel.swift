//
//  NatioalitiesViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/06/2023.
//

import Foundation
import RxCocoa
import RxSwift
class NatioalitiesViewModel {
    let disposeBag = DisposeBag()
    let Natioalities = BehaviorRelay<[NationalitiesData]>(value: [])
    let filteredNatioalities = BehaviorRelay<[NationalitiesData]>(value: [])
    let searchText = PublishRelay<String>()
    
    init() {
    }
    func searchQuery(query: String) {
        if query.isEmpty {
            self.filteredNatioalities.accept(Natioalities.value)
        }else {
            let searchedData = self.Natioalities.value.filter{ nationality in
                let nationalityName =  UserDefualtUtils.isArabic() ? (nationality.countryArNationality ?? "") : (nationality.countryEnNationality ?? "")
                return nationalityName.lowercased().contains(query.lowercased())
            }
            self.filteredNatioalities.accept(searchedData )
        }
    }
    
}
