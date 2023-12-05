
import SwiftUI

struct AddOuterwearView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    @State private var jacketsButton = false
    @State private var coatsButton = false
    @State private var vestsButton = false
    

    var body: some View {
            
        
        NavigationStack{
            VStack(spacing: 20) {
                
                Button("Jackets"){
                    jacketsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if jacketsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.jacket
                        print("HELLO jackets")
                    }
                }
                
                Button("Coats"){
                    coatsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if coatsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.coat
                        print("HELLO coats")
                    }
                }
                
                Button("Vests"){
                    vestsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if vestsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.vests
                        print("HELLO vests")
                    }
                }
                
            }.navigationTitle("Add Outerwear")
        }.task {
            newClothingItem.closetObject.category = CategoryType.outerwear
        }
    }
}


#Preview {
    AddOuterwearView()
}

