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
                                if let uiimg = UIImage(named: item.img_url!){
                                    Image(uiImage: uiimg)
                                        .resizable()
                                        .frame(width: 200, height: 200)
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                }
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
                }.navigationTitle("My Long Skirts")
            }
        } else {
            Text("user info not found")
        }
    }
}

#Preview {
    LongSkirtsView()
}
