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
            .font(.system(size: 30))
            .fontWeight(.bold)
        

            
        
        NavigationStack{
            VStack(spacing: 20) {
                
                HStack(spacing: 20){
                    Button("Red"){
                        redButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if redButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.red
                            print("HELLO red")
                        }
                    }
                    
                    Button("Orange"){
                        orangeButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if orangeButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.orange
                            print("HELLO orange")
                        }
                    }
                    
                    Button("Yellow"){
                        yellowButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if yellowButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.yellow
                            print("HELLO yellow")
                        }
                    }
                    
                }
                
                HStack(spacing: 20){
                    Button("Green"){
                        greenButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if greenButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.green
                            print("HELLO green")
                        }
                    }
                    
                    Button("Blue"){
                        blueButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if blueButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.blue
                            print("HELLO blue")
                        }
                    }
                    
                    Button("Purple"){
                        purpleButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if purpleButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.purple
                            print("HELLO purple")
                        }
                    }
                    
                }
                
                HStack(spacing: 20){
                    Button("Pink"){
                        pinkButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if pinkButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.pink
                            print("HELLO pink")
                        }
                    }
                    
                    Button("Black"){
                        blackButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if blackButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.black
                            print("HELLO black")
                        }
                    }
                    
                    Button("White"){
                        whiteButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if whiteButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.white
                            print("HELLO white")
                        }
                    }
                }

                
                HStack(spacing: 20){
                    Button("Brown"){
                        brownButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if brownButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.brown
                            print("HELLO brown")
                        }
                    }
                    
                    Button("Multi Color"){
                        multicolorButton.toggle()
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if multicolorButton{
                        NavigationLink(destination: PhotoPicker()){
                            Image(systemName: "arrow.forward.square")
                                .font(.system(size: 30, weight: .bold))
                        }.task {
                            newClothingItem.closetObject.color = ColorType.multicolor
                            print("HELLO multi")
                        }
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

