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
        VStack(spacing: 20) {
            Text("Pants")
            Text("Shorts")
            Text("Long Skirts")
            Text("Short Skirts")
            Text("Jeans")
        }
    }
}


#Preview {
    BottomsView()
}
