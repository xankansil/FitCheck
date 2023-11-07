//
//  UserManager.swift
//  backend
//
//  Created by John S on 11/6/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser {
    let userId: String
    let dateCreated: Date?
}

// Comment to commit

final class UserManager {
    
    // (Just Singleton Thingz)
    static let shared = UserManager()
    private init() { }
    
    func createNewUser(loginData: LoginData) async throws {
        // Create userdata given auth
        let userData: [String:Any] = [
            "user_id" : loginData.uid,
            "email" : loginData.email ?? "",
            "photo_url" : loginData.photoUrl ?? ""
            // TODO: date created
            // TODO: saving data during the app
        ]
        let exampleClothingData: [String: Any] = [
            "id" : "testID String",
            "pic" : "test img ref",
            "type" : "hat",
            "weather" : "sunny",
            "occasion" : "ball",
            "color" : [1, 2, 3],
            "date" : "timestamp TODO",
            "worn" : "buncha dates here",
            "clean" : true
        ]
        // Set user data in database
        try await Firestore.firestore().collection("users").document(loginData.uid).setData(userData, merge: false)
        // Set dummy closet / outfits values
        try await Firestore.firestore().collection("users").document(loginData.uid).collection("closet").addDocument(data: exampleClothingData)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let dateCreated = data["date_created"] as? Date
        // etc etc, copy basically the "create user" data for now
        
        return DBUser(userId: userId, dateCreated: dateCreated)
    }
    
}
