//
//  ContentView.swift
//
//  Created by Xantia Kansil on 12/3/23.
//

import SwiftUI

struct FeedView: View {
   
    @State private var outfits = [Outfit]()
    var body: some View {
       
        let userInfo = UserManager.shared.getLoadedData()
        if (userInfo != nil){
            if(userInfo!.id != nil) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 40){
                        Text("My Favorite Outfits")
                            .font(.largeTitle)
                        ForEach(outfits, id:\.id) { item in
                            if (item.img_url != nil){
                                //Text(item.img_url!)
                                
                                Image(uiImage: UIImage(named: item.img_url!)!)
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                    .aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                
                                Text(item.label!)
                                    .multilineTextAlignment(.leading)
                                
                            } else{
                                Text("image url not found")
                            }
                        }
                    }
                    .padding()
                }.task {
                    do {
                        // let outfits = UserManager.shared.outfitRef(userID: userInfo!.id!)
                        
                        outfits = try await UserManager.shared.getAllOutfits(userID: userInfo!.id!)
                        
                    } catch {
                        outfits = []
                        print("error loading data in short sleeve view")
                    }
                }
            }
        }else {
            Text("user info not found")
        }
    }
}

#Preview {
    FeedView()
}
