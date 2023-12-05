//
//  ShoesView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct ShoesView: View {

    var body: some View {
        
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: SneakersView()){
                    Text("Sneakers")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: DressShoesView()){
                    Text("Dress Shoes")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
            }
        }.navigationTitle("My Shoes")
    }
}

#Preview {
    ShoesView()
}
