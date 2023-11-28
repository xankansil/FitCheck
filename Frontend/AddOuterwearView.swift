
import SwiftUI

struct AddOuterwearView: View {

    var body: some View {
        Text("Add Outerwear")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: CameraView()){
                    Text("Jackets")
                }
                NavigationLink(destination: CameraView()){
                    Text("Coats")
                }
                NavigationLink(destination: CameraView()){
                    Text("Vests")
                }
            }
        }
    }
}


#Preview {
    AddOuterwearView()
}

