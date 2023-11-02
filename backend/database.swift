//
//  backendApp.swift
//  backend
//
//  Created by John S on 10/19/23.
//

import SwiftUI
import FirebaseCore

@main
struct backendApp: App {
    
    // Idk wtf this is
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Calling login view for create or login
    var body: some Scene {
        WindowGroup {
            TopView()
                .environmentObject(UserInfo())
        }
    }
}

// Securing connection to database
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        print("Successfully Pinged Database")
        return true
    }
}
