//
//  PaymentDataSource.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/08/2023.
//

import Foundation
import RxDataSources
enum PaymentDataSources {
    case Payments(title: String,items: [PaymentsSectionItem])
}
enum PaymentsSectionItem {
    case Payments([Items])
}
extension PaymentDataSources: SectionModelType {
    typealias Item = PaymentsSectionItem
    
    var items: [PaymentsSectionItem] {
        switch  self {
        case .Payments(title: _, items: let items):
            return items.map { $0 }
        }
    }
    init(original: PaymentDataSources, items: [Item]) {
        switch original {
        case let .Payments(title: title, items: _):
            self = .Payments(title: title, items: items)
        }
    }
}
extension PaymentDataSources {
    var title: String {
        switch self {
        case .Payments(title: let title, items: _):
            return title
        }
    }
}
