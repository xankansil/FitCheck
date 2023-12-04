//
//  SeasonQuestion.swift
//  FitCheck
//
//  Created by Xantia Kansil on 12/3/23.
//

import SwiftUI

struct SeasonQuestionView: View {
    // Re-declaring the variable allows me to access it within this view, but is it carrying along the same info as the declaration from the AddBlankViews?
    //@EnvironmentObject var newClothingItem : ClothingObject

    var body: some View {
        Text("Choose the Season:")
            .font(.system(size: 50))
            
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: OccasionQuestionView()){
                    Text("Fall")
                    
                    // Maybe it would work simply setting the value here?
                    // That way we can just set each value within its selection rather than some wonky other method down in the task?
                    
                    // Still not able to really verify since it still does not seem to be able to see the variable
                    
                    // This is weirdly throwing an error, so I was trying different variations of the line, but after coming back here
                    // it seems that this is the best bet at altering the item
                    //newClothingItem.closetObject.weather = WeatherType.fall
                    
                    // I came back here after some other testing and it seems no errors get thrown after one already is has been.
                    // I thought the below line was working for a while, but after commenting out the above line, this one threw an error too
                    // So keep that in mind, subsequent errors may not be caught in this section after one already has been
                    
                    // This actually throws more errors
                    newClothingItem.$closetObject.append(WeatherType) = WeatherType.fall
                }
                NavigationLink(destination: OccasionQuestionView()){
                    Text("Winter")
                }
                NavigationLink(destination: OccasionQuestionView()){
                    Text("Spring")
                }
                NavigationLink(destination: OccasionQuestionView()){
                    Text("Summer")
                }
               
            }
        }.task {
            // Doesnt work, and I know it doesnt really make sense to set it to
            // winter here, i was just trying to see if it would function in the same location as the previous views
            
            // This line gets fixed after re-declaring the global variable at the top of this file
            newClothingItem.closetObject.weather = WeatherType.winter
        }
    }
}


#Preview {
    SeasonQuestionView()
}
