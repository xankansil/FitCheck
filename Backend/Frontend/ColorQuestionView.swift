//
//  ColorQuestionView.swift
//  FitCheck
//
//  Created by Xantia Kansil on 12/3/23.
//


import SwiftUI

struct ColorQuestionView: View {
    
    @EnvironmentObject var newClothingItem : ClothingObject
    
    @State private var redButton = false
    @State private var orangeButton = false
    @State private var yellowButton = false
    @State private var greenButton = false
    @State private var blueButton = false
    @State private var purpleButton = false
    @State private var pinkButton = false
    @State private var whiteButton = false
    @State private var blackButton = false
    @State private var brownButton = false
    @State private var multicolorButton = false


    var body: some View {
        Text("Choose the Color:")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                
                Button("Red"){
                    redButton.toggle()
                }
                if redButton{
                    NavigationLink(destination: CameraView()){
                        Text("Red")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.red
                        print("HELLO red")
                    }
                }
                
                Button("Orange"){
                    orangeButton.toggle()
                }
                if orangeButton{
                    NavigationLink(destination: CameraView()){
                        Text("Orange")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.orange
                        print("HELLO orange")
                    }
                }
                
                Button("Yellow"){
                    yellowButton.toggle()
                }
                if yellowButton{
                    NavigationLink(destination: CameraView()){
                        Text("Yellow")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.yellow
                        print("HELLO yellow")
                    }
                }
                
                Button("Green"){
                    greenButton.toggle()
                }
                if greenButton{
                    NavigationLink(destination: CameraView()){
                        Text("Green")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.green
                        print("HELLO green")
                    }
                }
                
                Button("Blue"){
                    blueButton.toggle()
                }
                if blueButton{
                    NavigationLink(destination: CameraView()){
                        Text("Blue")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.blue
                        print("HELLO blue")
                    }
                }
                
                Button("Purple"){
                    purpleButton.toggle()
                }
                if purpleButton{
                    NavigationLink(destination: CameraView()){
                        Text("Purple")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.purple
                        print("HELLO purple")
                    }
                }
                
                Button("Pink"){
                    pinkButton.toggle()
                }
                if pinkButton{
                    NavigationLink(destination: CameraView()){
                        Text("Pink")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.pink
                        print("HELLO pink")
                    }
                }
                
                Button("Black"){
                    blackButton.toggle()
                }
                if blackButton{
                    NavigationLink(destination: CameraView()){
                        Text("Black")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.black
                        print("HELLO black")
                    }
                }
                
                Button("White"){
                    whiteButton.toggle()
                }
                if whiteButton{
                    NavigationLink(destination: CameraView()){
                        Text("White")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.white
                        print("HELLO white")
                    }
                }
                
                Button("Brown"){
                    brownButton.toggle()
                }
                if brownButton{
                    NavigationLink(destination: CameraView()){
                        Text("Brown")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.brown
                        print("HELLO brown")
                    }
                }
                
                Button("Multi Color"){
                    multicolorButton.toggle()
                }
                if multicolorButton{
                    NavigationLink(destination: CameraView()){
                        Text("Multi Color")
                    }.task {
                        newClothingItem.closetObject.color = ColorType.multicolor
                        print("HELLO multi")
                    }
                }
                
                
                
                
//                NavigationLink(destination: CameraView()){
//                    Text("Red")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("Orange")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("Yellow")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("Green")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("Blue")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("Purple")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("Pink")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("Brown")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("Black")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("White")
//                }
//                NavigationLink(destination: CameraView()){
//                    Text("Multi Color")
//                }
                
               
            }
        }
    }
}


#Preview {
    ColorQuestionView()
}

