//
//  ContentView.swift
//  realClosetApp
//
//

import SwiftUI

struct ContentView: View {

   
    var body: some View {
        NavigationView {
            LazyHStack {
                //Home
                NavigationLink(
                    destination: HomeDestinationView(),
                    label: {
                        Image(systemName: "house.fill")
                            .foregroundColor(.white)
                    })
                    .padding()
                    .background(.red)
                    .cornerRadius(8)
                    .position(x: 20, y: 700)
                
                //Add Clothing
                NavigationLink(
                    destination: AddClothingDestinationView(),
                    label: {
                        Image(systemName: "tshirt.fill")
                            .foregroundColor(.white)
                    })
                    .padding()
                    .background(.red)
                    .cornerRadius(8)
                    .position(x: 30, y: 700)
                
                //Create and outfit
                NavigationLink(
                    destination: CreateOutfitDestinationView(),
                    label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                    })
                    .padding()
                    .background(.red)
                    .cornerRadius(8)
                    .position(x: 35, y: 700)
                
                //My Closet
                NavigationLink(
                    destination: ClosetDestinationView(),
                    label: {
                        Text("Closet").foregroundColor(.white)
                            
                    })
                    .padding()
                    .background(.red)
                    .cornerRadius(8)
                    .position(x: 55, y: 700)
                
                NavigationLink(
                    destination: AccountDestinationView(),
                    label: {
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                    })
                    .padding()
                    .background(.red)
                    .cornerRadius(8)
                    .position(x:40, y: 700)
            }
            .font(.system(size: 18))
            .navigationTitle("Fit Check")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    //from https://sarunw.com/posts/navigation-in-swiftui/
}

struct HomeDestinationView: View {
    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .font(.largeTitle)
            Text("Home")
                .font(.headline)
            Text("This is where other users' oufits can be viewed")
                .font(.body)
        }
        .navigationTitle("Home Page") // <1>
    }
}

struct AddClothingDestinationView: View {
    var body: some View {
        VStack {
            Image(systemName: "tshirt.fill")
                .font(.largeTitle)
            Text("Add Clothing")
                .font(.headline)
            Text("This is where the user will be able to upload clothing into their closet")
                .font(.body)
        }
        .navigationTitle("Upload Clothing") // <1>
    }
}

struct CreateOutfitDestinationView: View {
    var body: some View {
        VStack {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
            Text("Create an Outfit")
                .font(.headline)
            Text("This is where the user will be able to create an outfit using clothing items from their closet")
                .font(.body)
        }
        .navigationTitle("Create an Outfit") // <1>
    }
}

struct ClosetDestinationView: View {
    var body: some View {
        VStack {
            Image(systemName: "hanger")
                .font(.largeTitle)
            Text("Your Closet")
                .font(.headline)
            Text("This is where the user will be able to view all of the clothing they have uploaded")
                .font(.body)
        }
        .navigationTitle("Closet") // <1>
    }
}

struct AccountDestinationView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .font(.largeTitle)
            Text("Account")
                .font(.headline)
            Text("This is where the user will be able to view their own account and add their favorite outfits")
                .font(.body)
        }
        .navigationTitle("My Account") // <1>
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
