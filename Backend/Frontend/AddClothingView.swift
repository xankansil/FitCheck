//
//  AddClothingView.swift
//
//This view will allow the user to take pictures and add clothing to the database/ their closet

import SwiftUI

struct AddClothingView: View {
    //@EnvironmentObject var newClothingItem : ClothingObject
    
    var body: some View {
        NavigationStack{
            VStack(
                spacing: 50
            ) {
                NavigationLink(destination: AddTopView()){
                    //newClothingItem.closetObject.category = CategoryType.top
                    Text("ADD TOPS")
                }
                NavigationLink(destination: AddBottomsView()){
                    Text("ADD BOTTOMS")
                }
                NavigationLink(destination: AddFullBodyView()){
                    Text("ADD FULL BODY")
                }
                NavigationLink(destination: AddOuterwearView()){
                    Text("ADD OUTERWEAR")
                }
                NavigationLink(destination: AddShoesView()){
                    Text("ADD SHOES")
                }
            }
            .navigationTitle("Add Clothing")
            
        }
    }
}

struct AddClothingView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothingView()
    }
}
