//
//  YBTabBarRouter.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import Foundation
class YBTabBarRouter {
    weak var view: TabBarViewController?
    init(view: TabBarViewController) {
        self.view = view
    }
    func start() {
//        view?.router = self
    }
}
