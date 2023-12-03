//
//  ContentView.swift
//  profilepage
//
//  Created by Xantia Kansil on 11/30/23.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    // INSERT PROFILE PHOTO HERE
                    Image(.emoji)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130)
                        .padding(8)
                        .padding()
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                VStack{
                    // NAME
                    Text("Xan Kansil")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .offset(x: -60, y: -20)
                    // INSERT BIO
                    Text("Favorite Season: Summer")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .offset(x: -20, y: -20)
                    Text("Favorite Clothing Item: low rise jeans")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .offset(x: 25, y: -20)
                    Text("Favorite Pair of Shoes: Adidas Sambas")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .offset(x: 33, y: -20)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                VStack{
                    // NAME
                    Text("Favorited Clothing")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .offset(x: -60, y: 40)
                }
                // INSERT FAVORITED CLOTHING HERE
                HStack{
                    Image(.img1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 200)
                        //.cornerRadius(22)
                        .offset(x: -0, y:30)
                    Image(.img2)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 185)
                        //.cornerRadius(22)
                        .offset(x: -0, y:30)
                }
                .padding()
                VStack{
                    HStack{
                        Image(.img3)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, height: 200)
                            //.cornerRadius(22)
                            .offset(x: -0, y:30)
                        Image(.img4)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, height: 185)
                            //.cornerRadius(22)
                            .offset(x: -0, y:30)
                    }
                    .padding()
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
