//
//  CollectionViewDelegate.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/04/2023.
//

import Foundation
import UIKit

extension YBHomeViewController: HandlecollectionSlidersCell {
    func didSelectCell(at index: Int) {
        let showedImages = viewModel?.Gallery.value ?? []
        router?.showFullImages(images: showedImages[index])
    }
    
}

