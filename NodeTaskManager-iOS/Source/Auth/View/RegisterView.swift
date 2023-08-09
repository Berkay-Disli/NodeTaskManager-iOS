//
//  RegisterView.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 30.07.2023.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.username)
                
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Register") {
                    validateAndProceed()
                }
                .padding()
                
                Spacer()
                
                NavigationLink("Login") {
                    LoginView()
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
            .navigationTitle("Register")
            
        }
    }
    
    func validateAndProceed() {
        let user = UserModel(username: username, email: email, password: password)
        
        userManager.register(user: user) { result in
            switch result {
            case .success(_):
                print("SUCCESSFULLY REGISTERED")
            case .failure(_):
                print("REGISTER FAILED")
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
