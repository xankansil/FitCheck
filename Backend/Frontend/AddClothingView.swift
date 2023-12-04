//
//  AddClothingView.swift
//
//This view will allow the user to take pictures and add clothing to the database/ their closet

import SwiftUI

struct AddClothingView: View {
//    @EnvironmentObject var newClothingItem : ClothingObject
    
    var body: some View {
        NavigationStack{
            VStack(
                spacing: 50
            ) {
                NavigationLink(destination: AddTopView()){
                    //newClothingItem.closetObject.category = CategoryType.top
                    Text("ADD TOPS")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))

                }
                NavigationLink(destination: AddBottomsView()){
                    Text("ADD BOTTOMS")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: AddFullBodyView()){
                    Text("ADD FULL BODY")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: AddOuterwearView()){
                    Text("ADD OUTERWEAR")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: AddShoesView()){
                    Text("ADD SHOES")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
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
