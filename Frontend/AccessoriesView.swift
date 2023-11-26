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
        
        VStack(spacing: 20) {
            Text("Jewlery")
            Text("Hats")
            Text("Scarfs")
            
        }
    }
}


#Preview {
    AccessoriesView()
}
