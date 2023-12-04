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
                    
                    // Currently I am trying to submit the info at this point because if it can get here then extending the
                    // variable and the submission point to the picture view should not be difficult, but I currently do no feel like
                    // fidgiting with/figuring out how to also include a photo in the submission to the database
                    
                    // Where to collect the users Id? Seems like UserInfo is not the struct to use since it neither has the actual Id
                    // and it still seems to have issues seeing it in this scope cuz Swift sucks
                    let newItem = try await addClothingItem(userID: userInfo?.id,
                                                            
                            // These two (I believe) are how this submission would be structured, but it seems to have difficulty finding the funciton.
                            // It will probably have issues seeing the variable at this point too, so that will be something to address if the function
                            // issue gets fixed first
                            color: newClothingItem.closetObject.color,
                            category: newClothingItem.closetObject.category,
                                                            
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
