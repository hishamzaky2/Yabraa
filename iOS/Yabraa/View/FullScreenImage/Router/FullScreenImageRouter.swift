//
//  FullScreenImageRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 24/10/2023.
//

import Foundation
protocol FullScreenImageRouterProtocol: AnyObject {
    func back()
}
class FullScreenImageRouter {
    weak var viewController: FullScreenImageViewController?
    init(view: FullScreenImageViewController) {
        self.viewController = view
    }
    func start(images: String) {
        self.viewController?.router = self
        let viewModel = FullScreenImageViewModel(sliderImage: images)
        viewController?.viewModel = viewModel
    }
}

extension FullScreenImageRouter:FullScreenImageRouterProtocol {
    func back() {
        viewController?.dismiss(animated: true)
    }
}

