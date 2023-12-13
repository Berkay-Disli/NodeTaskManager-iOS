//
//  MainTabBarView.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import SwiftUI

struct MainTabBarView: View {
    @State private var selection: Int = 1
    // this is a test line
    // this is a second test line
    var body: some View {
        TabView(selection: $selection,
                content:  {
            HomeView()
                .tabItem {
                    Label("All", systemImage: "list.bullet")
                }
                .tag(1)
            BoardMainView()
                .tabItem {
                    Label("Board", systemImage: "rectangle.split.3x1.fill")
                }
                .tag(2)
            ProfileMainView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        })
    }
}

#Preview {
    MainTabBarView()
}
