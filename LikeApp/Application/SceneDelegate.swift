//
//  SceneDelegate.swift
//  LikeApp
//
//  Created by c.toan on 21.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
//        let presenter = MainViewPresenter()
//        let viewController = MainViewController(presenter: presenter)
//        presenter.view = viewController
//        window.rootViewController = viewController
        let viewController = TableViewController()
        let navController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
    }
}

