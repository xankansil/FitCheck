

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
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if sneakersButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.sneakers
                        print("HELLO sneakers")
                    }
                }
                
                Button("Boots"){
                    bootsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if bootsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.boots
                        print("HELLO boots")
                    }
                }
                
                Button("Dress Shoes"){
                    dressShoesButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if dressShoesButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.dressshoes
                        print("HELLO dress shoes")
                    }
                }
                
                
                Button("Sandals"){
                    sandalsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if sandalsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
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
