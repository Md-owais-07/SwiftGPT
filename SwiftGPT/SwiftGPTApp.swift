//
//  SwiftGPTApp.swift
//  SwiftGPT
//
//  Created by Owais on 7/30/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct SwiftGPTApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionManager = UserSessionManager()

    var body: some Scene {
        WindowGroup {
            if !sessionManager.isLoggedIn {
                LandingView()
            } else {
                DashboardView()
            }
        }
        .environmentObject(sessionManager)
//        .modelContainer(sharedModelContainer)
    }
}



//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
