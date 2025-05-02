//
//  Munch_App.swift
//  Munch!
//
//  Created by Andrew Gao on 4/25/25.
//
import GoogleSignIn
import SwiftUI

@main
struct Munch_App: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView(mainContentView: AnyView(ContentView()))
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
