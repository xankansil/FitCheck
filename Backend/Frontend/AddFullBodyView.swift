

import SwiftUI

struct AddFullBodyView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    @State private var dressesButton = false
    @State private var overallsButton = false
    @State private var jumpsuitsButton = false


    var body: some View {
        Text("Add Full Body")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                
                Button("Dresses"){
                    dressesButton.toggle()
                }
                if dressesButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Dresses")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.dress
                        print("HELLO dress")
                    }
                }
                
                Button("Overalls"){
                    overallsButton.toggle()
                }
                if overallsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Overalls")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.overalls
                        print("HELLO overalls")
                    }
                }
                
                Button("Jumpsuits"){
                    jumpsuitsButton.toggle()
                }
                if jumpsuitsButton{
                    NavigationLink(destination: SeasonQuestionView()){
                        Text("Jumpsuits")
                    }.task {
                        newClothingItem.closetObject.clothing = ClothingType.jumpsuit
                        print("HELLO jumpsuit")
                    }
                }
                
                
                
                
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Dresses")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Overalls")
//                }
//                NavigationLink(destination: SeasonQuestionView()){
//                    Text("Jumpsuits")
//                }
            }
        }.task {
            newClothingItem.closetObject.category = CategoryType.fullbody
        }
    }
}


#Preview {
    AddFullBodyView()
}
