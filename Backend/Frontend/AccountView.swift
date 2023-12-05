//
//  ContentView.swift
//  profilepage
//
//  Created by Xantia Kansil on 11/30/23.
//

import SwiftUI

private struct ImageData: Identifiable {
    var id: String?
    var data: Data?
}

struct AccountView: View {
    @State private var name: String? = nil
    @State private var uid: String? = nil
    @State private var favorites = [ClothingItem]()
    @State private var imageData = [ImageData]()
    
    // TODO: retrieve email from database and display when updated  (DONE!)
    // TODO: added padding so name doesn't hang off the screen  (DONE!)
    // TODO: (also added some padding to createOutfit view so you can read page title)  (DONE!)
    // TODO: had to get rid of all "favorite: true" dummy items (because none will have valid img_urls) (DONE!)
    // TODO: make it so that all in-app-added clothing items are automatically favorited (for testing)  (DONE!)
    // TODO: query for favorited items  (DONE!)
    // TODO: add custom ImageData struct to be identifiable in a ForEach struct (DONE!)
    // TODO: add task to retrieve image data for the first of your favorite items   (DONE!)
    // TODO: properly display the first of your favorited items (DONE!)
    // TODO: add task to retrieve image data for entire list of clothing items  (DONE!)
    // TODO: display an image for each of the retrieved items   (DONE!)
    // TODO: adjust title   (DONE!
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    // INSERT PROFILE PHOTO HERE
                    Image(.emoji)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130)
                        .padding(8)
                        .padding()
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                VStack{
                    // NAME
                    if let name {
                        Text("\(name))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .offset(x: -60, y: -20)
                            .padding([.leading], 20)
                    } else {
                        Text("Xan Kansil")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .offset(x: -60, y: -20)
                            .padding([.leading], 20)
                    }
                    // INSERT BIO
                    Text("Favorite Season: Summer")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .offset(x: -20, y: -20)
                    Text("Favorite Clothing Item: low rise jeans")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .offset(x: 25, y: -20)
                    Text("Favorite Pair of Shoes: Adidas Sambas")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .offset(x: 33, y: -20)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .task {
                        let userInfo = UserManager.shared.getLoadedData()
                        name = userInfo?.email
                        uid = userInfo?.id
                        if(uid != nil) {
                            print(uid!)
                        }
                    }
                
                // Favorited Clothing
                Text("Favorited Clothing")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .offset(x: -60, y: 40)
                    .padding()
                
                // INSERT FAVORITED CLOTHING HERE
                let userInfo = UserManager.shared.getLoadedData()
                if (userInfo != nil) {
                    if(userInfo!.id != nil) {
                        ScrollView{
                            VStack(alignment: .leading, spacing: 20){

                                // Displaying each image, per the imageData list!
                                ForEach(imageData, id: \.id) { item in
                                    if let data = item.data, let image = UIImage(data: data) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 200, height: 200)
                                            .aspectRatio(contentMode: .fit)
                                            .scaledToFit()
                                    } else {
                                        Text("Bad img url")
                                    }
                                }
                            }
                            .padding()
                        }.task {
                            do {
                                // First load all favorite items into "favorites" ClothingItem list
                                let closet = UserManager.shared.closetRef(userID: userInfo!.id!)
                                let query = closet.whereField("favorite", isEqualTo: true)
                                favorites = try await UserManager.shared.getClothingItems(userID: userInfo!.id!, query: query)
                                print("Number of favorites: \(favorites.count)")
                                
                                // Next load image data for each of these items per their img_urls
                                var imgData = [ImageData]()
                                for item in favorites {
                                    if uid != nil {
                                        if let data = try await StorageManager.shared.getImageDataFromPath(userID: uid!, path: item.img_url!) {
                                            print("Successfully loaded img data")
                                            imgData.append(ImageData(id: "\(UUID())", data: data))
                                        } else {
                                            print("Failed to load img data from clothing item in account view")
                                        }
                                    }
                                }
                                print("Number of retrieved img data: \(imgData.count)")
                                imageData = imgData
                            } catch {
                                favorites = []
                                imageData = []
                                print("Error loading data in account view: \(error)")
                            }
                        }
                    } else {
                        Text("No userid found")
                    }
                } else {
                    Text("Error loading userInfo")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
