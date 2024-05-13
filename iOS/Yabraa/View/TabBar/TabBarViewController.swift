//
//  TabBarViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 14/05/2023.
//

import UIKit

class TabBarViewController: UIViewController {
    
    @IBOutlet var tabsButtons: [UIButton]!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBarButtonContainerView: UIView!

    private var tabBarViewControllers: [UIViewController]!
    private var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        createViewController()
        self.configureView()
    }
    private func configureView() {
        self.tabBarButtonContainerView.dropShadow()
        didChnageBars(tabsButtons![selectedIndex])
    }
   
    private func createViewController() {
        let homeView = YBHomeViewController()
        HomeRouter(view: homeView).start()
        let remoteVisitView = RemoteVisitViewController()
        RemoteVisitRouter(view: remoteVisitView).start()
//        let profileView = YBProfileView()
//        let notificationsView = YBNotificationView()
        let settingView = YBSettingView()
        SettingRouter(view: settingView).start()
        tabBarViewControllers = [homeView,remoteVisitView,settingView]
    }
    
    private func selectedTab(tag: Int)
    {
        for button in self.tabsButtons! {
            let image = button.imageView?.image
            if button.tag == tag{
                
                button.setImage(image!.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.mainColor), for: .normal)
                button.setTitleColor(.mainColor, for: .normal)
            }else {
                button.setImage(image!.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.black), for: .normal)
                button.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    
    @IBAction func didChnageBars(_ sender: UIButton) {
        let previousIndex = selectedIndex
        self.selectedTab(tag: sender.tag)
        selectedIndex = sender.tag
        let previousVC = tabBarViewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        let vc = tabBarViewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
}
