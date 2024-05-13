//
//  TableViewDataSources.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/05/2023.
//

import Foundation
import RxDataSources
enum TableViewDataSources {
    case Gallery(title: String,items: [HomeSectionItem])
    case Services(title: String,items: [HomeSectionItem])
}
enum HomeSectionItem {
    case Gallery([String])
    case Services([OneDimensionalService])
}
extension TableViewDataSources: SectionModelType {
    typealias Item = HomeSectionItem
    
    var items: [HomeSectionItem] {
        switch  self {
        case .Gallery(title: _, items: let items):
            return items.map { $0 }
        case .Services(title: _, items: let items):
            return items.map { $0 }
        }
    }
    var weight: Int {
        switch self {
        case .Gallery: return 1
        case .Services: return 2
        }
    }
    init(original: TableViewDataSources, items: [Item]) {
        switch original {
        case let .Gallery(title: title, items: _):
            self = .Gallery(title: title, items: items)
        case let .Services(title: title, items: _):
            self = .Services(title: title, items: items)
        }
    }
}
extension TableViewDataSources {
    var title: String {
        switch self {
        case .Gallery(title: let title, items: _):
            return title
        case .Services(title: let title, items: _):
            return title
        }
    }
}
