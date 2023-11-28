//
//  LoginManager.swift
//  backend
//
//  Created by John S on 10/20/23.
//

import Foundation
import Firebase

// Struct to store user data, and auto constructor to assign values
struct LoginData {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class LoginManager {
    static let shared = LoginManager()
    private init(){ }
    
    // Creating a new user and return user info
    func createUser(email: String, pw: String) async throws -> LoginData {
        let logDataRes = try await Auth.auth().createUser(withEmail: email, password: pw)
        let loginData = LoginData(user: logDataRes.user)
        try await UserManager.shared.createNewUser(loginData: loginData)
        return loginData
    }
    
    // Log in user and return user info
    func logIn(email: String, pw: String) async throws -> LoginData {
        let logDataRes = try await Auth.auth().signIn(withEmail: email, password: pw)
        let loginData = LoginData(user: logDataRes.user)
        return loginData
    }
}
