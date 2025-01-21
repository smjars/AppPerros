//
//  AppPerrosApp.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AppPerrosApp: App {
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
/*
 asi es como lo recomienda google, lo deje como lo tenia
  
 
 var body: some Scene {
     WindowGroup {
         ContentView()
     }
 }
}*/
