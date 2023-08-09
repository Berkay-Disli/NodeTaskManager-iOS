//
//  ProfileMainView.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import SwiftUI

struct ProfileMainView: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        VStack {
            Text("Profile View")
            
            Button(action: {
                userManager.logoutUser()
            }, label: {
                Text("Logout")
            })
        }
    }
}

#Preview {
    ProfileMainView()
}
