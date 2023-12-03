//
//  SeasonQuestion.swift
//  FitCheck
//
//  Created by Xantia Kansil on 12/3/23.
//


import SwiftUI

struct SeasonQuestionView: View {

    var body: some View {
        Text("Choose the Season:")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: OccasionQuestionView()){
                    Text("Fall")
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
        }
    }
}


#Preview {
    SeasonQuestionView()
}

