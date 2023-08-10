//
//  NodeTaskManager_iOSApp.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 30.07.2023.
//

import SwiftUI

@main
struct NodeTaskManager_iOSApp: App {
    @StateObject private var userManager = UserManager()
    
    @AppStorage("darkModeStatus") var darkModeStatus = false
    
    var body: some Scene {
        WindowGroup {
            if userManager.isLoggedIn {
                MainTabBarView()
                    .environmentObject(userManager)
                    .transition(.opacity.animation(.easeInOut))
                    .preferredColorScheme(darkModeStatus ? .dark : .light)
                    .tint(.orange)
            } else {
                RegisterView()
                    .environmentObject(userManager)
                    .transition(.opacity.animation(.easeInOut))
                    .preferredColorScheme(darkModeStatus ? .dark : .light)
                    .tint(.orange)
            }
        }
    }
}
