//
//  SceneDelegate.swift
//  WikiLocations
//
//  Created by xdmgzdev on 22/03/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, ScreenStackProtocol {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo _: UISceneSession,
    options _: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    window = windowForScene(windowScene)
    window?.makeKeyAndVisible()
    window?.windowScene = windowScene
  }
}
