//
//  LoginView.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userManager: UserManager
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Login") {
                    validateAndProceed()
                }
                .padding()
                
                Spacer()
                
                Button("Register") {
                    dismiss()
                }
            }
            .padding()
            .overlay {
                if userManager.isNetworking {
                    ProgressView()
                } else {
                    EmptyView()
                }
            }
            .alert(isPresented: $userManager.operationFailed, content: {
                Alert(title: Text(userManager.errorTitle), message: Text(userManager.errorMessage), dismissButton: .default(Text("Tamam")))
            })
            .navigationTitle("Login")
        }
        .navigationBarBackButtonHidden()
    }
    
    func validateAndProceed() {
        let request = AuthLoginRequest(email: email, password: password)
        
        userManager.login(userLoginRequest: request) { result in
            switch result {
            case .success(_):
                print("SUCCESSFULLY LOGGED IN")
            case .failure(_):
                print("LOGIN FAILED")
            }
        }
    }
}

#Preview {
    LoginView()
}
