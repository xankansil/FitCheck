//
//  userInfo.swift
//  backend
//
//  Created by John S on 11/2/23.
//

import Foundation

class UserInfo: ObservableObject{
    @Published var isLoggedIn: Bool!
    @Published var userName: String!
    
    init(){
        self.userName = ""
        self.isLoggedIn = false
    }
}
