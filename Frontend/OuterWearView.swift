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
        VStack(spacing: 20) {
            Text("Jackets")
            Text("Coats")
            Text("Vests")
        
        }
        
    }
}


#Preview {
    OuterWearView()
}
