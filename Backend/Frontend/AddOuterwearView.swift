
import SwiftUI

struct AddOuterwearView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    @State private var jacketsButton = false
    @State private var coatsButton = false
    @State private var vestsButton = false
    

    var body: some View {
        Text("Add Outerwear")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                
                Button("Jackets"){
                    jacketsButton.toggle()
                }
                if jacketsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Jackets")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.jacket
                        print("HELLO jackets")
                    }
                }
                
                Button("Coats"){
                    coatsButton.toggle()
                }
                if coatsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Coats")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.coat
                        print("HELLO coats")
                    }
                }
                
                Button("Vests"){
                    vestsButton.toggle()
                }
                if vestsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Vests")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.vests
                        print("HELLO vests")
                    }
                }
                
                
                
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Jackets")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Coats")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Vests")
//                }
            }
        }.task {
            newClothingItem.closetObject.category = CategoryType.outerwear
        }
    }
}


#Preview {
    AddOuterwearView()
}

