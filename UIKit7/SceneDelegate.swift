//
//  SceneDelegate.swift
//  UIKit7
//
//  Created by 송재훈 on 8/8/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()
        
        let nav = UINavigationController()
        nav.setViewControllers([UIViewController(), UpbitViewController()], animated: true)
        tabBarController.setViewControllers([nav], animated: true)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
