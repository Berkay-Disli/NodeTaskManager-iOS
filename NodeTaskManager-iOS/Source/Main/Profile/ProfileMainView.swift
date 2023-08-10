//
//  ProfileMainView.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import SwiftUI

struct ProfileMainView: View {
    @EnvironmentObject var userManager: UserManager
    @AppStorage("darkModeStatus") private var darkModeStatus = false

    
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile View")
                
                Button(action: {
                    userManager.logoutUser()
                }, label: {
                    Text("Logout")
                })
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        darkModeStatus.toggle()
                    }, label: {
                        Image(systemName: "lightbulb.fill")
                            .foregroundStyle(.primary)
                    })
                }
            })
        }
    }
}

#Preview {
    ProfileMainView()
}
