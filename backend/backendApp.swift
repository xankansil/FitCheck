//
//  backendApp.swift
//  backend
//
//  Created by John S on 10/19/23.
//

import SwiftUI
import FirebaseCore


// https://www.youtube.com/watch?v=4FAuU5Ev-5Y
// Fireship.io - Cloud functions master course


@main
struct backendApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                LoginView()
            }
            //RootView()
        }
    }
 }

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()
    print("Configured Database!")
    return true
  }
}

/*
@main
struct YourApp: App {

  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
    }
  }
}
 */
