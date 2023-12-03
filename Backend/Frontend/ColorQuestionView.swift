//
//  ColorQuestionView.swift
//  FitCheck
//
//  Created by Xantia Kansil on 12/3/23.
//


import SwiftUI

struct ColorQuestionView: View {

    var body: some View {
        Text("Choose the Color:")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: CameraView()){
                    Text("Red")
                }
                NavigationLink(destination: CameraView()){
                    Text("Orange")
                }
                NavigationLink(destination: CameraView()){
                    Text("Yellow")
                }
                NavigationLink(destination: CameraView()){
                    Text("Green")
                }
                NavigationLink(destination: CameraView()){
                    Text("Blue")
                }
                NavigationLink(destination: CameraView()){
                    Text("Purple")
                }
                NavigationLink(destination: CameraView()){
                    Text("Pink")
                }
                NavigationLink(destination: CameraView()){
                    Text("Brown")
                }
                NavigationLink(destination: CameraView()){
                    Text("Black")
                }
                NavigationLink(destination: CameraView()){
                    Text("White")
                }
                NavigationLink(destination: CameraView()){
                    Text("Multi Color")
                }
                
               
            }
        }
    }
}


#Preview {
    ColorQuestionView()
}

