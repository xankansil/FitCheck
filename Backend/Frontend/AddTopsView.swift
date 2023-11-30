//
//  AddTopsView.swift
//  AddClothingApp
//
//


import SwiftUI

struct AddTopView: View {

    var body: some View {
        Text("Add Tops")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: CameraView()){
                    Text("Tank Tops")
                }
                NavigationLink(destination: CameraView()){
                    Text("Short Sleeve")
                }
                NavigationLink(destination: CameraView()){
                    Text("Long Sleeves")
                }
                NavigationLink(destination: CameraView()){
                    Text("Sweaters")
                }
                NavigationLink(destination: CameraView()){
                    Text("Cardigans")
                }
            }
        }
    }
}


#Preview {
    AddTopView()
}

