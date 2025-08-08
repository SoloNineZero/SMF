//
//  MainTabBar.swift
//  SMF
//
//  Created by Igor Solodyankin on 08.08.2025.
//

import UIKit

final class MainTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        viewControllers = [
        makeTabBarController(
            viewController: ViewController(),
            title: "Лента",
            icon: "plus",
            tag: 0
        ),
        makeTabBarController(
            viewController: ViewController2(),
            title: "Избранное",
            icon: "minus",
            tag: 1
        )
        ]
    }
    
    /// Возвращает навигационный контроллер с заданным экраном, настроенным для отображения во вкладке таббара.
    private func makeTabBarController(viewController: UIViewController, title: String, icon: String, tag: Int) -> UINavigationController {
        let navigationViewController = UINavigationController(rootViewController: viewController)
        viewController.title = title
        viewController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), tag: tag)
        return navigationViewController
    }
}
