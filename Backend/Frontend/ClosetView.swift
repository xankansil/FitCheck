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
            Text("Closet")
                .font(.system(size: 30))
                .foregroundStyle(.indigo)
                .border(Color.white)
            
            NavigationStack{
                VStack(spacing: 180)
                {
                    HStack(
                        spacing: 80
                    ) {
                        //make the button in a navigation link
                        
                        NavigationLink(destination: TopsView()){
                            Text("TOPS")
                            
                        }
                        
                        
                        NavigationLink(destination: BottomsView()){
                            Text("BOTTOMS")
                        }
                    }
                    
                    HStack(
                        spacing: 70
                    ) {
                        NavigationLink(destination: FullBodyView()){
                            Text("FULL BODY")
                        }
        
                        NavigationLink(destination: OuterWearView()){
                            Text("OUTERWEAR")
                        }
                        
                    }
                    
                    HStack(
                        spacing: 90
                    ) {
                        NavigationLink(destination: AccessoriesView()){
                            Text("ACCESSORIES")
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

struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView()
    }
}
