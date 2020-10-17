//
//  SceneDelegate.swift
//  RickyAndMorty
//
//  Created by Dennis Vera on 10/17/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    // Initialize the SwiftUI view that provides the window contents.
    let charactersView = CharactersView()
    
    // Use a UIHostingController as window root view controller.
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: charactersView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}
