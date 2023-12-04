

import SwiftUI

struct AddShoesView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    @State private var sneakersButton = false
    @State private var bootsButton = false
    @State private var dressShoesButton = false
    @State private var sandalsButton = false


    var body: some View {
            
        
        NavigationStack{
            VStack(spacing: 20) {
                
                Button("Sneakers"){
                    sneakersButton.toggle()
                }
                if sneakersButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Sneakers")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.sneakers
                        print("HELLO sneakers")
                    }
                }
                
                Button("Boots"){
                    bootsButton.toggle()
                }
                if bootsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Boots")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.boots
                        print("HELLO boots")
                    }
                }
                
                Button("Dress Shoes"){
                    dressShoesButton.toggle()
                }
                if dressShoesButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Dress Shoes")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.dressshoes
                        print("HELLO dress shoes")
                    }
                }
                
                
                Button("Sandals"){
                    sandalsButton.toggle()
                }
                if sandalsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Sandals")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.sandals
                        print("HELLO sandals")
                    }
                }
                
                
                
                
                
//                
//                
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Sneakers")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Boots")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Dress Shoes")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Sandals")
//                }
            }.navigationTitle("Add Shoes")
        }.task {
            newClothingItem.closetObject.category = CategoryType.shoes
        }
    }
}


#Preview {
    AddShoesView()
}
