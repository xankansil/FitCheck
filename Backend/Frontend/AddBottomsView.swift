

import SwiftUI

struct AddBottomsView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    @State private var pantsButton = false
    @State private var jeansButton = false
    @State private var shortsButton = false
    @State private var shortSkirtsButton = false
    @State private var longSkirtsButton = false


    var body: some View {
            
        
        NavigationStack{
            VStack(spacing: 20) {
                
                
                Button("Pants"){
                    pantsButton.toggle()
                }
                if pantsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Pants")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.pants
                        print("HELLO pants")
                    }
                }
                
                Button("Jeans"){
                    jeansButton.toggle()
                }
                if jeansButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Jeans")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.jeans
                        print("HELLO jeans")
                    }
                }
                
                Button("Shorts"){
                    shortsButton.toggle()
                }
                if shortsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Shorts")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.shorts
                        print("HELLO shorts")
                    }
                }
                
                Button("Short Skirts"){
                    shortSkirtsButton.toggle()
                }
                if shortSkirtsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Short Skirts")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.shortskirt
                        print("HELLO short skirts")
                    }
                }
                
                Button("Long Skirts"){
                    longSkirtsButton.toggle()
                }
                if longSkirtsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Long Skirts")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.longskirt
                        print("HELLO long skirts")
                    }
                }
                
                
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Pants")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Jeans")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Shorts")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Short Skirts")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Long Skirts")
//                }
            }.navigationTitle("Add Bottoms")
        }.task {
            newClothingItem.closetObject.category = CategoryType.bottom
            print("hi")
            
        }
    }
}


#Preview {
    AddBottomsView()
}

