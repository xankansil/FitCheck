

import SwiftUI

struct AddFullBodyView: View {

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
        }
    }
}


#Preview {
    AddFullBodyView()
}
