//
//  MainView.swift
//  FitCheck
//  Users/adaliawilliams/Desktop/WebDev/finalProj/mywork/Closet/Closet/Views//
//  Created by Corinna Plefka on 11/5/23.
//

import SwiftUI

struct MainView: View {
    //closet being created in mainview as this called all naviagtion views
    //this envirnmental object is being initiallized in Clothing Object, this variable is an array with the name closet
   // @EnvironmentObject var closet: ClothingObject
    var body: some View {
        @State private var selection = 2
        TabView(selection:$selection) {
            FeedView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }.tag(1)

            // consider newClothingwhatever: ClothingObject()
            AddClothingView().environmentObject(ClothingObject())
                .tabItem {
                    Label("Add \nClothing", systemImage: "tshirt.fill")
                }.tag(2)
            
            CreateOutfitView()
                .tabItem {
                    Label("Create \nan Outfit", systemImage: "plus.circle.fill")
                }.tag(3)
                
            ClosetView()
                .tabItem {
                    Label("Closet", systemImage: "list.dash")
                }.tag(4)
            
            AccountView()
                .tabItem { 
                    Label("Profile", systemImage: "person.fill")
                }.tag(5)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
