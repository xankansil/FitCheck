//
//  FullBodyView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct FullBodyView: View {
    
    var body: some View {
        Text("Full Body")
            .font(.system(size: 30))
            .foregroundStyle(.indigo)
            .border(Color.white)
        
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: JumpSuitView()) {
                    Text("Jumpsuits")
                }
                NavigationLink(destination: DressesView()) {
                    Text("Dresses")
                }
            }
        }
    }
}


#Preview {
    FullBodyView()
}
