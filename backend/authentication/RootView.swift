//
//  RootView.swift
//  backend
//
//  Created by John S on 10/20/23.
//

import SwiftUI

struct RootView: View {
    
    @State private var signInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                Text("Settings")
            }
        }
        
        .onAppear(){
            //
        }
        .fullScreenCover(isPresented: $signInView, content: {
            NavigationStack{
                LoginView()
            }
        })
    }
}

#Preview {
    RootView()
}
