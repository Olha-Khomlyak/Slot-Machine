//
//  AppDelegate.swift
//  Slot Machine
//
//  Created by A. Faruk Acar on 8.12.2023.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            windowScene.sizeRestrictions?.minimumSize = CGSize(width: 800, height: 600)
//            windowScene.sizeRestrictions?.maximumSize = CGSize(width: 800, height: 600)
//        }
        print("App Did Launch!")
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            sceneConfig.delegateClass = SceneDelegate.self
            return sceneConfig
        }
}
