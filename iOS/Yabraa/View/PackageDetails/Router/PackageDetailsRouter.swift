//
//  PackageDetailsRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 22/06/2023.
//

import Foundation
protocol PackageDetailsRouterProtocol: AnyObject {
    func back()
}
class PackageDetailsRouter {
    
    weak var viewController: YBPackageDetailsView?
    init(view: YBPackageDetailsView) {
        self.viewController = view
    }
    func start(package: Packages?,isShowMore: Bool) {
        self.viewController?.router = self
        let viewModel = PackageDetailsViewModel(isShowMore: isShowMore)
        viewModel.package.accept(package)
        viewController?.viewModel = viewModel
    }
   
}

extension PackageDetailsRouter:PackageDetailsRouterProtocol {
    func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
