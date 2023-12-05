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
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
            Text("Select a photo")
        }.task{
            do{
                // TODO: change temp path to stored, clothingItem imgurl
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
        .onChange(of: selectedItem, perform: { newValue in
            if let newValue {
                saveImage(item: newValue)
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

func saveImage(item: PhotosPickerItem){
    Task {
        guard let userID = UserManager.shared.getLoadedData()?.id else { return }
        guard let data = try await item.loadTransferable(type: Data.self) else { return }
        let (path, name) = try await StorageManager.shared.saveImage(userID: userID, data: data)
        print("SUCCESS!!")
        print(path)
        print(name)
        // TODO: update the clothing item path... do this after xan's OTHER variable stuff is figured out.
    }
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker()
    }
}
