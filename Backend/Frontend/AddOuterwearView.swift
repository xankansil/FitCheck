
import SwiftUI

struct AddOuterwearView: View {
    @EnvironmentObject var newClothingItem : ClothingObject

    var body: some View {
        Text("Add Outerwear")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Jackets")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Coats")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Vests")
                }
            }
        }.task {
            newClothingItem.closetObject.category = CategoryType.outerwear
        }
    }
}


#Preview {
    AddOuterwearView()
}

