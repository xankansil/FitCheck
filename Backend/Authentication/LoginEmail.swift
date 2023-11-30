//
//  LoginEmail.swift
//  backend
//
//  Created by John S on 10/20/23.
//

import SwiftUI
import Firebase

@MainActor
final class LoginEmailVM: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    var userInfo: UserInfo!
    
    // Collects user login info and catches errors for invalid entries
    func login(userInfo: UserInfo) {
        guard !email.isEmpty, !password.isEmpty else {
            print("Enter a valid email address and password please")
            return
        }
        self.userInfo = userInfo
        Task{
            do {
                let loginInfo = try await LoginManager.shared.logIn(email: email, pw: password)
                print ("Success")
                print(loginInfo)
                userInfo.isLoggedIn = true
                return
            } catch {
                print("Error: \(error)")
                return
            }
        }
    }
}

// Page view for the login
struct LoginEmail: View {
    @EnvironmentObject var userInfo: UserInfo
    @StateObject private var viewmodel = LoginEmailVM()
    var body: some View {
        NavigationStack{
            TextField("Email: ", text: $viewmodel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10.0)
                .autocapitalization(.none)
            SecureField("Password: ", text: $viewmodel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10.0)
                .autocapitalization(.none)
            Button{
                viewmodel.login(userInfo: userInfo)
            } label: {
                Text("Login")
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }
        }
        .navigationTitle("Login").padding()
    }
}

#Preview {
    NavigationStack{
        LoginEmail()
    }
}
