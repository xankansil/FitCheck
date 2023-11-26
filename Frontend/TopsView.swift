//
//  TopView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct TopView: View {

    var body: some View {
        Text("Tops")
            .font(.system(size: 30))
            .foregroundStyle(.indigo)
            .border(Color.white)
        
        VStack(spacing: 20) {
            Text("Tank Tops")
            Text("Short Sleeve")
            Text("Long Sleeves")
            Text("Sweaters")
            Text("Cardigans")
        }
    }
}


#Preview {
    TopView()
}

