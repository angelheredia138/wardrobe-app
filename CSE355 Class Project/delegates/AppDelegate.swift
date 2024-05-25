//
//  AppDelegate.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 4/13/24.
//

import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let persistenceController = PersistenceController.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create a UIWindow instance with the screen bounds of the device
        self.window = UIWindow(frame: UIScreen.main.bounds)

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)

        // Use a UIHostingController as window rootViewController.
        window?.rootViewController = UIHostingController(rootView: contentView)

        // Make this window visible.
        window?.makeKeyAndVisible()

        return true
    }
}

