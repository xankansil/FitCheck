//
//  ShoesView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct ShoesView: View {

    var body: some View {
        Text("Shoes")
            .font(.system(size: 30))
            .foregroundStyle(.indigo)
            .border(Color.white)
        
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: SneakersView()){
                    Text("Sneakers")
                }
                NavigationLink(destination: DressShoesView()){
                    Text("Dress Shoes")
                }
            }
        }
    }
}

#Preview {
    ShoesView()
}
