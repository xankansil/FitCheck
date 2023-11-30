//
//  OuterWearView.swift
//  ClosetView
//
//  Created by Adalia Williams on 11/26/23.
//

import SwiftUI

struct OuterWearView: View {

    var body: some View {
        Text("OuterWear")
            .font(.system(size: 30))
            .foregroundStyle(.indigo)
            .border(Color.white)
        NavigationView{
            VStack(spacing: 20) {
                NavigationLink(destination: JacketsView()){
                    Text("Jackets")
                }
                NavigationLink(destination: CoatsView()){
                    Text("Coats")
                }
                NavigationLink(destination: VestsView()){
                    Text("Vests")
                }
            }
        }
    }
}


#Preview {
    OuterWearView()
}

