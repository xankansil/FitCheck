//
//  FullBodyView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct FullBodyView: View {
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: JumpSuitView()) {
                    Text("Jumpsuits")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                NavigationLink(destination: DressesView()) {
                    Text("Dresses")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
            }
        }.navigationTitle("My Fullbody Items")
    }
}


#Preview {
    FullBodyView()
}
