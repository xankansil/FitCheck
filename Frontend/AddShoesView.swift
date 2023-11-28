

import SwiftUI

struct AddShoesView: View {

    var body: some View {
        Text("Add Shoes")
            .font(.system(size: 50))
            
        
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: CameraView()){
                    Text("Sneakers")
                }
                NavigationLink(destination: CameraView()){
                    Text("Boots")
                }
                NavigationLink(destination: CameraView()){
                    Text("Dress Shoes")
                }
                NavigationLink(destination: CameraView()){
                    Text("Sandals")
                }
            }
        }
    }
}


#Preview {
    AddShoesView()
}
