//
//  PhotoPicker.swift
//  FitCheck
//
//  Created by John S on 12/3/23.
//

import Foundation
import SwiftUI
import PhotosUI

// TODO: correct other views that called this one
// TODO: display a Vstack of all images from a list of uhhh things. uhh. things. clothing items. yeah that one.

struct PhotoPicker: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
            Text("Select a photo")
        }
        // So this is just an example of displaying an image
        // In real use, "path" would be a clothing item's img_url
        // And "uid" would be the user's id.
        .task{
            do{
                // TODO: Test loading an image from the current user's closet
                let path = "E9901D85-ACE7-4BEC-9D96-D3B292AA30C2.jpeg"
                let uid = "M3uy8QDsYvUVQSrVf1fRHCr7lXz2"
                if let data = try await StorageManager.shared.getImageDataFromPath(userID: uid, path: path){
                    imageData = data
                }
            }
            catch {
                Text("Error loading image for user")
            }
        }
        // Here is the actual important stuff: selecting a photo and updating the clothingItem's img_url.
        .onChange(of: selectedItem, perform: { newValue in
            if let newValue {
                // Generate a unique id for the picture on-the-fly
                let uuid = "\(UUID().uuidString).jpeg"
                newClothingItem.closetObject.img_url = uuid
                // Also saves the clothingObject to the database!
                saveImage(item: newValue, uuid: uuid, clothingData: newClothingItem.closetObject)
            }
        })
        
        // Displaying the test image
        if let imageData, let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
        }
    }
}

// Saves image to the database and adds the clothing item!
func saveImage(item: PhotosPickerItem, uuid: String, clothingData: ClothingItem){
    Task {
        // Adding image to storage
        guard let userID = UserManager.shared.getLoadedData()?.id else { return }
        guard let data = try await item.loadTransferable(type: Data.self) else { return }
        let (path, name) = try await StorageManager.shared.saveImage(userID: userID, data: data, uuid: uuid)
        print("SUCCESS!!")
        print(path)
        print(name)
        
        // Actually add the clothing item to the database!
        // Setting the ID to tempID is very important when adding a clothingItem directly!
        var item = clothingData
        item.id = "tempID"
        item.favorite = true
        if let userID = UserManager.shared.getLoadedData()?.id{
            try await UserManager.shared.addClothingItem(userID: userID, clothingData: item)
        }
    }
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker()
    }
}
