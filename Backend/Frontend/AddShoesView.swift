

import SwiftUI

struct AddShoesView: View {
    @EnvironmentObject var newClothingItem : ClothingObject


    var body: some View {
        Text("Add Shoes")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Sneakers")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Boots")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Dress Shoes")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Sandals")
                }
            }
        }.task {
            newClothingItem.closetObject.category = CategoryType.shoes
        }
    }
}


#Preview {
    AddShoesView()
}
