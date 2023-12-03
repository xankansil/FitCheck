//
//  BottomsView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//



import SwiftUI

struct BottomsView: View {

    var body: some View {
        Text("Bottoms")
            .font(.system(size: 30))
            .foregroundStyle(.indigo)
            .border(Color.white)
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: PantsView()){
                    Text("Pants")
                }
                NavigationLink(destination: ShortsView()){
                    Text("Shorts")
                }
                NavigationLink(destination: LongSkirtsView()){
                    Text("Long Skirts")
                }
                NavigationLink(destination: ShortSkirtsView()){
                    Text("Short Skirts")
                }
                NavigationLink(destination: JeansView()){
                    Text("Jeans")
                }
            }
        }
    }
}


#Preview {
    BottomsView()
}

