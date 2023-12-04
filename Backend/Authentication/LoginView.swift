//
//  LoginView.swift
//  backend
//
//  Created by John S on 10/20/23.

import SwiftUI

// Page to allow user to create acc or login
struct LoginView: View {
    var body: some View {
        VStack{
            Text("Hello! Welcome to FitCheck!")
                .font(.system(size: 20))
                .fontWeight(.bold)

            NavigationLink{
                LoginEmail()
            } label: {
                Text("Login With Email")
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }
            
            Text("New User? Create an account below!")
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
            
            NavigationLink{
                CreateAcc()
            } label: {
                Text("Create Account")
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }
        }
        .navigationTitle("Log In")
        .font(.headline)
    }
}

#Preview {
     NavigationStack{
         LoginView()
     }
 }
