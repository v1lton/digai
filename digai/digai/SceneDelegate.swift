//
//  SceneDelegate.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: JoinRoomViewController())
        window?.makeKeyAndVisible()
        
        /*
         window?.windowScene = windowScene
        window?.makeKeyAndVisible()

             let viewController = ViewController()
             let navViewController = UINavigationController(rootViewController: viewController)
             window?.rootViewController = navViewController
         */
    }
}

