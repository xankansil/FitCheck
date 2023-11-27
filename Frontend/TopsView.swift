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
        
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: TankTopView()){
                    Text("Tank Tops")
                }
                
                NavigationLink(destination: ShortSleeveView()){
                    Text("Short Sleeve")
                }
                
                NavigationLink(destination: LongSleeveView()){
                    Text("Long Sleeves")
                }
                NavigationLink(destination: SweaterView()){
                    Text("Sweaters")
                }
                NavigationLink(destination: CardiganView()){
                    Text("Cardigans")
                }
            }
        }
    }
}


#Preview {
    TopView()
}

