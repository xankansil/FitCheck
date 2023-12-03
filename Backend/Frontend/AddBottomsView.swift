

import SwiftUI

struct AddBottomsView: View {
    @EnvironmentObject var newClothingItem : ClothingObject


    var body: some View {
        Text("Add Bottoms")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Pants")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Shorts")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Short Skirts")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Long Skirts")
                }
            }
        }.task {
            newClothingItem.closetObject.category = CategoryType.fullbody
        }
    }
}


#Preview {
    AddBottomsView()
}

