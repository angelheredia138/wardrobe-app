//
//  CSE355_Class_ProjectApp.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 3/17/24.
//

import SwiftUI

@main
struct CSE355_Class_ProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


