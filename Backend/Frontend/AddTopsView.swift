//
//  AddTopsView.swift
//  AddClothingApp
//
//


import SwiftUI

struct AddTopView: View {

    var body: some View {
        Text("Add Tops")
            .font(.system(size: 50))
            
        
        NavigationStack{
            VStack(spacing: 20) {
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Tank Tops")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Short Sleeve")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Long Sleeves")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Sweaters")
                }
                NavigationLink(destination: SeasonQuestionView()){
                    Text("Cardigans")
                }
            }
        }
    }
}


#Preview {
    AddTopView()
}

