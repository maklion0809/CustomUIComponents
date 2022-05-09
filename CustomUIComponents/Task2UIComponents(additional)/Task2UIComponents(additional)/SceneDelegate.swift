//
//  SceneDelegate.swift
//  Task2UIComponents(additional)
//
//  Created by Tymofii (Work) on 18.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: sceneWindow)
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}

