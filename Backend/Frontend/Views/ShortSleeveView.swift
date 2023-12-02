//
//  ShortSleeveView.swift
//  Closet
//
//  Created by Adalia Williams on 11/27/23.
//

import SwiftUI


struct ShortSleeveView: View {
    @StateObject var closet = ClothingObject()
    var body: some View {
        Text("Short Sleeves")
            .font(.system(size: 30))
            .foregroundStyle(.indigo)
            .border(Color.white)
        var ShortSleeves = [ClothingType.shortsleeve]
        VStack{
        }
    }
}

#Preview {
    ShortSleeveView()
}
