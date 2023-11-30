

import SwiftUI

struct AddFullBodyView: View {

    var body: some View {
        Text("Add Full Body")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: CameraView()){
                    Text("Dresses")
                }
                NavigationLink(destination: CameraView()){
                    Text("Overalls")
                }
                NavigationLink(destination: CameraView()){
                    Text("Jumpsuits")
                }
            }
        }
    }
}


#Preview {
    AddFullBodyView()
}
