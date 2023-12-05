//
//  OuterWearView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct OuterWearView: View {

    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: JacketsView()){
                    Text("Jackets")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: CoatsView()){
                    Text("Coats")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: VestsView()){
                    Text("Vests")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
            }
        }.navigationTitle("My Outerwear")
    }
}

#Preview {
    OuterWearView()
}
