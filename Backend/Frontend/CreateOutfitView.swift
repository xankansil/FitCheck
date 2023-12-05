//
//  CreateOutfitView.swift
//  backend
//
//  Created by Corinna Plefka on 11/5/23.
//
//This view will allow the user to create an outfit from the clothing in their closet

import SwiftUI

//TODO: need method for updating picture of chosen clothing item
//TODO: create variables to represent the chosen clothing items
struct CreateOutfitView: View {
    // @State private var accessory = [ClothingItem]()
    @State private var tops = [ClothingItem]()
    @State private var bottoms = [ClothingItem]()
    @State private var shoes = [ClothingItem]()
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 40){
                Text("Create an Outfit")
                    .bold()
                    .font(.title)
                let userInfo = UserManager.shared.getLoadedData()
                if (userInfo != nil){
                    if(userInfo!.id != nil) {
                        Text("User id: \(userInfo!.id!)")
                        VStack(alignment: .leading, spacing: 20){
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(tops, id:\.id) { item1 in
                                        if (item1.img_url != nil){
                                            //Text(item1.img_url!)
                                            //let item1Url = "Views/assets/" + item1.img_url!
                                            
                                             Image(uiImage: UIImage(named: item1.img_url!)!)
                                             .resizable()
                                             .scaledToFit()
                                             .frame(width: 200, height: 200)
                                             
                                            
                                        } else{
                                            Text("image url not found")
                                        }
                                    }
                                }
                            }
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(bottoms, id:\.id) { item2 in
                                        if (item2.img_url != nil){
                                           // Text(item2.img_url!)
                                            //let item1Url = "Views/assets/" + item1.img_url!
                                            
                                             Image(uiImage: UIImage(named: item2.img_url!)!)
                                             .resizable()
                                             .scaledToFit()
                                             .frame(width: 200, height: 200)
                                             
                                            
                                        } else{
                                            Text("image url not found")
                                        }
                                    }
                                }
                            }
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(shoes, id:\.id) { item3 in
                                        if (item3.img_url != nil){
                                            //Text(item3.img_url!)
                                            //let item1Url = "Views/assets/" + item1.img_url!
                                            
                                             Image(uiImage: UIImage(named: item3.img_url!)!)
                                             .resizable()
                                             .scaledToFit()
                                             .frame(width: 200, height: 200)
                                            
                                            
                                        } else{
                                            Text("image url not found")
                                        }
                                    }
                                }
                            }
                        }.task {
                            do {
                                let closet = UserManager.shared.closetRef(userID: userInfo!.id!)
                                // Note that isEqualTo: "top" isn't using CategoryType.top; the database stores enums as a literal string
                                let queryTops = closet.whereField("category", isEqualTo: "top")
                                tops = try await UserManager.shared.getClothingItems(userID: userInfo!.id!, query: queryTops)
                                
                                let queryBottoms = closet.whereField("category", isEqualTo: "bottom")
                                bottoms = try await UserManager.shared.getClothingItems(userID: userInfo!.id!, query: queryBottoms)
                                
                                let queryShoes = closet.whereField("category", isEqualTo: "shoes")
                                shoes = try await UserManager.shared.getClothingItems(userID: userInfo!.id!, query: queryShoes)
                            } catch {
                                tops = []
                                bottoms = []
                                shoes = []
                                print("error loading data in short sleeve view")
                            }
                        }
                    }
                }else {
                    Text("user info not found")
                }
            }
            NavigationStack{
                VStack(
                spacing: 50
                ) {
                NavigationLink(destination: TopsView()){
                Text("TOPS")
                }
                NavigationLink(destination: BottomsView()){
                Text("BOTTOMS")
                }
                NavigationLink(destination: FullBodyView()){
                Text("FULL BODY")
                }
                NavigationLink(destination: OuterWearView()){
                Text("OUTERWEAR")
                }
                NavigationLink(destination: ShoesView()){
                Text("SHOES")
                }
                }
            }
        }
    }
}


struct CreateOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
