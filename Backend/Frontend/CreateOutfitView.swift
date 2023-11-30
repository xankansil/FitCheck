//
//  CreateOutfitView.swift
//  backend
//
//  Created by Corinna Plefka on 11/5/23.
//
//This view will allow the user to create an outfit from the clothing in their closet

import SwiftUI

//TODO: need method for updating picture of chosen clothing item
//TODO: create variables to represent the chosen clothing items

import SwiftUI

struct CreateOutfitView: View {
    var body: some View {
        VStack{
            Text("Create an Outfit")
                .bold()
                .font(.title)
            
            HStack { //HStack that contains Vstack of pictures of chosen clothes and NavStack list to choose more clothing items
                VStack{ //Clothing pictures
                    //Image for hat choice
                    Image("hat")
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                    //Image for torso choice
                    Image("sweater")
                        .resizable()
                        .frame(width: 180.0, height: 180.0)
                    //Image for pant choice
                    Image("pants")
                        .resizable()
                        .frame(width: 200.0, height: 200.0)
                    //Image for shoe choice
                    Image("dress_shoes")
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                    
                    
                }
                
                NavigationStack{
                    VStack(
                        spacing: 50
                    ) {
                        NavigationLink(destination: TopsView()){
                            Text("TOPS")
                        }
                        NavigationLink(destination: BottomsView()){
                            Text("BOTTOMS")
                        }
                        NavigationLink(destination: FullBodyView()){
                            Text("FULL BODY")
                        }
                        NavigationLink(destination: OuterWearView()){
                            Text("OUTERWEAR")
                        }
                        NavigationLink(destination: ShoesView()){
                            Text("SHOES")
                        }
                    }
                }
                
            }
        }
    }
}

struct CreateOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

