//
//  VestsView.swift
//  Closet
//
//  Created by Adalia Williams on 11/27/23.

import SwiftUI

struct VestsView: View {
    
    @State private var vests = [ClothingItem]()
    
    var body: some View {
        Text("Vests")
            .font(.system(size: 30))
            .foregroundStyle(.indigo)
            .border(Color.white)
        let userInfo = UserManager.shared.getLoadedData()
        if (userInfo != nil){
            if(userInfo!.id != nil) {
                Text("User id: \(userInfo!.id!)")
                ScrollView{
                    //working with assests must work with link
                    VStack(alignment: .leading, spacing: 30){
                        
                        // Image(uiImage: UIImage(named: "shirt1")!)
                        // .scaledToFit()
                        ForEach(vests, id:\.id) { item in
                            if (item.img_url != nil){
                                Image(uiImage: UIImage(named: item.img_url!)!)
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            } else{
                                Text("image url not found")
                            }
                        }
                    }
                    .padding()
                }.task {
                    do {
                        let closet = UserManager.shared.closetRef(userID: userInfo!.id!)
                        // Note that isEqualTo: "top" isn't using CategoryType.top; the database stores enums as a literal string
                        let query = closet.whereField("clothing", isEqualTo: "vests")
                        vests = try await UserManager.shared.getClothingItems(userID: userInfo!.id!, query: query)
                    } catch {
                        vests = []
                        print("error loading data in short sleeve view")
                    }
                }
            }
        } else {
            Text("user info not found")
        }
    }
}

#Preview {
    VestsView()
}
