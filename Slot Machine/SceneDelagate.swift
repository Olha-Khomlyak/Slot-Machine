//
//  SceneDelagate.swift
//  Slot Machine
//
//  Created by A. Faruk Acar on 8.12.2023.
//

import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // FIXED-SIZED APP WINDOW FOR MAC
            if let scene = scene as? UIWindowScene {
              scene.sizeRestrictions?.minimumSize = CGSize.init(width: 600, height: 800)
              scene.sizeRestrictions?.maximumSize = CGSize.init(width: 600, height: 800)
            }
            
            // Create the SwiftUI view that provides the window contents.
            let contentView = ContentView()

            // Use a UIHostingController as window root view controller.
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: contentView)
                self.window = window
                window.makeKeyAndVisible()
            }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
    }
}
