//
//  ClosetView.swift
//  frontend
// Adalias work
//
//  Created by Corinna Plefka on 11/5/23.
//
//This view will display all the items in a user's closet and also allow the user to search through items 

import SwiftUI

struct ClosetView: View {
    var body: some View {
        VStack(
            spacing: 10
        ) {
            //display the appname above buttons
            
            NavigationStack{
                VStack(spacing: 30)
                {
                    HStack(
                        spacing: 20
                    ) {
                        //make the button in a navigation link
                        NavigationLink(destination: TopsView()){
                            Text("TOPS")
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
                        NavigationLink(destination: BottomsView()){
                            Text("BOTTOMS")
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
                    }
                    
                    HStack(
                        spacing: 20
                    ) {
                        NavigationLink(destination: FullBodyView()){
                            Text("FULL BODY")
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
        
                        NavigationLink(destination: OuterWearView()){
                            Text("OUTERWEAR")
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
                        
                    }
                    
                    HStack(
                        spacing: 20
                    ) {
                        NavigationLink(destination: AccessoriesView()){
                            Text("ACCESSORIES")
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
                        
                        NavigationLink(destination: ShoesView()){
                            Text("SHOES")
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
                    }
                }.navigationTitle("My Closet")
            }
        }
    }
}

struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView()
    }
}
