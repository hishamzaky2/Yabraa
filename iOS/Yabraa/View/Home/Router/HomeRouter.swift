

import Hero
protocol HomeRouterProtocol: AnyObject {
    func goToPackges(service: OneDimensionalService)
    func showFullImages(images: String)
    func goToNotifications()
}
class HomeRouter {
    
    weak var viewController: YBHomeViewController?
    init(view: YBHomeViewController) {
        self.viewController = view
    }
    func start() {
        self.viewController?.router = self
        let viewModel = HomeViewModel()
        viewController?.viewModel = viewModel
    }
}

extension HomeRouter: HomeRouterProtocol {
    func goToPackges(service: OneDimensionalService) {
        let packagesVC = YBPackagesView()
        PackagesRouter(view: packagesVC).start(service: service)
        packagesVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(packagesVC, animated: true)
    }
    func goToNotifications() {
        let notificationsVC = NotificationsViewController()
        NotificationsRouter(view: notificationsVC).start()
        notificationsVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(notificationsVC, animated: true)
    }
    func showFullImages(images: String) {
        let fullScreenImageVC = FullScreenImageViewController()
        FullScreenImageRouter(view: fullScreenImageVC).start(images: images)
//        fullScreenImageVC.modalTransitionStyle = .crossDissolve
        fullScreenImageVC.modalPresentationStyle = .fullScreen
//        fullScreenImageVC.sliderImage.alpha = 0
        fullScreenImageVC.hero.isEnabled = true
        fullScreenImageVC.hero.modalAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
        viewController?.present(fullScreenImageVC, animated: true)
    }
}

