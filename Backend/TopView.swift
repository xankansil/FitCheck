//
//  TopView.swift
//  backend
//
//  Created by John S on 11/2/23.
//

import SwiftUI

struct TopView: View {
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        if userInfo.isLoggedIn{
//            HomeView()
            ContentView()
        } else {
            NavigationStack{
                LoginView()
            }
        }
    }
}

#Preview {
    TopView()
}
