//
//  AccessoriesView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct AccessoriesView: View {

    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: JewleryView()){
                    Text("Jewlery")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: HatsView()){
                    Text("Hats")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: ScarfsView()){
                    Text("Scarfs")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                
            }
        }.navigationTitle("My Accessories")
    }
}


#Preview {
    AccessoriesView()
}
