//
//  AppDelegate.swift
//  WikiLocations
//
//  Created by xdmgzdev on 22/03/2021.
//

import UIKit
import PlistReader

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    #if CONF_STAGE
    print(" 🚀 - Running on STAGE configuration")
    #elseif CONF_PROD
    print(" 🚀 - Running on PROD configuration")
    #endif
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(
    _: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options _: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role
    )
  }

  func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {}
}
