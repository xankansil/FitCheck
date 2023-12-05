

import SwiftUI

struct AddFullBodyView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    @State private var dressesButton = false
    @State private var overallsButton = false
    @State private var jumpsuitsButton = false


    var body: some View {
        
        
        NavigationStack{
            VStack(spacing: 20) {
                
                Button("Dresses"){
                    dressesButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if dressesButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.dress
                        print("HELLO dress")
                    }
                }
                
                Button("Overalls"){
                    overallsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if overallsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.overalls
                        print("HELLO overalls")
                    }
                }
                
                Button("Jumpsuits"){
                    jumpsuitsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if jumpsuitsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.jumpsuit
                        print("HELLO jumpsuit")
                    }
                }
                
            }.navigationTitle("Add Full Body")
        }.task {
            newClothingItem.closetObject.category = CategoryType.fullbody
        }
    }
}


#Preview {
    AddFullBodyView()
}
