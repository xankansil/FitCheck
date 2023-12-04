//
//  LongSkirtsView.swift
//  Closet
//
//  Created by Adalia Williams on 11/27/23.
//

import SwiftUI

struct LongSkirtsView: View {
    
    @State private var longskirts = [ClothingItem]()
    
    var body: some View {
        Text("Long Skirts")
            .font(.system(size: 30))
            .foregroundStyle(.indigo)
            .border(Color.white)
        let userInfo = UserManager.shared.getLoadedData()
        if (userInfo != nil){
            if(userInfo!.id != nil) {
                Text("User id: \(userInfo!.id!)")
                ScrollView{
                    //working with assests must work with link
                    VStack(alignment: .leading, spacing: 20){
                        
                        // Image(uiImage: UIImage(named: "shirt1")!)
                        // .scaledToFit()
                        ForEach(longskirts, id:\.id) { item in
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
                        let query = closet.whereField("clothing", isEqualTo: "longskirt")
                        longskirts = try await UserManager.shared.getClothingItems(userID: userInfo!.id!, query: query)
                    } catch {
                        longskirts = []
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
    LongSkirtsView()
}
