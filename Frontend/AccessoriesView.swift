//
//  AccessoriesView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct AccessoriesView: View {

    var body: some View {
        Text("Accessories")
            .font(.system(size: 30))
            .foregroundStyle(.indigo)
            .border(Color.white)
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: JewleryView()){
                    Text("Jewlery")
                }
                NavigationLink(destination: HatsView()){
                    Text("Hats")
                }
                NavigationLink(destination: ScarfsView()){
                    Text("Scarfs")
                }
                
            }
        }
    }
}


#Preview {
    AccessoriesView()
}
