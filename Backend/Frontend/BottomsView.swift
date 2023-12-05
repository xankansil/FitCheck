//
//  BottomsView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct BottomsView: View {

    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: PantsView()){
                    Text("Pants")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: ShortsView()){
                    Text("Shorts")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: LongSkirtsView()){
                    Text("Long Skirts")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: ShortSkirtsView()){
                    Text("Short Skirts")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: JeansView()){
                    Text("Jeans")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
            }
        }.navigationTitle("My Bottoms")
    }
}

#Preview {
    BottomsView()
}
