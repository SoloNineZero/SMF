//
//  MainTabBar.swift
//  SMF
//
//  Created by Igor Solodyankin on 08.08.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        viewControllers = [
            createTabBarController(
                viewController: PostsVC(),
                title: "Лента",
                icon: "ellipsis.message"
            ),
            createTabBarController(
                viewController: ViewController2(),
                title: "Избранное",
                icon: "minus"
            )
        ]
    }
    
    /// Возвращает навигационный контроллер с заданным экраном, настроенным для отображения во вкладке таббара.
    private func createTabBarController(viewController: UIViewController, title: String, icon: String) -> UINavigationController {
        let navigationViewController = UINavigationController(rootViewController: viewController)
        viewController.title = title
        viewController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), tag: 0)
        return navigationViewController
    }
}
