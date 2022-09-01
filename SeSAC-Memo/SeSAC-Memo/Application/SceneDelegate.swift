//
//  SceneDelegate.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootViewController = MemoListViewController()
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}

