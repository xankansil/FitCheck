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
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                
                if pantsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.pants
                        print("HELLO pants")
                    }
                }
                
                Button("Jeans"){
                    jeansButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if jeansButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.jeans
                        print("HELLO jeans")
                    }
                }
                
                Button("Shorts"){
                    shortsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if shortsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.shorts
                        print("HELLO shorts")
                    }
                }
                
                Button("Short Skirts"){
                    shortSkirtsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if shortSkirtsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.shortskirt
                        print("HELLO short skirts")
                    }
                }
                
                Button("Long Skirts"){
                    longSkirtsButton.toggle()
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                if longSkirtsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30, weight: .bold))
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.longskirt
                        print("HELLO long skirts")
                    }
                }
                
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
