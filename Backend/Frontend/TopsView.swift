//
//  TopsView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct TopsView: View {

    var body: some View {
        
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: TankTopView()){
                    Text("Tank Tops")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                
                NavigationLink(destination: ShortSleeveView()){
                    Text("Short Sleeve")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                
                NavigationLink(destination: LongSleeveView()){
                    Text("Long Sleeves")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: SweaterView()){
                    Text("Sweaters")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: CardiganView()){
                    Text("Cardigans")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
            }
        }.navigationTitle("My Tops")
    }
}

#Preview {
    TopsView()
}
