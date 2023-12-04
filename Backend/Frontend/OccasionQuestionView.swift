//
//  OccasionQuestionView.swift
//  FitCheck
//
//  Created by Xantia Kansil on 12/3/23.
//


import SwiftUI

struct OccasionQuestionView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    
    @State private var casualButton = false
    @State private var fancyButton = false
    @State private var loungewearButton = false
    @State private var holidayButton = false
    @State private var partyButton = false



    var body: some View {
        Text("Choose the Occasion:")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                
                Button("Casual"){
                    casualButton.toggle()
                }
                if casualButton{
                    NavigationLink(destination: ColorQuestionView()){
                        Text("Casual")
                    }.task {
                        newClothingItem.closetObject.occasion = OccasionType.casual
                        print("HELLO casual")
                    }
                }
                
                Button("Fancy"){
                    fancyButton.toggle()
                }
                if fancyButton{
                    NavigationLink(destination: ColorQuestionView()){
                        Text("Fancy")
                    }.task {
                        newClothingItem.closetObject.occasion = OccasionType.fancy
                        print("HELLO fancy")
                    }
                }
                
                Button("Loungewear"){
                    loungewearButton.toggle()
                }
                if loungewearButton{
                    NavigationLink(destination: ColorQuestionView()){
                        Text("Loungewear")
                    }.task {
                        newClothingItem.closetObject.occasion = OccasionType.loungewear
                        print("HELLO loungewear")
                    }
                }
                
                Button("Holiday"){
                    holidayButton.toggle()
                }
                if holidayButton{
                    NavigationLink(destination: ColorQuestionView()){
                        Text("Holiday")
                    }.task {
                        newClothingItem.closetObject.occasion = OccasionType.holiday
                        print("HELLO holiday")
                    }
                }
                
                Button("Party"){
                    partyButton.toggle()
                }
                if partyButton{
                    NavigationLink(destination: ColorQuestionView()){
                        Text("Party")
                    }.task {
                        newClothingItem.closetObject.occasion = OccasionType.party
                        print("HELLO party")
                    }
                }
                
                
//                NavigationLink(destination: ColorQuestionView()){
//                    Text("Casual")
//                }
//                NavigationLink(destination: ColorQuestionView()){
//                    Text("Fancy")
//                }
//                NavigationLink(destination: ColorQuestionView()){
//                    Text("Loungewear")
//                }
//                NavigationLink(destination: ColorQuestionView()){
//                    Text("Holiday")
//                }
//                NavigationLink(destination: ColorQuestionView()){
//                    Text("Party")
//                }
               
            }
        }
    }
}


#Preview {
    OccasionQuestionView()
}

