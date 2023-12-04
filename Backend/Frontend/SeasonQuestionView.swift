//
//  SeasonQuestion.swift
//  FitCheck
//
//  Created by Xantia Kansil on 12/3/23.
//


import SwiftUI

struct SeasonQuestionView: View {
    
    @EnvironmentObject var newClothingItem : ClothingObject
    
    @State private var fallButton = false
    @State private var winterButton = false
    @State private var springButton = false
    @State private var summerButton = false


    var body: some View {
        Text("Choose the Season:")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                
                Button("Fall"){
                    fallButton.toggle()
                }
                if fallButton{
                    NavigationLink(destination: OccasionQuestionView()){
                        Text("Fall")
                    }.task {
                        newClothingItem.closetObject.weather = WeatherType.fall
                        print("HELLO fall")
                    }
                }
                
                Button("Winter"){
                    winterButton.toggle()
                }
                if winterButton{
                    NavigationLink(destination: OccasionQuestionView()){
                        Text("Winter")
                    }.task {
                        newClothingItem.closetObject.weather = WeatherType.winter
                        print("HELLO winter")
                    }
                }
                
                Button("Spring"){
                    springButton.toggle()
                }
                if springButton{
                    NavigationLink(destination: OccasionQuestionView()){
                        Text("Spring")
                    }.task {
                        newClothingItem.closetObject.weather = WeatherType.spring
                        print("HELLO spring")
                    }
                }
                
                Button("Summer"){
                    summerButton.toggle()
                }
                if summerButton{
                    NavigationLink(destination: OccasionQuestionView()){
                        Text("Summer")
                    }.task {
                        newClothingItem.closetObject.weather = WeatherType.summer
                        print("HELLO fall")
                    }
                }
                
                
                
//                NavigationLink(destination: OccasionQuestionView()){
//                    Text("Fall")
//                }
//                NavigationLink(destination: OccasionQuestionView()){
//                    Text("Winter")
//                }
//                NavigationLink(destination: OccasionQuestionView()){
//                    Text("Spring")
//                }
//                NavigationLink(destination: OccasionQuestionView()){
//                    Text("Summer")
//                }
               
            }
        }
    }
}


#Preview {
    SeasonQuestionView()
}

