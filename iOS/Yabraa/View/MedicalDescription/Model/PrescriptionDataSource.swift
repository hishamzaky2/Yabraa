//
//  PrescriptionDataSource.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/11/2023.
//

import Foundation
import RxDataSources
enum PrescriptionDataSource {
    case Attachments(title: String,items: [PrescriptionSectionItem])
    case Notes(title: String,items: [PrescriptionSectionItem])
}
enum PrescriptionSectionItem {
    case Attachments([VisitAttachments])
    case Notes(VisitNotes)
}
extension PrescriptionDataSource: SectionModelType {
    typealias Item = PrescriptionSectionItem
    
    var items: [PrescriptionSectionItem] {
        switch  self {
        case .Attachments(title: _, items: let items):
            return items.map { $0 }
        case .Notes(title: _, items: let items):
            return items.map { $0 }
        }
    }
    init(original: PrescriptionDataSource, items: [Item]) {
        switch original {
        case let .Attachments(title: title, items: _):
            self = .Attachments(title: title, items: items)
        case let .Notes(title: title, items: _):
            self = .Notes(title: title, items: items)
        }
    }
}
extension PrescriptionDataSource {
    var title: String {
        switch self {
        case .Attachments(title: let title, items: _):
            return title
        case .Notes(title: let title, items: _):
            return title
        }
    }
}
