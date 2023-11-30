//
//  NewAccView.swift
//  backend
//
//  Created by John S on 10/31/23.
//

import SwiftUI
import Firebase

@MainActor
final class NewAccVM: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    var userInfo: UserInfo!
    
    // Collects new user login info and catches invalid entries, does not login user after creation
    func createUser() {
        guard !email.isEmpty, !password.isEmpty else {
            print("Enter a valid email address and password please")
            return
        }

        Task{
            do {
                let loginInfo = try await LoginManager.shared.createUser(email: email, pw: password)
                print ("Success")
                print(loginInfo)
                return
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

// Page view for account creation
struct CreateAcc: View {
    @StateObject private var viewmodel = NewAccVM()
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
                viewmodel.createUser()
            } label: {
                Text("Create Account")
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }
        }
        .navigationTitle("Create Account").padding()
    }
}

#Preview {
    NavigationStack{
        CreateAcc()
    }
}
