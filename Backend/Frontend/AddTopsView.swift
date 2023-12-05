//
//  AddTopsView.swift
//  AddClothingApp
//
//


import SwiftUI

struct AddTopView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    @State private var tops = [ClothingItem]()
    
    @State private var tankTopsButton = false
    @State private var shortSleeveButton = false
    @State private var longSleeveButton = false
    @State private var sweatersButton = false
    @State private var cardiganButton = false


    
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
        
        NavigationStack{
            VStack(spacing: 20) {
                
                Button("Tank Tops"){
                    tankTopsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if tankTopsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.tanktop
                        print("HELLO tanktop")
                    }
                }
                
                Button("Short Sleeve"){
                    shortSleeveButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if shortSleeveButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.shortsleeve
                        print("HELLO shortsleeve")
                    }
                }
                
                Button("Long Sleeve"){
                    longSleeveButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if longSleeveButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.longsleeve
                        print("HELLO longsleeve")
                    }
                }
                
                Button("Sweaters"){
                    sweatersButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if sweatersButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.sweater
                        print("HELLO sweater")
                    }
                }
                
                Button("Cardigans"){
                    cardiganButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if cardiganButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.cardigan
                        print("HELLO cardigan")
                    }
                }
                
                
                
                
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Tank Tops")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Short Sleeve")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Long Sleeves")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Sweaters")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Cardigans")
//                }
            }.navigationTitle("Add Tops")
        }.task {
            newClothingItem.closetObject.category = CategoryType.top
        }
    }
}


#Preview {
    AddTopView()
}

