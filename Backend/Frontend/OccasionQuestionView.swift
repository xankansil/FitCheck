//
//  OccasionQuestionView.swift
//  FitCheck
//
//  Created by Xantia Kansil on 12/3/23.
//


import SwiftUI

struct OccasionQuestionView: View {

    var body: some View {
        Text("Choose the Occasion:")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: ColorQuestionView()){
                    Text("Casual")
                }
                NavigationLink(destination: ColorQuestionView()){
                    Text("Fancy")
                }
                NavigationLink(destination: ColorQuestionView()){
                    Text("Loungewear")
                }
                NavigationLink(destination: ColorQuestionView()){
                    Text("Holiday")
                }
                NavigationLink(destination: ColorQuestionView()){
                    Text("Party")
                }
               
            }
        }
    }
}


#Preview {
    OccasionQuestionView()
}

