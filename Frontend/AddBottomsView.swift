

import SwiftUI

struct AddBottomsView: View {

    var body: some View {
        Text("Add Bottoms")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: CameraView()){
                    Text("Pants")
                }
                NavigationLink(destination: CameraView()){
                    Text("Shorts")
                }
                NavigationLink(destination: CameraView()){
                    Text("Short Skirts")
                }
                NavigationLink(destination: CameraView()){
                    Text("Long Skirts")
                }
            }
        }
    }
}


#Preview {
    AddBottomsView()
}

