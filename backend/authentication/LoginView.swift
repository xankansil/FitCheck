//
//  LoginView.swift
//  backend
//
//  Created by John S on 10/20/23.

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack{
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
 
