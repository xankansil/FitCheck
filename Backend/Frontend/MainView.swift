//
//  MainView.swift
//  FitCheck
//  Users/adaliawilliams/Desktop/WebDev/finalProj/mywork/Closet/Closet/Views//
//  Created by Corinna Plefka on 11/5/23.
//

import SwiftUI

struct MainView: View {
    //closet being created in mainview as this called all naviagtion views
    @EnvironmentObject var closet: ClothingObject
    var body: some View {
        TabView {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }

            AddClothingView()
                .tabItem {
                    Label("Add \nClothing", systemImage: "tshirt.fill")
                }
            
            CreateOutfitView()
                .tabItem {
                    Label("Create \nan Outfit", systemImage: "plus.circle.fill")
                }
                
            ClosetView()
                .tabItem {
                    Label("Closet", systemImage: "list.dash")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
