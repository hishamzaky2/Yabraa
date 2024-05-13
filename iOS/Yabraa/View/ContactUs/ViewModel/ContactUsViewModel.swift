//
//  ContactUsViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 14/11/2023.
//

import Foundation
import RxSwift
import RxCocoa
class ContactUsViewModel {
    private let disposeBag = DisposeBag()
    let contactUs = PublishSubject<String>()
    func viewDidLoad() {
        contactUs.onNext("contactUsInfo".localized)
    }
    
}
