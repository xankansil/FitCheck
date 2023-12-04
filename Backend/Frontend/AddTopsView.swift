//
//  AddTopsView.swift
//  AddClothingApp
//
//


import SwiftUI

struct AddTopView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    @State private var tops = [ClothingItem]()

    
    var body: some View {
        // TODO: Testing, can remove
        //        // VERY important to check for nil with all optionals
        //        let userInfo = UserManager.shared.getLoadedData()
        //        if (userInfo != nil){
        //            if(userInfo!.id != nil) {
        //                Text("User id: \(userInfo!.id!)")
        //                // VStack uses the tops list, which is set in .task
        //                VStack {
        //                    ForEach(tops, id: \.id) { item in
        //                        if (item.img_url != nil){
        //                            Text("Image url: \(item.img_url!)")
        //                        } else {
        //                            Text("Image url not found")
        //                        }
        //                    }
        //                }
        //                // Task attemps to run the moment the view is loaded
        //                .task {
        //                    do {
        //                        // Querying the database for all tops
        //                        let closet = UserManager.shared.closetRef(userID: userInfo!.id!)
        //                        // Note that isEqualTo: "top" isn't using CategoryType.top; the database stores enums as a literal string
        //                        let query = closet.whereField("category", isEqualTo: "top")
        //                        tops = try await UserManager.shared.getClothingItems(userID: userInfo!.id!, query: query)
        //                    } catch {
        //                        tops = []
        //                        print("Error loading data in TopsView!")
        //                    }
        //                }
        //            }
        //        } else {
        //            Text("User info not found.")
        //        }
        Text("Add Tops")
            .font(.system(size: 50))
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Tank Tops")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Short Sleeve")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Long Sleeves")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Sweaters")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Cardigans")
                }
            }
        }.task {
            newClothingItem.closetObject.category = CategoryType.top
        }
    }
}


#Preview {
    AddTopView()
}

