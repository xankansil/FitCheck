//
//  StorageManager.swift
//  FitCheck
//
//  Created by John S on 12/3/23.
//

import Foundation
import FirebaseStorage
import SwiftUI
import PhotosUI

final class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    func addDummyImages() {
        
    }
    
    private func userReference(userID: String) -> StorageReference {
        return storage.child("users").child(userID)
    }
    
    func getImageDataFromPath(userID: String, path: String) async throws -> Data? {
        try await userReference(userID: userID).child("images").child(path).data(maxSize: 30 * 1024 * 1024)
    }
    
    func saveImage(userID: String, data: Data, uuid: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(uuid).jpeg"
        let returnedMetaData = try await userReference(userID: userID).child("images").child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
}
