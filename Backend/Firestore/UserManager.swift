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
    let email: String
    let dateCreated: Date?
}

final class UserManager {
    
    // (Just Singleton Thingz)
    static let shared = UserManager()
    private init() { }
    
    func createNewUser(loginData: LoginData) async throws {
        // Create userdata given auth
        let userData: [String:Any] = [
            "user_id" : loginData.uid,
            "email" : loginData.email ?? "",
            "photo_url" : loginData.photoUrl ?? "",
            "date_created" : Date()
        ]
        let exampleClothingData: [String: Any] = [
            "id" : "testID String",
            "pic" : "test img ref",
            "type" : "hat",
            "weather" : "sunny",
            "occasion" : "ball",
            "color" : [1, 2, 3],
            "date" : Date(),
            "worn" : [],
            "clean" : true
        ]
        // Set user data in database
        try await Firestore.firestore().collection("users").document(loginData.uid).setData(userData, merge: false)
        // Set dummy closet / outfits values
        try await Firestore.firestore().collection("users").document(loginData.uid).collection("closet").addDocument(data: exampleClothingData)
    }
    
    
    /**   GETTERS   **/
    
    
    // Getting user information and storing it in a global struct
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        guard let data = snapshot.data(), let email = data["email"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let dateCreated = data["date_created"] as? Date
        
        return DBUser(userId: userId, email: email, dateCreated: dateCreated)
    }
    
    // Getting a piece of clothing
    func getClothing(userId: String) async throws{
        
    }
    
    // Getting an outfit
    func getOutfit(userId: String) async throws{
        
    }
    
    
    /**   SETTERS  **/
    
    
    // Setting userInfo
    func setUser(UserId: String) async throws -> DBUser{
        // TODO: allow the function to alter current database values, return new user struct
        abort()
    }
    
    // Creating a new piece of clothing (do not allow users to alter them)
    func createClothing(UserId: String) async throws{
        // TODO: have it take in the required clothing parameters and create/save a new object
    }
    
    // Creating a new outfit
    func createOutfit(UserId: String) async throws{
        // TODO: create an array of clothing id's
    }
    
    
    /**   DELETE   **/
    
    
    // Delete user
    func deleteUser(UserId: String) async throws{
        // TODO: have it remove the users info from the database & put them at login screen
    }
    
    // Delete clothing item and remove it from outfits it's in
    func deleteClothing(UserId: String) async throws{
        // TODO: remove a piece of clothing from the database and remove it from any outfits that it is in
    }
    
    // Delete an outfit
    func deleteOutfit(UserId: String) async throws{
        // TODO: remove an outfit from the database
    }
}
