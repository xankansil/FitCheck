

import SwiftUI

struct AddFullBodyView: View {
    @EnvironmentObject var newClothingItem : ClothingObject


    var body: some View {
        Text("Add Full Body")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Dresses")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Overalls")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Jumpsuits")
                }
            }
        }.task {
            newClothingItem.closetObject.category = CategoryType.fullbody
        }
    }
}


#Preview {
    AddFullBodyView()
}
