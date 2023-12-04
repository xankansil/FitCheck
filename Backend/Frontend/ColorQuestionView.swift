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
                    
                    
                    // TODO: have the basic previous info loaded into a funciton to upload to the db
                    // Having troubles accessing the function from user manager
                    // Also, not sure if the global variable will actually carry over the info
                    
                    
                    let newItem = try await AddTopView(newClothingItem: <#T##EnvironmentObject<ClothingObject>#>)
                    
                    let newItem = try await addClothingItem(userID: userID,
                            color: ColorType.green,
                            category: CategoryType.bottom,
                            clothing: ClothingType.shorts,
                            occasion: OccasionType.holiday,
                            weather: WeatherType.winter,
                            dateAdded: Date(),
                            mostRecWear: Date(),
                            timesWorn: 10)
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
